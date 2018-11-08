# Shape Drawer

A way to draw and export shapes. Inspired by shape function from
[innomin](https://www.lexaloffle.com/bbs/?tid=2608).

In more detail, this program allows you to create shapes in more detail and
export them in the compressed format described as outlined by innomin.

## Drawstring Commands:
- "C" color - set drawing Color (for lines and fills). color is a hex value
0-F.

- "T" x y - move cursor relative To current position, drawing nothing. x and y
are chars from "0"-"9"-"A"-"G", which represent -8 to 8. So "T00" means "to -8,
-8", and "TGG" means "to 8, 8".

- "L" x y - draw Line from current position to next position. x and y are
0-9+A-G as described above.

- "F" x y stopcolor - flood Fill a region with drawing color until you
encounter stopcolor. This fully works with rotation by filling the next
(rotated) position defined by x,y. x and y are 0-9+A-G as described above,
color is a hex value 0-F.

## Random Ideas
This is a scratchpad for my thinking, so don't pay any attention here.

the interface will look like so:

modes
	create
	edit

funcs
	pan
	save
	help

colors
	line
	fill
	bkgd
