//%attributes = {}
/*

Example line01 below specifies the coordinates of the five lines in the user 
coordinate system established by the ‘viewBox’ attribute on the ‘svg’ element. 

The lines have different thicknesses.

https://www.w3.org/TR/SVG11/shapes.html#LineElement

*/

var $svg : cs:C1710.svgx.svg

$svg:=cs:C1710.svgx.svg.new()\
.desc("Example line01 - lines expressed in user coordinates")

$svg.comment("Show outline of canvas using 'rect' element")
$svg.rect(1198; 398).position(1; 1)\
.stroke("blue").stroke(2)

$svg.group().stroke("green")

$svg.line(100; 300; 300; 100).stroke(5)
$svg.line(300; 300; 500; 100).stroke(10)
$svg.line(500; 300; 700; 100).stroke(15)
$svg.line(700; 300; 900; 100).stroke(20)
$svg.line(900; 300; 1100; 100).stroke(25)

$svg.preview()