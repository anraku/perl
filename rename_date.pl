#!perl
my $outDir="cdstestdata";
foreach my $inFile (glob("*.txt")){
	mkdir $outDir;
	open(IN, "<$inFile");
	open(OUT, ">$outDir\\$inFile");
	while(my $line = <IN>){
		$line =~ s/2015-11-05/2015-12-01/g;
		print OUT $line;
	}
	close(OUT);
	close(IN);
}