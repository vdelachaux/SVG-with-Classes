//%attributes = {}
var $svg : cs:C1710.svgx.svg

$svg:=cs:C1710.svgx.svg.new()\
.desc("Example liquid-glass")

$svg.square(96).radius(30).clipPath("mask")
$svg.image(File:C1566("/RESOURCES/lena.jpg")).width(96).height(96)

$svg.defineLinearGradient("liquidGlass"; "yellow"; "blue"; {rotation: 45; startOffset: 10})
$svg.square(96).radius(30).fill("url(#liquidGlass)").fillOpacity(0.3).stroke("white").strokeWidth(2).strokeOpacity(0.5)

$svg.preview()