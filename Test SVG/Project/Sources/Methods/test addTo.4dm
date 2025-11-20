//%attributes = {}
/*

Adds element to parent item

*/

var $svg:=cs:C1710.svgx.svg.new()

// Define a lightcoral square as a symbol
$svg.square(20).position(40).fill("lightcoral").symbol("mySymbol")

// Draw a line at the first level
$svg.line(0; 0; 50; 50).stroke("red").stroke(4).setID("line1")

// Then add elements to the symbol definition
$svg.line(60; 60; 105; 105).stroke("blue").stroke(4).addTo("mySymbol")
$svg.square(40).position(100).fill("skyblue").addTo("mySymbol")

// Draw the symbol
$svg.use("mySymbol")

// This will push an error because a line is not a container
// & the square will be drawn at the root level
$svg.square(40).position(200; 100).fill("yellow").addTo("line1")

// AddTo() can be used anywhere as long as the target exists.
$svg.line(140; 140; 205; 205).stroke("green").stroke(4).addTo("mySymbol")
$svg.square(60).position(200).fill("palegreen").setID("test").addTo("mySymbol")

// If the target is unknown, the element is not moved & rendered at the root level
var $latest : Text:=$svg.square(40).fill("navajowhite").position(10; 100).addTo("unknown").latest
$svg.square(20).position(30; 120).fill("burlywood").addTo($latest)

$svg.preview()