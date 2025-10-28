//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

$svg.defineRadialGradient("grad1"; "yellow"; "red")
$svg.rect(90).position(10; 10).gradient("grad1")
$svg.text("grad1").position(15; 25)

$svg.defineRadialGradient("grad2"; "yellow"; "red"; {cx: 50; cy: 50; r: 20; fx: 50; fy: 50})
$svg.rect(90).position(110; 10).gradient("grad2")
$svg.text("grad2").position(115; 25)

$svg.defineRadialGradient("grad3"; "yellow"; "red"; {cx: 80; cy: 60; r: 50; fx: 60; fy: 80})
$svg.rect(90).position(10; 110).gradient("grad3")
$svg.text("grad3").position(15; 125)

$svg.defineRadialGradient("grad4"; "yellow"; "red"; {cx: 20; cy: 50; r: 80; fx: 20; fy: 30})
$svg.rect(90).position(110; 110).gradient("grad4")
$svg.text("grad4").position(115; 125)

$svg.preview()