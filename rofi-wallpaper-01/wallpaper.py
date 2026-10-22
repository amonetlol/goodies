#!/usr/bin/env python3
from pathlib import Path
import os, subprocess
root=Path(__file__).resolve().parent
folder=Path.home()/'Imagens/wallpapers'
images=sorted(p for p in folder.rglob('*') if p.is_file() and p.suffix.lower() in ('.png','.jpg','.jpeg','.webp') and '\n' not in str(p))
if not images: raise SystemExit('Nenhum wallpaper encontrado em '+str(folder))
rows=''.join(str(p.relative_to(folder))+'\0icon\x1f'+str(p)+'\n' for p in images)
r=subprocess.run(['rofi','-config',str(root/'config.rasi'),'-theme',str(root/'wallpaper.rasi'),'-dmenu','-show-icons','-i','-p','Wallpaper','-format','i','-no-custom'],input=rows,text=True,stdout=subprocess.PIPE)
if r.returncode or not r.stdout.strip(): raise SystemExit(0)
image=images[int(r.stdout)]
state=Path(os.environ['XDG_RUNTIME_DIR'])/'hypr-vora-wallpaper.pid'
if state.exists():
    try:
        pid=int(state.read_text())
        if Path(f'/proc/{pid}/exe').resolve()==Path('/usr/bin/swaybg'): os.kill(pid,15)
    except (OSError,ValueError): pass
with open(os.devnull,'w') as sink:
    p=subprocess.Popen(['swaybg','-i',str(image),'-m','fill'],stdout=sink,stderr=sink,start_new_session=True)
state.write_text(str(p.pid)+'\n')
