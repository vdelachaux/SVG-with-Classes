//%attributes = {}
var $svg:=cs:C1710.svg.new().fill({color: "papayawhip"; opacity: 0.5})

$svg.rect(200; 100)\
.position(10; 10)\
.fillColor("white")\
.dropShadow()  // Default values

$svg.text("SVG")\
.x(60).y(70)\
.fontFamily("sans-serif").fontSize(45).color("red")\
.dropShadow(1; 10; 5)  // User-defined values

$svg.fivePointStar(500; 300; 350).color("tomato").dropShadow()  // Default

$svg.square(200)\
.position(500; 10)\
.fillColor("white")\
.stroke("blue")

$svg.image(File:C1566("/RESOURCES/Avatar 96x96.jpg"))\
.position(550; 50).dropShadow(10; 10; 10)

$svg.preview()