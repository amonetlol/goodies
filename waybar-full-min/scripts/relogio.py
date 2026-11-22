#!/usr/bin/env python3
# relogio.py "<formato strftime>" — módulo custom da waybar: texto = data/hora em pt-BR; tooltip = calendário de 3 meses
# (anterior, atual, próximo) com o dia de hoje no destaque do tema. Saída JSON (return-type json).
import calendar, datetime, json, re, sys
from pathlib import Path
DIAS = ['dom', 'seg', 'ter', 'qua', 'qui', 'sex', 'sáb']
MESES = ['janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho', 'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro']
fmt = sys.argv[1] if len(sys.argv) > 1 else '%a, %d/%m  %H:%M'
hoje = datetime.datetime.now()
try:
    ac = re.search(r'@define-color accent\s+(#[0-9A-Fa-f]{6})', (Path(__file__).resolve().parent.parent / 'colors.css').read_text()).group(1)
except Exception:
    ac = '#ffffff'
txt = fmt.replace('%a', DIAS[(hoje.weekday() + 1) % 7]).replace('%A', DIAS[(hoje.weekday() + 1) % 7])
txt = txt.replace('%B', MESES[hoje.month - 1]).replace('%b', MESES[hoje.month - 1][:3])
txt = hoje.strftime(txt)

def mes(a, m):
    c = calendar.Calendar(firstweekday=6)  # semana começa no domingo
    linhas = [f'{MESES[m - 1]} {a}'.center(20), 'do se te qu qu sá sa']
    for sem in c.monthdayscalendar(a, m):
        cel = []
        for d in sem:
            s = f'{d:2d}' if d else '  '
            if d and (a, m, d) == (hoje.year, hoje.month, hoje.day):
                s = f"<span color='{ac}'><b><u>{s}</u></b></span>"
            cel.append(s)
        linhas.append(' '.join(cel))
    while len(linhas) < 8:
        linhas.append(' ' * 20)
    return linhas

meses = []
for k in (-1, 0, 1):
    m = hoje.month + k; a = hoje.year
    if m < 1: m, a = 12, a - 1
    if m > 12: m, a = 1, a + 1
    meses.append(mes(a, m))
def larg(s):  # largura visível (sem as tags pango)
    return len(re.sub(r'<[^>]+>', '', s))
tip = '\n'.join('   '.join(c + ' ' * (20 - larg(c)) for c in linha) for linha in zip(*meses))
print(json.dumps({'text': txt, 'tooltip': f'<tt>{tip}</tt>'}, ensure_ascii=False))
