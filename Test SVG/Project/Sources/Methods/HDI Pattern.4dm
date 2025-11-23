//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

// MARK:- Using pattern for filling
$svg.comment(" 📌 Setting a pattern and using it to fill an ellipse")
$svg.comment(" 🛈 Note: The “defs” element is created automatically.")

// Defining "myPattern1"
$svg.pattern("myPattern1"; {\
width: 100; \
height: 100; \
x: 0; \
y: 0; \
viewBox: [0; 0; 10; 10]})

$svg.path().moveTo([0; 0]).lineTo([7; 0]).lineTo([3.5; 7]).closePath()\
.fill("lightgreen")\
.stroke("olivedrab")\
.addTo("myPattern1")

// Draw the ellipse & fiil it with "myPattern1"
$svg.ellipse(350; 150).cx(400).cy(200).stroke(5).stroke("olive").fill("myPattern1")

// MARK:- Using pattern for filling and outline
$svg.comment(" 📌 Define a pattern and use it to fill and outline an ellipse")
$svg.comment(" 🛈 Note: The definition is moved up to the “defs” element.")

// Defining "myPattern2"
$svg.pattern("myPattern2"; {\
width: 80; \
height: 80; \
x: 0; \
y: 0; \
viewBox: [0; 0; 20; 20]})

$svg.Square(20).stroke("white").fill("sandybrown").addTo("myPattern2")

// Draw the ellipse & fiil it with "myPattern2"
$svg.ellipse(350; 150).cx(400).cy(200).fill("myPattern2").stroke("myPattern2").translate(100; 200)


// MARK:- star pattern
$svg.comment(" 📌 Define a pattern and use it to fill and stroke of circles")
$svg.comment(" 🛈 Note: The definition is moved up to the “defs” element.")

// Defining the pattern "star"
var $pattern:=$svg.pattern("star"; {\
width: 10; \
height: 10; \
viewBox: [0; 0; 10; 10]})

$svg.polygon([\
[0; 0]; \
[2; 5]; \
[0; 10]; \
[5; 8]; \
[10; 10]; \
[8; 5]; \
[10; 0]; \
[5; 2]]).fill("black").addTo("star")

$svg.group().translate(390; 220)

// Draw a circle filled with the pattern.
$svg.circle(50; 50; 50).fill("star")

// Draw a circle whose outline uses the pattern.
$svg.circle(40; 180; 50).fill(False:C215).stroke(20).stroke("star")


//mark:-
$svg.preview()
