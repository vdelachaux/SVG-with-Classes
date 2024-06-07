//%attributes = {}
var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.desc("Example clip-path")

$svg.square(96).radius(30)
$svg.clipPath("mask")
$svg.image(File:C1566("/RESOURCES/Avatar 96x96.jpg"))

$svg.preview()


