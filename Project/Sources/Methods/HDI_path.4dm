//%attributes = {}
/*
Path data
https://www.w3.org/TR/SVG11/paths.html#PathDataGeneralInformation
*/

var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()

$svg.rect(398).position(1; 1)\
.stroke("blue")

$svg.path()\
.fill("red")\
.stroke("blue")\
.stroke(3)

$svg.M([100; 100])
$svg.L([300; 100])
$svg.L([200; 300])
$svg.Z()

$svg.preview()