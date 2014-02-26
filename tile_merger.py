### Merge tiles into one image ###
import sys, os

print "Usage: tile_merge.py zoomlevel xMin xMax yMin yMax filename"
print
print "This utility merges tiles."

zoom = None
xMin, xMax, yMin, yMax = None, None, None, None
filename = None

argv = sys.argv
i = 1
while i < len(argv):
	arg = argv[i]

	if zoom is None:
		zoom = int(argv[i])
	elif xMin is None:
		xMin = int(argv[i])
	elif xMax is None:
		xMax = int(argv[i])
	elif yMin is None:
		yMin = int(argv[i])
	elif yMax is None:
		yMax = int(argv[i])
	elif filename is None:
		filename = argv[i]
	else:
		Usage("ERROR: Too many parameters")

	i = i + 1

import Image
tileSize = 256
tileDir = os.path.join(os.curdir,"tiles",str(zoom))

out = Image.new( 'RGB', ( (xMax - xMin + 1) * tileSize, (yMax - yMin + 1) * tileSize) )

imx = 0
for x in range(xMin, xMax+1):
	imy = 0
	for y in range(yMin, yMax+1):
		tileFile = os.path.join(tileDir,str(x),str(y)+".jpg")
		tile = Image.open(tileFile)
		out.paste( tile, (imx, imy) )
		imy += tileSize
	imx += tileSize

out.save(os.path.join(os.curdir,filename))
