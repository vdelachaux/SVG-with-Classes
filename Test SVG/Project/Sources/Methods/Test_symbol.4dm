//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new().viewbox(0; 0; 80; 20)

// <!-- Our symbol in its own coordinate system -->
$svg.symbol("myDot"; "defs")
$svg.circle(4; 2; 2).fill("black").stroke(False:C215).addTo("myDot")
//$svg.width(10; "myDot").height(10; "myDot")  //.viewbox(0; 0; 4; 4; "myDot")

$svg.group().scale(8)

// <!-- A grid to materialize our symbol positioning -->
$svg.path().d("M0,10 h80 M10,0 v20 M25,0 v20 M40,0 v20 M55,0 v20 M70,0 v20").stroke("pink")

// <!-- All instances of our symbol -->
$svg.use("myDot").position(8; 8)
$svg.use("myDot").position(23; 8).fillOpacity(70)
$svg.use("myDot").position(38; 8).fillOpacity(50)
$svg.use("myDot").position(53; 8).fillOpacity(35)
$svg.use("myDot").position(68; 8).fillOpacity(15)

$svg.preview()