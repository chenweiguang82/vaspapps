#!/usr/bin/perl -w
#

$line = $ARGV[0];
$num  = @ARGV;
$num  = $num - 1;
$bandnum = 1;
$temp=$bandnum;
for($j=0; $j<$line; $j++) {
	$bandnum = $temp + $j*$ARGV[1]/$ARGV[1];
	printf "%6.2f\n",$bandnum;
}
for($i=2; $i<=$num; $i++) {
	printf "%6.2f\n",$bandnum;
	$temp=$bandnum;
	for($j=2; $j<=$line; $j++) {
		$bandnum = $temp + $j*$ARGV[$i]/$ARGV[1];
		printf "%6.2f\n",$bandnum;
	}
#print "==================", $temp, "================","\n";
}
