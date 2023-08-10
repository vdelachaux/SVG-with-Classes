//%attributes = {}
var $svg : cs:C1710.svg


$svg:=cs:C1710.svg.new()

//$t:=".Border { fill:none; stroke:blue; stroke-width:1 }\n    .Connect { fill:none; "\
+"stroke:#888888; stroke-width:2 }\n    .SamplePath { fill:none; stroke:red; "\
+"stroke-width:5 }\n    .EndPoint { fill:none; stroke:#888888; stroke-width:2 }\n "\
+"   .CtlPoint { fill:#888888; stroke:none }\n    .AutoCtlPoint { fill:none; "\
+"stroke:blue; stroke-width:4 }\n    .Label { font-size:22; font-family:Verdana }"

//TODO: if root create a <style> element
//$svg.style($t)

$svg.rect(498; 398).position(1; 1)\
.stroke("blue")

$c:=[100; 200; 100; 100]

$svg.polyline("100,200 100,100")
$svg.polyline("250,100 250,200")
$svg.polyline("250,100 250,300")
$svg.polyline("400,300 400,200")

$svg.path("M100,200 C100,100 250,100 250,200 S400,300 400,200")

//If ($svg.with($svg.root))
$svg.latest:=$svg.root
$svg.circle(10; 100; 200)
$svg.circle(10; 250; 200)
$svg.circle(10; 400; 200)
$svg.circle(10; 100; 100)
$svg.circle(10; 250; 100)
$svg.circle(10; 400; 300)
$svg.circle(10; 250; 300)

//End if 

$svg.preview()