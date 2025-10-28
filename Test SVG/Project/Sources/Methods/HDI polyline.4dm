//%attributes = {}
/*

Example polyline01 below specifies a polyline in the user coordinate
system established by the ‘viewBox’ attribute on the ‘svg’ element.

https:// Www.w3.org/TR/SVG11/shapes.html#PolylineElement

*/
var $base; $i; $x; $y : Integer
var $c : Collection
var $svg : cs:C1710.svgx.svg

$svg:=cs:C1710.svgx.svg.new()\
.desc("Example polyline01 - increasingly larger bars")

$svg.comment("Show outline of canvas using 'rect' element")
$svg.rect(1198; 398).position(1; 1)\
.stroke("blue").stroke(2)

$x:=150
$y:=325
$base:=375

$c:=[[50; $base]]  // MoveTo

For ($i; 1; 5; 1)
	
	$c.push([$x; $base])
	$c.push([$x; $y])
	$c.push([$x+100; $y])
	$c.push([$x+100; $base])
	
	$x+=200
	$y-=75
	
End for 

$c.push([$x; $base])  // LineTo

$svg.polyline($c).stroke("blue").stroke(10)

$svg.preview()