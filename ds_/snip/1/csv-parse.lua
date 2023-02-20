--[[
csv-parse.lua
WIP script for reading positions from CSV file
CSV format: Group,Name,X,Y,Z,X,Y,Z
bugs: if comma presented in name
issues: no safety asserts (format checks)
todo: add GUI: options:
- showSelectionList (first select group, then name)
con: >time to select, unhandy for repeatable usage of same pos and hotkey assign
- CE Form capable or rendering table
(todo: check what is treeView)
- dynamic
generate table entries on the fly, the same way it was done, but automatically
  issues:
   need to avoid duplicates by removing pos list if it was already added
   check might be implemented by specific group name like "POSLIST"
]]--

local x1 = {}
x1.c = {}
for line in io.lines('1.csv') do
--print(line)
x1.b = {}
     for w in string.gmatch(line, "(.-),") do
       --print(w)
       table.insert(x1.b,w)
     end
     table.insert(x1.c,x1.b)
end
for j = 1,#x1.c do x1.b = x1.c[j]
for i = 1,#x1.b do --print('a = '..x1.b[i])
end
end

-- convert str to float with tonumber

print(os.date())

