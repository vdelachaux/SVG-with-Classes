//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

$svg.addElement("g"; {id: "group1"})
$svg.addElement("rect"; {width: 200; height: 20; x: 10; y: 10; id: "rect1"})  // Automatically in “group1”

$svg.addElement("circle"; {cx: 200; cy: 100; r: 50; id: "circle1"}; "root")  // At the first level

$svg.addElement("rect"; {width: 200; height: 20; x: 40; y: 40; id: "rect2"}; "group1")  // Within “group1”

$svg.fill("blue"; "rect1")
$svg.rotate(45; "rect2").translate(40; "rect2")
$svg.stroke(2; "circle1").stroke("red"; "circle1")
$svg.fill("yellow"; "rect2")


$svg.preview()