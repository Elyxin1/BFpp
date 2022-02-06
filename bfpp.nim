from os import paramStr, paramCount
from strutils import split, parseInt
if paramCount() == 0: echo "input file missing (bfpp.exe main.bfpp)"; system.quit 0
let
    file: File = open paramStr 1
    text: string = file.readAll
    raw: seq[string] = text.split()
var 
    mem1: int16 = 0
    mem2: int16 = 0
    memoryPointer: bool = false
    progress: int = -1
    focus: string
proc advance(r: bool): string =
    inc progress
    focus = raw[progress]
    if r:
        return raw[progress]
while true:
    discard advance(false)
    if focus == "+":
        mem1 = mem1 + mem2
    elif focus == "-":
        mem1 = mem1 - mem2
    elif focus == "s":
        memoryPointer = not memoryPointer
    elif focus == "" or focus == "\n": discard 0
    elif focus == "dir":
        stdout.write "down:" & $mem1 & " up:" & $mem2
    elif focus == "o":
        echo (if memoryPointer: mem2 else: mem1)
    elif focus == "p":
        stdout.write chr (if memoryPointer: mem2 else: mem1)
    elif focus == ";":
        system.quit 0
    elif focus == "goto":
        if (if memoryPointer: mem2 else: mem1) > 0: progress = (parseInt advance(true)); (if memoryPointer: dec mem2 else: dec mem1)
    elif focus == "d":
        if (if memoryPointer: mem2 else: mem1) > (parseInt advance(true)): progress = (parseInt advance(true)); (if memoryPointer: dec mem2 else: dec mem1)
    elif focus == "u":
        if (if memoryPointer: mem2 else: mem1) < (parseInt advance(true)): progress = (parseInt advance(true)); (if memoryPointer: inc mem2 else: inc mem1)
    elif focus == "inc":
        (if memoryPointer: inc mem2 else: inc mem1)
    elif focus == "dec":
        (if memoryPointer: inc mem2 else: inc mem1)
    elif focus == "i":
        if memoryPointer: mem2 = int16 parseInt stdin.readLine else: mem1 = int16 parseInt stdin.readLine
    else:
        if memoryPointer: mem2 = int16 parseInt focus
        else: mem1 = int16 parseInt focus