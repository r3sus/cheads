local msg

local function printDw(data)
print(string.format("%08X",data) )
end

local function bt2aob(data)
    local s = ""
    for i = 1,#data  do
        s = s .. string.format("%02X ", data[i])
    end
    return s
end

local function int2aob(data)
    return bt2aob(dwordToByteTable(data))
end

local function str2aob(data)
    return bt2aob(stringToByteTable(data))
end

local function isF()
return getMainForm().ProcessLabel.Caption=='Physical Memory'
end

local function msList2ar(AV_MS_List)

local AV_D = {}

for i=1,AV_MS_List.Count do
AV_D[i] = tonumber(AV_MS_List[i-1],16);
end

AV_MS_List.deinitialize()
AV_MS_List.destroy()

return AV_D
end

local function aOBScanF(data)
local AV_MS=createMemScan()

AV_MS.firstScan(soExactValue, vtByteArray, '', data, '',
0 ,-1 , '' ,fsmNotAligned ,'' ,true ,true, false, false);

AV_MS.waitTillDone()

local AV_MS_List=createFoundList(AV_MS)

AV_MS_List.initialize()
AV_MS.destroy()

return msList2ar(AV_MS_List)
end

local function aOBScanFoP(data)
local l = {}
if isF() then return aOBScanF(data) end
l.x = aOBScan(data)
return msList2ar(l.x)
end

local function aOBScan1FoP(data)
if isF() then return aOBScanF(data)[1] end
return aOBScanUnique(data)
end

local function findStringAdr(str)
 local l = {}
 l.as = str2aob(str)
 l.adr = aOBScan1FoP(l.as) + 1
 return l.adr
end

local function findStringRefs(str)
 local l = {}
 l.x = findStringAdr(str)
 l.x = int2aob(l.x)
 l.x = aOBScanFoP("68 "..l.x)
 return l.x
end

local function findStringRef1(str)
 local l = {}
 l.x = findStringAdr(str)
 l.x = int2aob(l.x)
 l.x = aOBScan1FoP("68 "..l.x)+0
 return l.x
end

local function find1()

local l = {}
l.o = findStringRef1("\0print\0")
for i=1,100 do
 l.tmp = readBytes(l.o+i,3,true)
 if bt2aob(l.tmp) == "C7 40 0C " then l.out=l.o+i; break; end
end

return l.out+3
end

local function findFunctionStart(o)
local l={};l.o=o
for i=1,100 do
 l.buf = readBytes(l.o-i-2,2,true)
 if bt2aob(l.buf) == "CC CC " then l.out=l.o-i; break; end
end
return l.out
end

local function find2()

local l = {}
l.x = findStringRefs("\0tostring\0")
l.y = {}
for i = 1,#l.x do l.y[i]=findFunctionStart(l.x[i]) end

return l.y
end

local function printSwap()

local l = {}
l.x = find1()
l.x1 = readInteger(l.x)
l.y = find2()
l.i = l.y[2]
l.m = 'relocat'
if l.x1 == l.i then l.i = l.y[1];l.m = 'restor' end
writeInteger(l.x,l.i)
msg = msg .. 'print '..l.m..'ed\n'

end

local function find3()

local l = {}
l.o = findStringAdr("end\nend\n") + 11
l.a = "function debug_print(flag, str)\nend\nfunction debug_screenprint(flag, str)\nend\n"
l.b = "local s = '_user/lua_inj/_inj.lua'; loadfile(s); dofile(s);"
l.c = readString(l.o,100)
--print(l.c)
l.d = l.b; l.e = 'patch';
if l.c == l.b then l.d = l.a;l.e = 'restor' end
--writeString(l.o,l.d)
l.d1 = stringToByteTable(l.d)
table.insert(l.d1,0)
writeBytes(l.o,l.d1)
msg = msg .. 'string '..l.e..'ed\n'
return
end

local function main()
local l = {}
l.n = "godfather2.exe"
l.n1 = '../../'..l.n
msg = ""
l.pf = messageDialog('Patch File(Y) or RAM(N)?', mtInformation,mbYes, mbNo)==mrYes
if l.pf then openFileAsProcess(l.n1,false,0x400000) end
printSwap()
find3()
if l.pf then saveOpenedFile(l.n1) end
showMessage(msg..'done\n')
end

main()

