//%attributes = {}
var $svg : cs:C1710.svg
$svg:=cs:C1710.svg.new()

$svg.rect(200; 100)\
.position(10; 10)\
.fillColor("white")\
.dropShadow()  // Default values

$svg.text("SVG")\
.x(60).y(70)\
.fontFamily("Verdana").fontSize(45).color("red")\
.dropShadow(1; 10; 5)  // User-defined values

$svg.preview()