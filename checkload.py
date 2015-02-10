#!/usr/bin/env python
import psutil
import os
def to_red(s):
    return '\033[1;31m' + s + '\033[1;m'
def to_green(s):
    return '\033[1;32m' + s + '\033[1;m'
def to_yellow(s):
    return '\033[1;33m' + s + '\033[1;m'
cpu = sum([p for p in psutil.cpu_percent(interval=1, percpu=True)]) / psutil.cpu_count()
memory = psutil.virtual_memory()
avail_memory_gb = memory.available / 2**30
total_memory_gb = memory.total / 2**30
output = os.uname()[1] + ' | avg load: %3.0f%% | memory: %3.0fGB/%3.0fGB | # cpus : %d ' % (cpu, avail_memory_gb, total_memory_gb, psutil.cpu_count())
if cpu < 10:
    print to_green(output)
elif 10 <= cpu <= 30:
    print to_yellow(output)
else:
    print to_red(output)
    
