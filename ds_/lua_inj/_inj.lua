local l = '[inj] : '
print(l..'start')

local function pfs(fn,flag,str)
local l = {}
l.s = string.format( "[%s] : %s : %s",fn,str,tostring(flag) )
print(l.s)
end

function debug_print(flag, str)
pfs('DP',flag,str)
end

function debug_screenprint(flag, str)
pfs('DSP',flag,str)
end

function EclipseLog(str)
print('[EL] : '..str) 
end

print(l..'end')