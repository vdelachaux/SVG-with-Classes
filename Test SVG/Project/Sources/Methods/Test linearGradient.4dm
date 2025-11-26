//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

var $o:={\
x1: 20; \
y1: 0; \
x2: 50; \
y2: 0; \
startOffset: 30; \
stopOffset: 70}

$svg.linearGradient("MyGradient1"; "red"; "yellow"; $o)

$o.spreadMethod:="pad"
$svg.linearGradient("MyGradient2"; "red"; "yellow"; $o)

$o.spreadMethod:="reflect"
$svg.linearGradient("MyGradient3"; "red"; "yellow"; $o)

$o.spreadMethod:="repeat"
$svg.linearGradient("MyGradient4"; "red"; "yellow"; $o)

$svg.group().translate(10; 10)
$svg.Square(150).fill("MyGradient1")
$svg.Square(150).x(150).fill("MyGradient2")
$svg.Square(150).x(300).fill("MyGradient3")
$svg.Square(150).x(450).fill("MyGradient4")

$svg.group().translate(0; 175).alignment(Align center:K42:3)
$svg.text("default").x(75)
$svg.text("pad").x(225)
$svg.text("reflect").x(375)
$svg.text("repeat").x(525)

$o:={\
x2: 5; \
startOffset: 10; \
stopOffset: 90; \
spreadMethod: "reflect"}

$svg.linearGradient("MyGradient5"; "red"; "yellow"; $o)

$svg.group().translate(10; 220)
$svg.Square(150).fill("MyGradient5")
$svg.circle(60; 225; 75).fill("none").stroke(10).stroke("MyGradient5")
$svg.path().d("M320 20l 70 0 0 60 20 50 -100 0z").style("stroke:black;fill:url(#MyGradient5)")

// ⚠️  With 4D, gradients are not rendered for text.
$svg.text("SVG").x(450).fontFamily("sans-serif").fontSize(100).color("url(#MyGradient5)")

$svg.preview()
