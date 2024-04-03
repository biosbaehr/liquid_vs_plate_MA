#!/usr/bin/perl

open OUT1, ">/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/all_mut_snm.txt";
open OUT2, ">/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/all_mut_indels.txt";

open GENELIST1, "/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/data/NC_000913/RNAgenes_EcoCyc_MG1655.txt";
open GENELIST2, "/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/data/NC_000913/pseudogenes_EcoCyc_MG1655.txt";

my %geneListRNA;
my %geneListPseudo;

while (my $line = <GENELIST1>){
	chomp($line);
	my @temp = split(/\t/, $line);
	if($temp[0] ne ""){
		$geneListRNA{$temp[0]} = 1;
	} 
}
close GENELIST1;

while (my $line = <GENELIST2>){
	chomp($line);
	my @temp = split(/\t/, $line);
	if($temp[0] ne ""){
		$geneListPseudo{$temp[0]} = 1;
	} 
}
close GENELIST2;

my %all_mut_snm_count;
my %all_mut_indels_count;

#my @name1List = ("D14L02","D15L02","D16L02")
#my @name2List = ("69","70","71")

#my @name1List = ("D20P37")
#my @name2List = ("64")

my @name1List = ("D20L01","D20L02","D20L03","D20L04","D20L05","D20L06","D20L07","D20L08","D20L09","D20L10","D20L11","D20L12","D20L13","D20L14","D20L15","D20L16","D20P25","D20P26","D20P27","D20P28","D20P29","D20P30","D20P31","D20P32","D20P33","D20P34","D20P35","D20P36","D20P38","D20P39","D20P40");
my @name2List = ("121","122","123","124","125","1","2","3","4","13","14","15","16","41","42","43","44","45","46","47","48","57","58","59","60","61","62","63","65","66","67");

my @completeNameList = ();

foreach my $i (0..(scalar(@name1List)-1) ){
	my $completeName = $name1List[$i]."-E150005155_L01_".$name2List[$i];
	push @completeNameList, $completeName;
}

