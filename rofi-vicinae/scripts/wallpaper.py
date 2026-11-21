#!/usr/bin/env python3
# seletor de wallpaper (rofi em grade) para Wayland: aplica com swaybg (wallpaper-apply)
from pathlib import Path
import subprocess
root = Path(__file__).resolve().parent
folder = Path('/home/share/wallpapers')
images = sorted(p for p in folder.rglob('*') if p.is_file() and p.suffix.lower() in ('.png', '.jpg', '.jpeg', '.webp') and '\n' not in str(p))
if not images:
    raise SystemExit('Nenhum wallpaper encontrado em ' + str(folder))
rows = ''.join(str(p.relative_to(folder)) + '\0icon\x1f' + str(p) + '\n' for p in images)
r = subprocess.run(['rofi', '-theme', str(Path.home() / '.config/rofi/lumon/rofi-wallpaper-preview.rasi'), '-dmenu', '-show-icons', '-i', '-p', 'Wallpaper', '-format', 'i', '-no-custom'], input=rows, text=True, stdout=subprocess.PIPE)
if r.returncode or not r.stdout.strip():
    raise SystemExit(0)
image = images[int(r.stdout)]
subprocess.run([str(Path.home() / '.local/bin/wallpaper-apply'), str(image)], check=True)
