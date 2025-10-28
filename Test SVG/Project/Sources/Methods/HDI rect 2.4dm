//%attributes = {}
/*

Example rect02 shows two rounded rectangles. 
The ‘rx’ specifies how to round the corners of the rectangles. 
Note that since no value has been specified for the ‘ry’ attribute, it will be assigned the same value as the ‘rx’ attribute.

https:// Www.w3.org/TR/SVG11/shapes.html#RectElement

*/

var $svg : cs:C1710.svgx.svg

$svg:=cs:C1710.svgx.svg.new()\
.desc("Example rect02 - rounded rectangles")

$svg.comment("Show outline of canvas using 'rect' element")
$svg.rect(1198; 398).position(1; 1)\
.stroke("blue").stroke(2)

$svg.rect(400; 200).position(100; 100).radius(50)\
.color("green")

$svg.group().translate(700; 210).rotate(-30)
$svg.rect(400; 200).position(0; 0).radius(50)\
.fill(False:C215).stroke("purple").stroke(30)

$svg.preview()