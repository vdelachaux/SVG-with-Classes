//%attributes = {}
/*

Shows some simple uses of arc commands within a path

https://Www.w3.org/TR/SVG11/paths.html#PathDataEllipticalArcCommands

*/

var $svg : cs:C1710.svgx.svg

$svg:=cs:C1710.svgx.svg.new()\
.title("Example arcs01 - arc commands in path data")\
.desc("Picture of a pie chart with two pie wedges and\n        a picture of a line with "\
+"arc blips")

$svg.rect(1198; 398).position(1; 1)\
.stroke("blue")

// Using arc() with a single radius
$svg.path()\
.fill("red")\
.stroke("blue")\
.stroke(5)\
.moveTo([300; 200])\
.relative()\
.horizontalLineto(-150)\
.arc([150; -150]; 150; 0; [1; 0])\
.closePath()

$svg.path()\
.fill("yellow")\
.stroke("blue")\
.stroke(5)\
.absolute()\
.moveTo([275; 175])\
.relative()\
.verticalLineto(-150)\
.arc([-150; 150]; 150; 0; [0; 0])\
.closePath()

// Using arc() with 2 radii
$svg.path()\
.fill("none")\
.stroke("red")\
.stroke(5)\
.absolute()\
.moveTo([600; 350])\
.relative().lineTo([50; -25])\
.arc([50; -25]; [25; 25]; -30; [0; 1]).lineTo([50; -25])\
.arc([50; -25]; [25; 50]; -30; [0; 1]).lineTo([50; -25])\
.arc([50; -25]; [25; 75]; -30; [0; 1]).lineTo([50; -25])\
.arc([50; -25]; [25; 100]; -30; [0; 1]).lineTo([50; -25])

$svg.preview()