foreach my $cN(@completeNameList){

	my $lineName = substr($cN,3,3);

	print $cN."\n";

	open IN, "/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/out_ann_vcf/".$cN.".BQSR.ann.vcf";

	my $garLine = <IN>;

	while (substr($garLine,0,6) ne "#CHROM"){
		$garLine = <IN>;
		#print substr($garLine,0,6)."\n";
	}

	while(my $line = <IN>){

		chomp($line);

		my @tempArray = split(/\t/, $line);

		my $pos = $tempArray[1];
		my $ref = $tempArray[3];
		my $mut = $tempArray[4];
		my $info = $tempArray[7]; 

		if($info =~ /RNA/){
			print $line."\n";
		}
		if($info =~ /nonsense/){
			print $line."\n";
		}

		my $mutType = "NA";
		my $mutType2 = "NA";
		my $geneName = "NA";
		my $geneNameB = "NA";
		my $ann1 = "NA";
		my $ann2 = "NA";

		if($info =~ /AF=1\.0/){

			if(length($ref) == 1 && length($mut) == 1){	

				if($info =~ /missense_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.(\d+[A-Za-z>]+)\|p\.([A-Za-z]+\d+[A-Za-z]+)\|/){
					
					$mutType = "missense";
					$geneName = $1;
					$geneNameB = $2;
					$ann1 = $3;
					$ann2 = $4;

				}elsif($info =~ /synonymous_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.(\d+[A-Za-z>]+)\|p\.([A-Za-z\*]+\d+[A-Za-z\*]+)\|/){
					
					$mutType = "synonymous";
					$geneName = $1;
					$geneNameB = $2;
					$ann1 = $3;
					$ann2 = $4;

				}elsif($info =~ /stop_gained\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.(\d+[A-Za-z>]+)\|p\.([A-Za-z\*\?]+\d+[A-Za-z\*\?]+)\|/){
					
					$mutType = "nonsense";
					$geneName = $1;
					$geneNameB = $2;
					$ann1 = $3;
					$ann2 = $4;

				}elsif($info =~ /initiator_codon_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.(\d+[A-Za-z>]+)\|p\.([A-Za-z\*\?]+\d+[A-Za-z\*\?]+)\|/){
					
					$mutType = "initiator_codon_variant";
					$geneName = $1;
					$geneNameB = $2;
					$ann1 = $3;
					$ann2 = $4;

				}elsif($info =~ /stop_lost&splice_region_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.(\d+[A-Za-z>]+)\|p\.([A-Za-z\*\?]+\d+[A-Za-z\*\?]+)\|/){
					
					$mutType = "stop_lost&splice_region_variant";
					$geneName = $1;
					$geneNameB = $2;
					$ann1 = $3;
					$ann2 = $4;

				}elsif($info =~ /splice_region_variant&stop_retained_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.(\d+[A-Za-z>]+)\|p\.([A-Za-z\*\?]+\d+[A-Za-z\*\?]+)\|/){
					
					$mutType = "splice_region_variant&stop_retained_variant";
					$geneName = $1;
					$geneNameB = $2;
					$ann1 = $3;
					$ann2 = $4;

				}elsif($info =~ /intron_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.(\d+[\+\-]\d+[A-Za-z>]+)\|/){
					
					$mutType = "intron_variant";
					$geneName = $1;
					$geneNameB = $2;
					$ann1 = $3;

				}elsif($info =~ /splice_acceptor_variant&intron_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.(\d+[\+\-]\d+[A-Za-z>]+)\|/){
					
					$mutType = "splice_acceptor_variant&intron_variant";
					$geneName = $1;
					$geneNameB = $2;
					$ann1 = $3;

				}elsif($info =~ /intragenic_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|/){

					$geneName = $1;
					$geneNameB = $2;

					if($geneListRNA{$geneName} == 1){
						$mutType = "intragenic_RNAgene";
					}elsif($geneListPseudo{$geneName} == 1){
						$mutType = "intragenic_pseudogene";
					}else{
						$mutType = "intragenic";
					}

				}elsif($info =~ /intergenic_region\|[A-Z]+\|([A-Za-z\d\-\']+)\|(b\d+\-b\d+)\|/){
					
					$mutType = "intergenic";
					$geneName = $1;
					$geneNameB = $2;

				}
				#|missense_variant|MODERATE|sucB|b0727|transcript|b0727|protein_coding|1/1|c.520C>T|p.Arg174Cys|
				#|missense_variant|MODERATE|insB3|b0274|transcript|b0274|protein_coding|1/1|c.146A>G|p.Tyr49Cys|
				#|synonymous_variant|LOW|ybdO|b0603|transcript|b0603|protein_coding|1/1|c.684T>C|p.Gly228Gly|
				#|stop_gained|HIGH|nanC|b4311|transcript|b4311|protein_coding|1/1|c.564G>A|p.Trp188*|
				#|initiator_codon_variant|LOW|pqiB|b0951|transcript|b0951|protein_coding|1/1|c.1A>C|p.Met1?|
				#|stop_lost&splice_region_variant|HIGH|hyfG|b2487|transcript|b2487|protein_coding|1/1|c.1666T>C|p.Ter556Glnext*?|
				#|splice_region_variant&stop_retained_variant|LOW|ynfT|b4748|transcript|b4748|protein_coding|1/1|c.114A>G|p.Ter38Ter|
				#|intron_variant|MODIFIER|lomR|b4570|transcript|b4570|protein_coding|1/1|c.210+124C>T|
				#|splice_acceptor_variant&intron_variant|HIGH|crl|b0240|transcript|b0240|protein_coding|1/1|c.72-1C>G|
				#|intragenic_variant|MODIFIER|rrlE|b4009|gene_variant|b4009|
				#|intergenic_region|MODIFIER|rclR-ykgE|b0305-b0306|intergenic_region|b0305-b0306|||n.321482T>C|
				#|intergenic_region|MODIFIER|yecA-3'ETS-leuZ|b1908-b4759|intergenic_region|b1908-b4759|||n.1991670T>C|				

				$all_mut_snm_count{$cN} = $all_mut_snm_count{$cN}+1;

				print OUT1 $lineName."\t".$pos."\t".$ref."\t".$mut."\t".$mutType."\t".$geneName."\t".$geneNameB."\t".$ann1."\t".$ann2."\n";



			}else{
				
				if(length($ref) > length($mut) ){
					$mutType = "DEL";
				}else{
					$mutType = "INS";
				}

				if($info =~ /frameshift_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.([A-Za-z\d_>]+)\|p\.([A-Za-z\d_>]+)\|/){
					
					$mutType2 = "intragenic";
					$geneName = $1;
					$geneNameB = $2;

				}elsif($info =~ /frameshift_variant&stop_gained\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.([A-Za-z\d_>]+)\|p\.([A-Za-z\d_>]+)\|/){
					
					$mutType2 = "intragenic";
					$geneName = $1;
					$geneNameB = $2;

				}elsif($info =~ /disruptive_inframe_insertion\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.([A-Za-z\d_>]+)\|p\.([A-Za-z\d_>]+)\|/){
					
					$mutType2 = "intragenic";
					$geneName = $1;
					$geneNameB = $2;

				}elsif($info =~ /stop_gained&conservative_inframe_insertion\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|[A-Za-z]+\|b\d+\|[A-Za-z_]+\|[\d\/]+\|c\.([A-Za-z\d_>]+)\|p\.([A-Za-z\d_>]+)\|/){
					
					$mutType2 = "intragenic";
					$geneName = $1;
					$geneNameB = $2;

				}elsif($info =~ /intragenic_variant\|[A-Z]+\|([A-Za-z\d]+)\|(b\d+)\|/){
					
					$mutType2 = "intragenic";
					$geneName = $1;
					$geneNameB = $2;

				}elsif($info =~ /intergenic_region\|[A-Z]+\|([A-Za-z\d\-\']+)\|(b\d+\-b\d+)\|/){
					
					$mutType2 = "intergenic";
					$geneName = $1;
					$geneNameB = $2;

				}

				#|frameshift_variant|HIGH|xthA|b1749|transcript|b1749|protein_coding|1/1|c.783dupC|p.Val262fs|
				#|disruptive_inframe_insertion|MODERATE|yeaE|b1781|transcript|b1781|protein_coding|1/1|c.471_473dupGGG|p.Gly158dup|
				#|frameshift_variant&stop_gained|HIGH|mutL|b4170|transcript|b4170|protein_coding|1/1|c.9_10insGATGAGTGATATCAGTAAGGCGAGCCTGCCTAAGGCGATTTTTTTGATGGGGCCGACGGCCTCCGGTAAAACGG|p.Gln4fs|
				#|stop_gained&conservative_inframe_insertion|HIGH|mutL|b4170|transcript|b4170|protein_coding|1/1|c.9_10insGATGAGTGATAT|p.Ile3_Gln4insAspGluTerTyr|
				#|intragenic_variant|MODIFIER|gatC|b2092|gene_variant|b2092|||n.2173361_2173362delCC|
				#|intergenic_region|MODIFIER|nuoA-lrhA|b2288-b2289|intergenic_region|b2288-b2289|||n.2405411_2405412insC|

				$all_mut_indels_count{$cN} = $all_mut_indels_count{$cN}+1;

				print OUT2 $lineName."\t".$pos."\t".$ref."\t".$mut."\t".$mutType."\t".$mutType2."\t".$geneName."\t".$geneNameB."\n";;
			}
		}
	}
	close IN;
}
