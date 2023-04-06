function b2s (a)
--a = bytes
b = {}
c = {}
for i = 1,16 do
--y = string.format("%02X", x)
--z = string.char(x)
x = a:sub(i,i)
y = x:byte()
if y == 0 then return end
y = string.format("%02X", y)
b[i]=y
c[i]=x
end

s1 = "X"
for i = 9,16 do s1 = s1 .. c[i] end
s1 = s1..c[4].."_"
for i = 3,1,-1 do s1 = s1 .. b[i] end
--print(s1)
s1 = s1..b[8]:sub(1,1).."_"..b[8]:sub(2)
for i = 7,5,-1 do s1 = s1 .. b[i] end
s1 = s1.."_v3"
return s1
end

local f = assert(io.open(arg[1], "rb"))
local block = 16
x = 0
sa = {}
	while true do
local bytes = f:read(block)
if not bytes then break end
--print(bytes)
s = b2s(bytes)
print(s)
table.insert(sa, s)
--print(s1)
	end

local out = assert(io.open(arg[2], "w"))

	for i,x in pairs(sa) do
out:write(x,":",i,"\n")
	end	
out:close()