//%attributes = {}
var $svg : cs:C1710.svg
$svg:=cs:C1710.svg.new().fontSize(40)

$svg.image(File:C1566("/RESOURCES/lena.jpg"))\
.position(5; 5)

$svg.text("Original")\
.position(80; 100)\
.color("white")\
.dropShadow()

$svg.image(File:C1566("/RESOURCES/lena.jpg"))\
.position(5; 5)\
.convertToGrayScale(50)\
.translate(250; 340)

$svg.text("50%")\
.position(350; 440)\
.color("white")\
.dropShadow()

$svg.image(File:C1566("/RESOURCES/lena.jpg"))\
.position(5; 5)\
.convertToGrayScale()\
.translate(80; 700)

$svg.text("Visual perception")\
.position(180; 820)\
.color("white")\
.dropShadow()

$svg.preview()