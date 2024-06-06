//%attributes = {}
var $svg : cs:C1710.svg
$svg:=cs:C1710.svg.new()

$svg.text("Color").x(30).y(30).color("blue").fontSize(24)
$svg.image(File:C1566("/RESOURCES/Avatar 96x96.jpg"))\
.position(10; 50)

$svg.text("Grey").x(140).y(30).color("blue").fontSize(24)
$svg.image(File:C1566("/RESOURCES/Avatar 96x96.jpg"))\
.position(120; 50)\
.convertToGrayScale()

$svg.preview()