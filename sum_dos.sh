#!/bin/sh

i=$1
cp DOS$1.dat temp
j=$((i+1))
for i in `seq $j $2`
do
	paste temp DOS$i.dat > temp1
#	awk '{printf "%-8.4f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f\n", $1, $2+$12, $3+$13, $4+$14, $5+$15, $6+$16, $7+$17, $8+$18, $9+$19, $10+$20}' temp1 > temp
# For f electron
	awk '{printf "%-8.4f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f   %-10.6f\n", $1, $2+$12, $3+$13, $4+$14, $5+$15, $6+$16, $7+$17, $8+$18, $9+$19, $10+$20}' temp1 > temp
done
mv temp DOSSUM_$1-$2.dat
rm -f temp1
