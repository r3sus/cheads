// ds1 Intro removal in ASL

state("Dead Space")
{
}


init {

// var addr = (IntPtr)0x00C7B13C;

// aob scan to ensure working for any version
var page = modules.First();
var scanner = new SignatureScanner(game, page.BaseAddress, page.ModuleMemorySize);

string s2 = "ExitToWindows";  // nearby string that isn't modified
byte[] b1 = Encoding.ASCII.GetBytes(s2);

IntPtr addr = scanner.Scan(new SigScanTarget(0, b1))+0x13C-0xF4;
// scan end

string s1 = "XCENTKOWSK_C78C369_F71988A_v3";
byte[] bytes = Encoding.ASCII.GetBytes(s1);

int s1l = s1.Length;

// making the memory region writable
MemPageProtect oldProtect;
game.VirtualProtect(addr, s1l, MemPageProtect.PAGE_EXECUTE_READWRITE, out oldProtect);
memory.WriteBytes(addr,bytes);
game.VirtualProtect(addr, s1l, oldProtect);

print("Intro removed");

}

update{
}
