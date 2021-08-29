$p1=$env:LOCALAPPDATA+"\EA Games\Dead Space 2\"
cd $p1
$fn1="settings.txt"

if (test-path $fn1) {} else {echo 'not found';pause;exit;}

$be=(test-path b$fn1)

$chZo='Choose the option: 0 - NG, 1 - HC, 2 - NG+'
if ($be) {$chZo+=', 3 - restore backup';$m=3} else {copy $fn1 b$fn1;$m=2}

$o=Read-Host $chZo

if ($o -in 0..$m) {} else {echo 'OoB';pause;exit;}

if ($be -And $o -eq 3) {move b$fn1 $fn1 -force; echo 'Restored'; pause; exit;}
$a = Get-Content $fn1

$a[14]='Controls.AcL.X = 0x000'
$a[14]+=if ($o -eq 1) {'10000'} else {'00000'}

$a[15]='Controls.AcL.Y = 0x0000'
$a[15]+=if ($o -eq 2) {'4000'} else {'0'*4}

echo $a[14,15]

if ($o -eq 1) {$a[16]='Game.PDiff = 1'; $a[17]='Game.Played = 1';echo $a[16,17]}

$a | Set-Content $fn1
echo 'done'
pause