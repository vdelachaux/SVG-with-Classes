//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new().width(640).height(220).viewbox(-20; -20; 640; 220).translate(20; 20)

// MARK:- Define a square as symbol
$svg.Square(10).fill("white").stroke("black").stroke(0.1).symbol("square")

// MARK:- Define 4 patterns using the square and different values for “patternTransform”.
// MARK: • identity
$svg.pattern("Pat01"; {\
width: 10; \
height: 10; \
viewBox: [0; 0; 10; 10]})

$svg.use("square").addTo("Pat01")

// MARK: • rotate
$svg.pattern("Pat02"; {\
width: 10; \
height: 10; \
viewBox: [0; 0; 10; 10]; \
patternTransform: "rotate(45)"})

$svg.use("square").addTo("Pat02")

// MARK: • scale
$svg.pattern("Pat03"; {\
width: 10; \
height: 10; \
viewBox: [0; 0; 10; 10]; \
patternTransform: "scale(2)"})

$svg.use("square").addTo("Pat03")

// MARK: • skewX
$svg.pattern("Pat04"; {\
width: 10; \
height: 10; \
viewBox: [0; 0; 10; 10]; \
patternTransform: "skewX(45)"})

$svg.use("square").addTo("Pat04")

// MARK:- Draw 4 squares filled with the 4 patterns respectively.
$svg.Square(150).fill("Pat01")
$svg.Square(150).translate(150).fill("Pat02")
$svg.Square(150).translate(300).fill("Pat03")
$svg.Square(150).translate(450).fill("Pat04")

// MARK:- Write captions
$svg.group().translate(0; 175).alignment(Align center:K42:3)
$svg.text("identity").x(75)
$svg.text("rotate(45)").x(225)
$svg.text("scale(2)").x(375)
$svg.text("skewX(45)").x(525)

$svg.preview()