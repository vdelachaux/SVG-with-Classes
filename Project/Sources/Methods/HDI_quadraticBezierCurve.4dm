//%attributes = {}
/*

Shows some simple uses of quadratic Bézier commands within a path. Note that the 
control point for the "T" command is computed automatically as the reflection of 
the control point for the previous "Q" command relative to the start point of 
the "T" command.

https://www.w3.org/TR/SVG11/paths.html#PathDataQuadraticBezierCommands

*/

var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.title("Example quad01 - quadratic Bézier commands in path data")\
.desc("Picture showing a \"Q\" a \"T\" command,\n        along with annotations showing "\
+"the control points\n        and end points")

$svg.rect(1198; 598)\
.position(1; 1)\
.stroke("blue")

$svg.path()\
.fill(False:C215)\
.stroke("red")\
.stroke(5)\
.moveTo([200; 300])\
.quadraticBezierCurveto([600; 300]; [400; 50])\
.smoothQuadraticBezierCurveto([1000; 300])

$svg.comment("End points")
$svg.group().fill("black")
$svg.circle(10; 200; 300)
$svg.circle(10; 600; 300)
$svg.circle(10; 1000; 300)

$svg.comment("Control points and lines from end points to control points")
$svg.group().fill("#888888")
$svg.circle(10; 400; 50)
$svg.circle(10; 800; 550)

$svg.path()\
.fill(False:C215)\
.stroke("#888888")\
.stroke(2)\
.moveTo([200; 300])\
.lineTo([400; 50; 600; 300; 800; 550; 1000; 300])

$svg.preview()