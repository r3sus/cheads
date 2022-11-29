// desp1 NRV and nointro setup

state("Dead Space")
{
}

init {

// aob scan to ensure working for any version
var page = modules.First();
var scanner = new SignatureScanner(game, page.BaseAddress, page.ModuleMemorySize);

string[] s3s1 = {
	// nointro:
	"XCENTKOWSK_C8A99CD_622DBBB_v3",
	"XCENTKOWSK_C78C369_F71988A_v3",
	// NRV:
	"movies",
	"moviez",
};

for (byte i = 0; i < s3s1.Count(); i+=2)
{
string str1 = s3s1[i];  
byte[] bys1 = Encoding.ASCII.GetBytes(str1);
 
IntPtr addr = scanner.Scan(
new SigScanTarget(0, bys1) 
);

if (addr == (IntPtr)0) {
	print("not found: "+str1);
	continue;
}
else 
	print(str1+addr.ToString()); 

str1 = s3s1[i+1];
bys1 = Encoding.ASCII.GetBytes(str1);
int slen = str1.Length;	

MemPageProtect oldProtect;
game.VirtualProtect(addr, slen, MemPageProtect.PAGE_EXECUTE_READWRITE, out oldProtect);
memory.WriteBytes(addr,bys1);
game.VirtualProtect(addr, slen, oldProtect);
};

print("DS1 setup finished");

}

update{
}
 