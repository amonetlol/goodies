#!/usr/bin/env python3
# seletor de wallpaper (Super+F10): grade no rofi (OutTheme/Traffic), aplica com feh
from pathlib import Path
import subprocess
folder = Path.home() / 'Imagens/wallpapers'
theme = Path.home() / '.config/rofi/rofi-top-01/wallpaper.rasi'
images = sorted(p for p in folder.rglob('*') if p.is_file() and p.suffix.lower() in ('.png', '.jpg', '.jpeg', '.webp') and '\n' not in str(p))
if not images:
    subprocess.run(['notify-send', 'Wallpaper', f'Nenhuma imagem em {folder}'])
    raise SystemExit(1)
rows = ''.join(str(p.relative_to(folder)) + '\0icon\x1f' + str(p) + '\n' for p in images)
r = subprocess.run(['rofi', '-dmenu', '-show-icons', '-i', '-no-custom', '-p', 'wallpaper', '-format', 'i', '-theme', str(theme)],
                   input=rows, text=True, stdout=subprocess.PIPE)
if r.returncode or not r.stdout.strip():
    raise SystemExit(0)
image = images[int(r.stdout)]
cache = Path.home() / '.cache/rofi-top-01'
cache.mkdir(parents=True, exist_ok=True)
(cache / 'last-wallpaper').write_text(str(image))
subprocess.run(['feh', '--no-fehbg', '--no-xinerama', '--bg-fill', str(image)], check=True)
