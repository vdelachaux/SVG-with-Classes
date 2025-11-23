//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new().viewbox(0; 0; 80; 20)

// 💡 A symbol can be defined by calling the function on the last element created.
$svg.circle(4; 2; 2).fill("gold").stroke(False:C215).symbol("myDot")

// 💡 Then, other elements can be added, if needed, to the symbol definition using the .addTo() function.
$svg.circle(2; 2; 2).fill("coral").stroke(False:C215).addTo("myDot")

$svg.group().scale(8)

// <!-- A grid to materialize our symbol positioning -->
$svg.path().d("M0,10 h80 M10,0 v20 M25,0 v20 M40,0 v20 M55,0 v20 M70,0 v20").stroke("pink")

// <!-- All instances of our symbol -->
$svg.use("myDot").position(8; 8)
$svg.use("myDot").position(23; 8).fillOpacity(80)
$svg.use("myDot").position(38; 8).fillOpacity(60)
$svg.use("myDot").position(53; 8).fillOpacity(40)
$svg.use("myDot").position(68; 8).fillOpacity(20)

$svg.preview()