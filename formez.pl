#!usr/bin/perl

# 
#     calendari sportivi - settembre 2012  - script per il calcolo di permutazioni
#
#     by Vincenzo Quaranta
# 
require "cgi-bin/cgi-lib.pl";
&ReadParse(*CGI);
&StampaModulo;
sub StampaModulo {
   print "Content-type: text/html\n\n";
   print "<HTML>\n<HEAD>\n";
print "<link href=\"provak.css\" rel=\"stylesheet\" type=\"text/css\">";
   print "<TITLE>Modulo</TITLE>\n";
   print "</HEAD>\n";
   print "<BODY>\n";

my $htmlstring = << "HEREDOC";
		<table cool width="916" height="640" border="0" cellpadding="0" cellspacing="0" gridx="16" showgridx usegridx gridy="16" showgridy usegridy>
			<tr height="1" cntrlrow>
				<td width="1" height="1"></td>
				<td width="16" height="1"><spacer type="block" width="16" height="1"></td>
				<td width="176" height="1"><spacer type="block" width="176" height="1"></td>
				<td width="528" height="1"><spacer type="block" width="528" height="1"></td>
				<td width="195" height="1"><spacer type="block" width="195" height="1"></td>
			</tr>
			<tr height="32">
				<td width="1" height="32"><spacer type="block" width="1" height="32"></td>
				<td width="16" height="32"></td>
				<td width="176" height="32"></td>
				<td width="528" height="32"></td>
				<td width="195" height="32"></td>
			</tr>
			<tr height="200">
				<td width="1" height="200"><spacer type="block" width="1" height="200"></td>
				<td width="16" height="200"></td>
				<td width="176" height="200" colspan="1" rowspan="1" valign="top" align="left" xpos="16"><img height="176" width="176" src="pallav1.jpg"></td>
				<td width="528" height="200" colspan="1" rowspan="1" valign="top" align="left" xpos="192">
					<table cool width="527" height="551" border="0" cellpadding="0" cellspacing="0" gridx="16" showgridx usegridx gridy="16" showgridy usegridy>



						<tr height="1" cntrlrow>
							<td width="1" height="1"></td>
							<td width="32" height="1"><spacer type="block" width="32" height="1"></td>
							<td width="64" height="1"><spacer type="block" width="64" height="1"></td>
							<td width="336" height="1"><spacer type="block" width="336" height="1"></td>
							<td width="64" height="1"><spacer type="block" width="64" height="1"></td>
							<td width="30" height="1"><spacer type="block" width="30" height="1"></td>
						</tr>
						<tr height="32">
							<td width="1" height="32"><spacer type="block" width="1" height="32"></td>
							<td width="32" height="32"></td>
							<td width="64" height="32"></td>
							<td width="336" height="32"></td>
							<td width="64" height="32"></td>
							<td width="30" height="32"></td>
						</tr>
						<tr height="48">
							<td width="1" height="48"><spacer type="block" width="1" height="48"></td>
							<td width="32" height="48"></td>
							<td width="64" height="48"></td>
							<td width="336" height="48" colspan="1" rowspan="1" valign="top" align="left" xpos="96" content csheight="43">
								<center>
									<h1><b>Il tuo calendario</b></h1>
								</center>
							</td>
							<td width="64" height="48"></td>
							<td width="30" height="48"></td>
						</tr>
						<tr height="470">
							<td width="1" height="470"><spacer type="block" width="1" height="470"></td>
							<td width="32" height="470"></td>
							<td width="464" height="470" colspan="3" rowspan="1" valign="top" align="left" xpos="32" content csheight="32">
								<center>
									(versione dimostrativa)</center>

HEREDOC
;

print $htmlstring;


print "<BR/><BR/><P>\n";
   print "<H1 align=center>Girone A</H1>\n
<BR/><BR/><P>
   <B>Squadre partecipanti</B>\n
   <HR><P>\n
<P>\n";
my @nomi=split(',', $CGI{"misura[]"});
for(my $ii=0; $ii<=scalar(@nomi); $ii++){
print "<B> $nomi[$ii] </B><HR><P>\n";
}


	#my @nomi=qw{ a b c d e f g h a1 b1 c1 d1 e1 f1 g1 h1 a2 b2 c2 d2 e2 f2 g2 h2 a3 b3 c3 d3 e3 f3 g3 h3 };

if (scalar(@nomi) % 2 != 0){
push(@nomi, 'riposa');
}

	my $n=scalar(@nomi);
	my $n_a=0;
	my $n_b=1;
	my $g=0;
	my @r_c=qw{ 0 0 0 0 0 0 0 0 0 0 0 0};

	for(my $item=0; $item<$n; $item++){
		for(my $item2=0; $item2<$n; $item2++){
			if($item != $item2){
				if ($nomi[$item] eq $nomi[$item2]){
					$nomi[$item]="$nomi[$item] (B)";
				}
			}
		}
	}

	#print "... n=$n \n";

	for(my $item=0; $item<$n-2; $item++){
		$r_c[$item]=0;
	}

	my @AoH = (
    		{
       		sq_di_casa => " ",
       		sq_ospite => " ",
       		campo => " ",
       		data => " ",
       		punt_casa => "0",
       		punt_ospite => "0"
    		},  
  	);

	my $rec = {};

  	for my $riga ( 0 .. 495 ) {

      		push @AoH, { sq_di_casa => " ", sq_ospite => " ", campo => " ", data => " ", punt_casa => "0", punt_ospite => "0" };

  	}

	my $finez=0;

	while($finez==0){
		while(trovato()==1){

			if($g==$n-2){
				$g=0;
			}else{
				$g++;
			}
		}
		$AoH[$g*$n/2+$r_c[$g]]{sq_di_casa}=$nomi[$n_a];
		$AoH[$g*$n/2+$r_c[$g]]{sq_ospite}=$nomi[$n_b];
		#print "... g=$g ... r_c[g]=$r_c[$g] ...";
		#print "... ";
		#print "$AoH[$g*$n/2+$r_c[$g]]{sq_di_casa}";
		#print " versus ";
		#print "$AoH[$g*$n/2+$r_c[$g]]{sq_ospite}";
		#print " ...\n";

		$r_c[$g]++;
		if($g==$n-2){
			$g=0;
		}else{
			$g++;
		}

		if(($n_a==$n-2)&&($n_b==$n-1)){
			$finez=1;
		}else{
			if($n_b==$n-1){
				$n_a++;
				$n_b=$n_a+1;
			}else{
				$n_b++;
			}
		}
	}


print "<BR/><BR/><P>\n";
	my $gi=0;
print "<H1 align=center>Calendario delle partite</H1><BR/><P>\n";
	for(my $item=0; $item<$n/2*($n-1); $item++){

		if ($item==$gi*($n/2)) {
print "<BR/><BR/><P>\n";
			my $pp=$gi+1; 
			print "<B>Giornata $pp </B>\n<HR><P>\n";
			$gi++;
		}

		print "$AoH[$item]{sq_di_casa} - $AoH[$item]{sq_ospite} \n<P>\n";

	}




	sub trovato {

	my $tro=0;

		for(my $item=0; $item<$n/2; $item++){

			if(($AoH[$g*$n/2+$item]{sq_di_casa} eq $nomi[$n_a])||($AoH[$g*$n/2+$item]{sq_ospite} eq $nomi[$n_a])||($AoH[$g*$n/2+$item]{sq_di_casa} eq $nomi[$n_b])||($AoH[$g*$n/2+$item]{sq_ospite} eq $nomi[$n_b])){
			$tro=1;

			}

		}

	return $tro;
	}


my $htmlstring2 = << "HEREDOC2";
							</td>
							<td width="30" height="470"></td>
						</tr>
					</table>
				</td>
				<td width="195" height="607" colspan="1" rowspan="1" valign="top" align="left" xpos="720"><img height="176" width="176" src="calcio1.jpg">
<a href="http://vincentforty.weebly.com"><img height="65" width="126" style="position: relative; top: 50px; left: 25px;" src="calcio2.jpg"></a>
<a href="http://vincentforty.weebly.com"><img height="65" width="176" style="position: relative; top: 100px; left: 5px;" src="calcio3.jpg"></a></td>

			</tr>
		</table>
	</body>

</html>
HEREDOC2
;
   print $htmlstring2;
}