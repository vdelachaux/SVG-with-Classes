//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

// Create internal CSS style sheets 
$svg.style(".small {font-style:italic; font-size:13; font-family:sans-serif;}")
$svg.style(".heavy {font-weight:bold; font-size:30px; font-family:sans-serif;}")

$svg.group().scale(4)

// Create texts and assign them a class style
$svg.text("My").position(20; 35).class("small")
$svg.text("cat").position(40; 35).class("heavy")
$svg.text("is").position(55; 55).class("small")

// The style can also be a style integrated into an element.
$svg.text("Grumpy!").position(65; 55).style("font-style:italic; font-size:40px; font-family:serif; fill: red;")

$svg.preview()