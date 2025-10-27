//%attributes = {}
var $svg:=cs:C1710.svg.new()

$svg.offset(50)

$svg.defineLinearGradient("linearLiquidGlass"; "white"; "silver"; {rotation: -90; startOffset: 20})
$svg.defineRadialGradient("radialLiquidGlass"; "white"; "silver")  //; {cx: 50; cy: 50; r: 20; fx: 50; fy: 50})

$svg.image(File:C1566("/RESOURCES/lena.jpg"))  //.convertToGrayScale()

$svg.group().gradient("linearLiquidGlass")
$svg.rect(602; 102).position(9; 99).radius(20).fillOpacity(0.4).stroke(False:C215).blur()
$svg.group().strokeOpacity(0.5).nonScalingStroke(True:C214)
$svg.rect(600; 101).position(11; 100).radius(20).fill(False:C215).stroke("white")
$svg.rect(600; 100).position(10; 100).radius(20).fill(False:C215).stroke("silver")
$svg.dropShadow()

$svg.group("root").translate(-30).gradient("radialLiquidGlass")
$svg.circle(50; 500; 280).fillOpacity(0.4).stroke(False:C215).blur()
$svg.group().strokeOpacity(0.5).nonScalingStroke(True:C214)
$svg.circle(50; 500; 280).fill(False:C215).stroke("silver")
$svg.circle(50; 501; 279).fill(False:C215).stroke("white")
$svg.dropShadow()

$svg.preview()