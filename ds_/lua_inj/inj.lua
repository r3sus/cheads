print('inj start')

function pfs(fn,flag, str)
local c = ' : '
print(fn..c..str..c..tostring(flag) )
end

function debug_print(flag, str)
--pfs('r',flag, str)
print(str)
end

function debug_screenprint(flag, str)
print(str)
--pfs('c',flag, str)
end

print('inj end')