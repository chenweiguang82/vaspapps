#!/usr/bin/perl



$alpha=$ARGV[1]/$ARGV[0];
$beta=$ARGV[2]/$ARGV[0];

$line=`sed -n '6 p' POSCAR`;
@type=split (' ',"$line");
$ntype=@type;

for ($i=0;$i<$ntype;$i++){
	$natom=$natom+$type[$i];
}

system ("sed -n '1,8 p' POSCAR >tmpfile");
$total=8+$natom;
system ("sed -n '9,'$total' p' POSCAR>tmpfile1");

open (POSOLD,tmpfile);
open (POSNEW,">POSCAR-new");

while (<POSOLD>) {
if ($.==1 || $.==7 || $.==8) {
	$newline=$_;
	printf POSNEW "%s",$newline;
}

if ($.==2) {
	$newline=$_*$ARGV[0];
	printf POSNEW "   %8.5f\n",$newline;
}

if ($.==3) {
	$newline=$_;
        @field=split (' ',$newline);
        printf POSNEW "%18.14f%18.14f%18.14f\n",$field[0],$field[1],$field[2];
}

if ($.==4) {
	$newline=$_;
	@field=split (' ',$newline);
	printf POSNEW "%18.14f%18.14f%18.14f\n",$field[0]*$alpha,$field[1]*$alpha,$field[2]*$alpha;
}

if ($.==5) {
	$newline=$_;
        @field=split (' ',$newline);
        printf POSNEW "%18.14f%18.14f%18.14f\n",$field[0]*$beta,$field[1]*$beta,$field[2]*$beta;
}

if ($.==6) {
	$newline=$_;
	@field=split (' ',$newline);
	$ntype=@field;
	for ($i=0;$i<$ntype;$i++) {
		printf POSNEW "%4d",$field[$i]*$ARGV[0]*$ARGV[1]*$ARGV[2];
	}
	printf POSNEW "\n";
}
}

close (POSOLD);

open (POSOLD1,tmpfile1);

while (<POSOLD1>) {
	$newline=$_;
	@field=split (' ',$newline);
	
	for ($c=0;$c<$ARGV[2];$c++) {
		for ($b=0;$b<$ARGV[1];$b++) {
			for ($a=0;$a<$ARGV[0];$a++) {
        			printf POSNEW "%17.14f %17.14f %17.14f   %s  %s  %s %s\n",($field[0]+$a)/$ARGV[0],($field[1]+$b)/$ARGV[1],($field[2]+$c)/$ARGV[2],$field[3],$field[4],$field[5],$field[6];
			}
		}
	}
}

close (POSNEW);
close (POSOLD1);

system ("rm -f tmpfile");
system ("rm -f tmpfile1");
