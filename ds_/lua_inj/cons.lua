local l = {}
l.n = "godfather2.exe"
l.n1 = '../../'..l.n
openFileAsProcess(l.n1)
-- src: EXE_CONSOLE_CHANGER.py
l.a = readInteger(0x3c)
l.b = readInteger(l.a)
if l.b ~= 0x4550 then  print ("not PE") end
l.a1 = l.a + 0x5C
l.c = readByte(l.a1)
l.d = 3
if l.c == 3 then l.d = 2; print('restoring') else print('patching') end
writeByte(l.a1,l.d)
saveOpenedFile(l.n1)
