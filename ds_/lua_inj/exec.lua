local function main()
  local l = {}
  l.n = "godfather2.exe"
  l.n1 = '../../'..l.n
  createProcess(l.n1)
  sleep(1000)
  openProcess(l.n)
end

main()
