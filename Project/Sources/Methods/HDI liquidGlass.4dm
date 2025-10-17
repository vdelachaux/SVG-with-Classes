//%attributes = {}
var $svg:=cs:C1710.svg.new()
$svg.linearGradient("liquidGlass"; "white"; "silver"; {rotation: -90})

$svg.image(File:C1566("/RESOURCES/lena.jpg"))
$svg.rect(602; 102).position(9; 99).radius(20).gradient("liquidGlass").fillOpacity(0.4).stroke(False:C215).blur()
$svg.rect(600; 100).position(10; 100).radius(20).fill(False:C215).stroke("silver").strokeOpacity(0.5).nonScalingStroke(True:C214)
$svg.dropShadow()

$svg.circle(50; 500; 280).gradient("liquidGlass").fillOpacity(0.4).stroke(False:C215).blur()
$svg.circle(50; 500; 280).fill(False:C215).stroke("silver").nonScalingStroke(True:C214).strokeOpacity(0.5)
$svg.dropShadow()

$svg.preview()