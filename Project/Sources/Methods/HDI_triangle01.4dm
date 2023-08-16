//%attributes = {}
/*

Specifies a path in the shape of a triangle. (The M indicates a moveto, the Ls 
indicate linetos, and the Z indicates a closepath)

https://www.w3.org/TR/SVG11/paths.html#PathDataGeneralInformation
*/

var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.title("Example triangle01- simple example of a 'path'")\
.desc("A path that draws a triangle")

$svg.rect(398).position(1; 1)\
.stroke("blue")

$svg.path()\
.fill("red")\
.stroke("blue")\
.stroke(3)\
.moveTo([100; 100])\
.lineTo([300; 100; 200; 300])\
.closePath()

$svg.preview()