//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()


$svg.group().stroke("dodgerblue").dasharray(2)
$svg.circle(50; 100; 100).fill(False:C215)
$svg.line(10; 100; 200; 100)  //.dasharray(2)


$svg.group("root")

// Defining a point at x = 100 and y = 100 (the center of the cicle)
var $center:=$svg.point(100; 100)
$svg.circle(5; $center[0]; $center[1]).color("red")

// Move point by radius 50 at 45 degrees
$point:=$svg.polarToCartesian($center; 50; 45)

// & use it
$svg.circle(5; $point[0]; $point[1]).color("blue")



$svg.preview()