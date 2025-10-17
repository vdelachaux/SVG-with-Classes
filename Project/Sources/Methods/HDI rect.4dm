//%attributes = {}
/*

Example rect01 shows a rectangle with sharp corners.
The ‘rect’ element is filled with yellow and stroked with navy.

https:// Www.w3.org/TR/SVG11/shapes.html#RectElement

*/

var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.desc("Example rect01 - rectangle with sharp corners")

$svg.comment("Show outline of canvas using 'rect' element")
$svg.rect(1198; 398).position(1; 1)\
.stroke("blue").stroke(2)

$svg.rect(400; 200).position(400; 100)\
.fill("yellow").stroke("navy").stroke(10)

$svg.preview()