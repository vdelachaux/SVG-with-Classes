//%attributes = {}
/*

Example circle01 consists of a ‘circle’ element that is filled with red and stroked with blue.

https://www.w3.org/TR/SVG11/shapes.html#CircleElement

*/

var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.desc("Example circle01 - circle filled with red and stroked with blue")

$svg.comment("Show outline of canvas using 'rect' element")
$svg.rect(1198; 398).position(1; 1)\
.stroke("blue").stroke(2)

$svg.circle(100).position(600; 200)\
.fill("red").stroke("blue").stroke(10)

$svg.preview()