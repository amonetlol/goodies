#!/usr/bin/env bash
python3 - <<'PY'
from datetime import datetime
# Python weekday(): Mon=0 .. Sun=6
days = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sáb", "Dom"]
months = ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
n = datetime.now()
print(f"{days[n.weekday()]} {n.day:02d} {months[n.month-1]}")
PY
