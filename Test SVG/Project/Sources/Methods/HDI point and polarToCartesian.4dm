//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

$svg.Square(400).fill("white")

$svg.group().scale(2)

var $cx:=100
var $cy:=100
$svg.group().stroke("dodgerblue").dasharray(2)
$svg.circle(50; $cx; $cy).fill(False:C215)
$svg.line(10; $cy; 190; $cy)
$svg.line($cx; 10; $cx; 190)

$svg.group("parent").stroke(False:C215)

// Defining a point at the center of the cicle
var $center:=cs:C1710.svgx.point.new(100; 100)
$svg.circle(3; $center.x; $center.y).fill("red")

var $degree : Integer
For ($degree; 0; 360; 360/12)
	
	// Move point by radius 50 at $i degrees
	var $point:=$center.polarToCartesian(50; $degree)
	
	// & plot it
	$svg.circle(3; $point.x; $point.y).fill("mediumslateblue")
	
End for 

$svg.preview()