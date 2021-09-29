state("deadspace2")
{
}


init { 
    var page = modules.First();
	vars.isl = null;
	var scanner = new SignatureScanner(game, page.BaseAddress, page.ModuleMemorySize);
	var lAoB = "00 8A 5C 24 10 88 1D ";
    var ptr = scanner.Scan(new SigScanTarget(lAoB.Length/3, lAoB)); 
	vars.isl = new MemoryWatcher<bool>(new DeepPointer(ptr,0));
	} 

update{
	vars.isl.Update(game);
}

isLoading {
return vars.isl.Current;
}
