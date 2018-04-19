#!/bin/sh

# For DOS
#split DOSCAR to DOS0-1,2,3,...

fermifile=$1

NIONS=$(sed -n "1p" DOSCAR|awk '{print $1}')
echo $NIONS
NEDOS=$(sed -n "6p" DOSCAR|awk '{print $3}')
#NFERMI=$(sed -n "6p" |awk '{print $4}')
NEFRMI=$(grep "E-fermi" $fermifile | tail -1 | awk '{print $3}')

# For total DOS
i=0
sed -n "$((7+($NEDOS+1)*$i)), $(($NEDOS+6+($NEDOS+1)*$i)) p" DOSCAR | awk -v ef=$NEFRMI '{printf "%10.8f   %10.8f   %10.8f\n", $1-ef, $2, $3}'> DOS${i}.dat
for i in `seq 1 $NIONS`
do
# For non-spin : s, py, pz, px, dxy, dyz, dz2, dxz, dx2
#sed -n "$((7+($NEDOS+1)*$i)), $(($NEDOS+6+($NEDOS+1)*$i)) p" DOSCAR | awk -v ef=$NEFRMI '{printf "%10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f\n", $1-ef, $2, $3, $4, $5, $6, $7, $8, $9, $10}'> DOS${i}.dat

# For non-spin : s, py, pz, px, dxy, dyz, dz2, dxz, dx2,f1,f2...f7
sed -n "$((7+($NEDOS+1)*$i)), $(($NEDOS+6+($NEDOS+1)*$i)) p" DOSCAR | awk -v ef=$NEFRMI '{printf "%10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f  %10.8f   %10.8f   %10.8f   %10.8f   %10.8f  %10.8f \n", $1-ef, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17}'> DOS${i}.dat

# For spin : s(up),s(down), py(up),py(down), pz(up),pz(down), px(up),px(down),..... 
#sed -n "$((7+($NEDOS+1)*$i)), $((6+$NEDOS+($NEDOS+1)*$i)) p" DOSCAR | awk -v ef=$NEFRMI '{printf "%10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f\n", $1-ef, $2, -1*$3, $4, -1*$5, $6, -1*$7, $8, -1*$9, $10, -1*$11, $12, -1*$13, $14, -1*$15, $16, -1*$17, $18, -1*$19,$2,-1*$3,$4+$6+$8,-1*($5+$7+$9),$10+$12+$14+$16+$18,-1*($11+$13+$15+$17+$19)}'> DOS${i}.dat
#For spin-orbit DOS
#sed -n "$((7+($NEDOS+1)*$i)), $((6+$NEDOS+($NEDOS+1)*$i)) p" DOSCAR | awk -v ef=$NEFRMI '{printf "%10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f\n", $1-ef, $2, -1*$3, $4, -1*$5, $6, -1*$7, $8, -1*$9, $10, -1*$11, $12, -1*$13, $14, -1*$15, $16, -1*$17, $18, -1*$19,$2,-1*$3,$4+$6+$8,-1*($5+$7+$9),$10+$12+$14+$16+$18,-1*($11+$13+$15+$17+$19)}'> DOS${i}.dat
#	sed -n "$((7+($NEDOS+1)*$i)), $((6+$NEDOS+($NEDOS+1)*$i)) p" DOSCAR | awk -v ef=$NEDERMI '{printf "%10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f\n", $1-ef, $2, -1*$3, $4, -$5, $6, -1*$7, $8, -1*$9}'> DOS${i}
#sed -n "$((7+($NEDOS+1)*$i)), $(($NEDOS+6+($NEDOS+1)*$i)) p" DOSCAR | awk -v ef=$NEFRMI '{printf "%10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f   %10.8f\n", $1-ef, $2, $6, $10, $14, $18, $22, $26, $30, $34}'> DOS${i}.dat
done
