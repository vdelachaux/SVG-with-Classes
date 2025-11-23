//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

$svg.Square(40).symbol("square")

$svg.use("square").position(80)\
.fill("blue").rotateTAU(-1/8; 100; 100)

$svg.use("square").position(80)\
.fill("orange").rotateTAU(0.25; 50; 50).rotateTAU(-1/8; 50; 50)

$svg.use("square").position(150)\
.fill("yellow").rotateTAU(1/8).translate(50)

$svg.use("square").position(150)\
.fill("green").rotateTAU(1/8).translate(50; 10).scale(0.5)

$svg.preview()


