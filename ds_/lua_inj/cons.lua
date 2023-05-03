local function tglxmd() -- src: EXE_CONSOLE_CHANGER.py at https://forum.xentax.com/viewtopic.php?t=22605
local l = {}
  l.a = readInteger(0x3c)
  l.b = readInteger(l.a)
  if l.b ~= 0x4550 then showMessage("error. not PE"); return; end
  l.a1 = l.a + 0x5C
  l.c = readByte(l.a1)
  l.d = 3
  if l.c == 3 then l.d = 2 end
  writeByte(l.a1,l.d)
return l.c;
end  

local function ons(path)
  local l = {}; l.n1 = path;
  openFileAsProcess(l.n1)
  l.c = tglxmd()
  if l.c then saveOpenedFile(l.n1) else return end
  l.d = 'patched'; if l.c == 3 then l.d = 'restored' end
  showMessage(l.d)
end

local function main()
  local l = {}
  l.n = "godfather2.exe"
  l.n1 = '../../'..l.n
  ons(l.n1);
  --[[
  if messageDialog('launch game?', mtInformation,mbYes, mbNo)==mrYes then
  createProcess(l.n1)
  sleep(1000)
  openProcess(l.n)
  end
  ]]--
end

main()
