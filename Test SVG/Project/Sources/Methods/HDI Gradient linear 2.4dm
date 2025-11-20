//%attributes = {}
var $svg : cs:C1710.svgx.svg

$svg:=cs:C1710.svgx.svg.new()

$svg.linearGradient("gradient"; "gold"; "magenta"; {rotation: 90; startOffset: 20})

$svg.group().scale(4)
$svg.image(File:C1566("/RESOURCES/lena.jpg")).width(100).height(100)

$svg.square(90).position(5; 5).fill("gradient").fillOpacity(0.3)

$svg.preview()