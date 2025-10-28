//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new().fill({color: "papayawhip"; opacity: 0.5})

// Use Default values: Dispersion = 2, offset x = 2 & offset y =2
$svg.rect(200; 100)\
.position(10; 10)\
.fillColor("white")\
.dropShadow()

// User-defined values: Dispersion = 1, offset x = 10 & offset y = 5
$svg.text("SVG")\
.x(60).y(70)\
.fontFamily("sans-serif").fontSize(45).color("red")\
.dropShadow(1; 10; 5)

// User-defined Dispersion value: Dispersion = 8
$svg.fivePointStar(500; 300; 350).color("tomato").dropShadow(8)

$svg.square(200)\
.position(500; 10)\
.fillColor("white")\
.stroke("blue")

// User-defined values: Dispersion = 10, offset x = 10 & offset y = 10
$svg.image(File:C1566("/RESOURCES/vdl.jpg"))\
.position(550; 50).dropShadow(10; 10; 10)

$svg.preview()