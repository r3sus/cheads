local function nums2xstr (nums)
local hexts,chars,xstr = {}
chars = {}
for i,n in pairs(nums) do
-- interpretation of number n: (75)
hexts[i] = string.format("%02X", n) -- hex text (4B)
chars[i] = string.char(n) -- char (K)
end

xstr = "X"
for i = 9,16 do xstr = xstr .. chars[i] end
xstr = xstr..chars[4].."_"
for i = 3,1,-1 do xstr = xstr .. hexts[i] end
xstr = xstr..hexts[8]:sub(1,1).."_"..hexts[8]:sub(2)
for i = 7,5,-1 do xstr = xstr .. hexts[i] end
xstr = xstr.."_v3"
return xstr -- aka xv3, xstr, xtr (ikstr)
end

local function hext2nums (hext)
local t={}
--hext:gsub('%x+',function(n) t[#t+1] = tonumber(n,16) end)
for n in string.gmatch(hext, "[^%s]+") do -- thanks to Hugo for this SO answer https://stackoverflow.com/a/3693663
   t[#t+1] = tonumber(n,16)
end
return t
end

local function hext2xstr (hext)
local nums = hext2nums(hext)
return nums2xstr(nums)
end

-- parse: drop-down to v&d
local function dd2vnd (dd)
local x1 = {}
x1.pos = dd:find(':')
x1.val = dd:sub(0,x1.pos-1)
x1.desc = dd:sub(x1.pos+1)
return x1.val,x1.desc
end

local function dd_b2x (bdd)
local x1 = {}
x1.hext,x1.name = dd2vnd(bdd)
x1.xstr = hext2xstr(x1.hext)
x1.xdd = x1.xstr..':'..x1.name
--string.format("%s:%s",x1.xstr,x1.name)
return x1.xdd
end

local function main()
local x1 = {}
x1.bdd = "4E FF C9 30 98 04 D0 44 50 49 54 54 53 31 30 32:PatientSuit"
x1.xdd = dd_b2x(x1.bdd)
print(x1.xdd)
end

--[[
agenda:
 bdd, xdd, sdd - bytes/X/string drop-down
  / cedds / ceb entry / sdd
 hxt - hex text
  / ceb - CE bytes string / ces / cebs /
 xvt - aka xv3, xstr, xtr (ikstr)
 aon - array of numbers (bytes)
 ddp - drop-down (entry) parse
]]--

main()
