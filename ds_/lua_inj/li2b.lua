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

local function findStringAdr(str)
 local l = {}
 l.as = str2aob(str)
 l.adr = aOBScanUnique(l.as) + 1
 return l.adr
end

local function findStringRefs(str)
 local l = {}
 l.x = findStringAdr(str)
 l.x = int2aob(l.x)
 l.x = aOBScan("68 "..l.x)
 l.y = {}
 for i = 1,l.x.Count do l.y[i]=tonumber(l.x[i-1],16) end
 l.x.destroy()
 return l.y
end

local function find1()

local l = {}
l.o = findStringRefs("\0print\0")[1]
for i=1,100 do
 l.tmp = readBytes(l.o+i,3,true)
 if bt2aob(l.tmp) == "C7 40 0C " then l.out=l.o+i break end
end

return l.out+3
end

local function findFunctionStart(o)
local l={};l.o=o
for i=1,100 do
 l.buf = readBytes(l.o-i-2,2,true)
 if bt2aob(l.buf) == "CC CC " then l.out=l.o-i break end
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

local function printDw(data)
print(string.format("%08X",data) )
end

local function printSwap()

local l = {}
l.x = find1()
l.x1 = readInteger(l.x)
l.y = find2()
l.i = l.y[2]
if l.x1 == l.i then l.i = l.y[1];showMessage('restoring') else showMessage('patching') end
writeInteger(l.x,l.i)

end

local function find3()

local l = {}
l.o = findStringAdr("end\nend\n") + 11
l.a = "function debug_print(flag, str)\nend\nfunction debug_screenprint(flag, str)\nend\n"
l.b = "local s = '_user/lua_inj/inj.lua'; loadfile(s); dofile(s);"
l.c = readString(l.o,100)
--print(l.c)
l.d = l.b
if l.c == l.b then l.d = l.a;showMessage('restoring') else showMessage('patching') end
--writeString(l.o,l.d)
l.d1 = stringToByteTable(l.d)
table.insert(l.d1,0)
writeBytes(l.o,l.d1)

return
end

local function main()

printSwap()
find3()
showMessage('done')

end

main()

