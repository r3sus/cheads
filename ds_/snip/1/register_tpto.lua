-- register_tpto.lua
function tpto(x2) -- global function you could use anywhere after executing
local x1 = {} -- local array for multiple vars 
x1.base = '[[[[[[PlayerBaseSTAddress]+10]+38]+1090]+28]+AA0]+[coordinateIndex]*4'
x1.ofs = {'+8','+8+27140','','+27140','+4','+4+27140'}
for i = 1,6 do writeFloat(x1.base..x1.ofs[i],x2[i]) end
return

-- and the entry script would look like this
local x2 = {-38.327072143555,1,3,4,5,6}
tpto(x2)
