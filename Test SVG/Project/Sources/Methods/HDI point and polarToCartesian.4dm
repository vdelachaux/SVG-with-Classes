//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

// Defining a point at x = 100 and y = 100
var $point:=$svg.point(100; 100)

// Move point by radius 50 at 45 degrees
$point:=$svg.polarToCartesian($point; 50; 45)

// & use it
$svg.circle(10; $point[0]; $point[1]).fillColor("blue")
$svg.preview()