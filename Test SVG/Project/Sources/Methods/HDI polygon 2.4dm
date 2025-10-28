//%attributes = {}
/*

Example polygon02 below specifies a five pointed star and a hexagon
using high-level commands .fivePointStar() & .regularPolygon()

https:// Www.w3.org/TR/SVG11/shapes.html#PolygonElement

*/
var $svg : cs:C1710.svgx.svg

$svg:=cs:C1710.svgx.svg.new()\
.desc("Example polygon01 - star and hexagon")

$svg.comment("Show outline of canvas using 'rect' element")
$svg.rect(1198; 398).position(1; 1)\
.stroke("blue").stroke(2)

$svg.comment("fivePointStar")
$svg.fivePointStar(125*2; 350; 200).color("red")

$svg.comment("regularPolygon")
$svg.regularPolygon(125*2; 6; 850; 200).fill("lime").stroke("blue").stroke(5).rotate(-(360/6)/2; 850; 200)

$svg.preview()