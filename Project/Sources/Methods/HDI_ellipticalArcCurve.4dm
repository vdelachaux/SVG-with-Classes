//%attributes = {}
/*
The elliptical arc curve commands
https://Www.w3.org/TR/SVG11/paths.html#PathDataEllipticalArcCommands
*/

var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()

$svg.rect(1198; 398).position(1; 1)\
.stroke("blue")

$svg.path()\
.fill("red")\
.stroke("blue")\
.stroke(5)\
.M([300; 200])\
.h(-150)\
.a(150; 150; 0; 1; 0; 150; -150)\
.Z()

$svg.path(""; "root")\
.fill("yellow")\
.stroke("blue")\
.stroke(5)\
.M([275; 175])\
.v(-150)\
.a(150; 150; 0; 0; 0; -150; 150)\
.Z()

$svg.path(""; "root")\
.fill("none")\
.stroke("red")\
.stroke(5)\
.M([600; 350]).l([50; -25])\
.a(25; 25; -30; 0; 1; 50; -25).l([50; -25])\
.a(25; 50; -30; 0; 1; 50; -25).l([50; -25])\
.a(25; 75; -30; 0; 1; 50; -25).l([50; -25])\
.a(25; 100; -30; 0; 1; 50; -25).l([50; -25])

$svg.preview()