#!/usr/bin/env python3
"""Format Hyprland binds for rofi.

Prefer parsing `hyprctl binds` text output: on current Hyprland Lua builds,
`hyprctl binds -j` emits shifted/invalid JSON (modmask/key/description wrong).
Also accepts JSON stdin if it is well-formed.
"""
from __future__ import annotations

import json
import re
import sys

MOD_BITS = [
    (64, "SUPER"),
    (8, "ALT"),
    (4, "CTRL"),
    (1, "SHIFT"),
    (2, "CAPS"),
    (16, "MOD2"),
    (32, "MOD3"),
    (128, "MOD5"),
]


def combo_from_modmask(modmask: int, key: str) -> str:
    parts = [name for bit, name in MOD_BITS if modmask & bit]
    parts.append(key or "?")
    return "+".join(parts)


def parse_text(raw: str) -> list[dict]:
    binds: list[dict] = []
    cur: dict | None = None
    for line in raw.splitlines():
        if re.match(r"^bind", line):
            if cur:
                binds.append(cur)
            cur = {
                "modmask": 0,
                "submap": "",
                "key": "",
                "keycode": 0,
                "description": "",
                "dispatcher": "",
                "arg": "",
            }
            continue
        if cur is None:
            continue
        m = re.match(r"^\s*([A-Za-z0-9_]+):\s*(.*)$", line)
        if not m:
            continue
        field, value = m.group(1), m.group(2)
        if field == "modmask":
            try:
                cur["modmask"] = int(value)
            except ValueError:
                cur["modmask"] = 0
        elif field == "submap":
            cur["submap"] = value
        elif field == "key":
            cur["key"] = value
        elif field == "keycode":
            try:
                cur["keycode"] = int(value)
            except ValueError:
                cur["keycode"] = 0
        elif field == "description":
            cur["description"] = value
        elif field == "dispatcher":
            cur["dispatcher"] = value
        elif field == "arg":
            cur["arg"] = value
    if cur:
        binds.append(cur)
    return binds


def parse_json(raw: str) -> list[dict] | None:
    try:
        data = json.loads(raw)
    except json.JSONDecodeError:
        return None
    if not isinstance(data, list):
        return None
    # Detect the broken shifted schema from some Hyprland builds
    if data:
        sample = data[0]
        # Healthy JSON has numeric modmask and string key
        if not isinstance(sample.get("modmask"), int):
            return None
        if not isinstance(sample.get("key"), str):
            return None
    return data


def format_lines(binds: list[dict]) -> list[str]:
    lines: list[str] = []
    for b in binds:
        if b.get("submap"):
            continue
        key = b.get("key") or (f"code:{b.get('keycode')}" if b.get("keycode") else "?")
        try:
            modmask = int(b.get("modmask") or 0)
        except (TypeError, ValueError):
            modmask = 0
        combo = combo_from_modmask(modmask, str(key))
        desc = (b.get("description") or "").strip()
        if not desc:
            dispatcher = b.get("dispatcher") or ""
            arg = b.get("arg") or ""
            if dispatcher and dispatcher != "__lua":
                desc = f"{dispatcher} {arg}".strip()
            else:
                desc = "(no description)"
        lines.append(f"{combo} — {desc}")

    merged: dict[str, str] = {}
    for line in lines:
        key, _, desc = line.partition(" — ")
        if key in merged and desc not in merged[key]:
            merged[key] = f"{merged[key]} + {desc}"
        else:
            merged.setdefault(key, desc)
    return [f"{k} — {v}" for k, v in merged.items()]


def main() -> None:
    raw = sys.stdin.read()
    binds = parse_json(raw)
    if binds is None:
        binds = parse_text(raw)
    for line in format_lines(binds):
        print(line)


if __name__ == "__main__":
    main()
