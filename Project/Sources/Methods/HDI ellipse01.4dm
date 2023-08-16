//%attributes = {}
/*

Example ellipse01 below specifies the coordinates of the two ellipses in the user 
coordinate system established by the ‘viewBox’ attribute on the ‘svg’ element 
and the ‘transform’ attribute on the ‘g’ and ‘ellipse’ elements. 

Both ellipses use the default values of zero for the ‘cx’ and ‘cy’ attributes (the center of the ellipse). 
The second ellipse is rotated.

https://www.w3.org/TR/SVG11/shapes.html#EllipseElement

*/

var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.desc("Example ellipse01 - examples of ellipses")

$svg.comment("Show outline of canvas using 'rect' element")
$svg.rect(1198; 398).position(1; 1)\
.stroke("blue").stroke(2)

$svg.group().translate(300; 200)
$svg.ellipse(250; 100).fill("red").stroke(False:C215)

// Close the current group
$svg.latest:=$svg.root

$svg.ellipse(250; 100).translate(900; 200).rotate(-30)\
.fill("false").stroke("blue").stroke(20)

$svg.preview()