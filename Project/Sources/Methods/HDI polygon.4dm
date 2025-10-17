//%attributes = {}
/*

Example polygon01 below specifies two polygons (a star and a hexagon) in the user coordinate
system established by the ‘viewBox’ attribute on the ‘svg’ element.

https:// Www.w3.org/TR/SVG11/shapes.html#PolygonElement

*/
var $c : Collection
var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.desc("Example polygon01 - star and hexagon")

$svg.comment("Show outline of canvas using 'rect' element")
$svg.rect(1198; 398).position(1; 1)\
.stroke("blue").stroke(2)

$c:=[]

$c.push([350; 75])
$c.push([379; 161])
$c.push([469; 161])
$c.push([397; 215])
$c.push([423; 301])
$c.push([350; 250])
$c.push([277; 301])
$c.push([303; 215])
$c.push([231; 161])
$c.push([321; 161])

$svg.polygon($c).fill("red").stroke("blue").stroke(10)

$c:=[]
$c.push([850; 75])
$c.push([958; 137.5])
$c.push([958; 262.5])
$c.push([850; 325])
$c.push([742; 262.6])
$c.push([742; 137.5])

$svg.polygon($c).fill("lime").stroke("blue").stroke(10)

$svg.preview()