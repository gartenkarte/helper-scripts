#! /bin/bash

if [ $# -lt 5 ]; then
		echo "Usage: zoom topleft_x topleft_y bottomright_x bottomright_y"
		exit
fi

#echo -n "Herunterladen der watercolor tiles für die gaka, zoomstufe: " 
ZOOM=$1
#read -e ZOOM
echo -n "Zoomstufe ist $ZOOM/n"

TOPX=$2
echo -n "topleft_x: $TOPX/n"
#read -e TOPX 

TOPY=$3
echo -n "topleft_y: $TOPY/n"
#read -e TOPY
BOTTOMX=$4
echo -n "bottomright_x: $BOTTOMX/n"
#read -e BOTTOMX 
BOTTOMY=$5
echo -n "bottomright_y: $BOTTOMY/n"
#read -e BOTTOMY

let DELTAX=BOTTOMX-TOPX
echo "deltax ist $DELTAX"
let DELTAY=BOTTOMY-TOPY
echo "deltay ist $DELTAY" 

if [ ! -d "$ZOOM" ]; then
	mkdir $ZOOM
fi
cd $ZOOM

for i in `seq 0 $DELTAX`
do
	let X=TOPX+i

	if [ ! -d "$X" ]; then
		mkdir $X
	fi
	cd $X

	for j in `seq 0 $DELTAY`
	do
		let Y=TOPY+j

		echo "$ZOOM / $X / $Y"
		if [ ! -f "$Y.jpg" ]; then
			wget http://a.tile.stamen.com/watercolor/`printf $ZOOM`/`printf $X`/`printf $Y`.jpg
		else
			echo "Tile $ZOOM/$X/$Y ist schon gespeichert."
		fi
	done
	cd ..
done

cd ..
echo fertig.
