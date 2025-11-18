//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

// MARK:- Using pattern for filling
$svg.comment(" 📌 Setting a pattern and using it to fill an ellipse")

// Setting the pattern
$svg.definePattern("myPattern1"; {\
width: 100; \
height: 100; \
x: 0; \
y: 0; \
viewBox: [0; 0; 10; 10]})

$svg.path("myPattern1")\
.moveTo([0; 0])\
.lineTo([7; 0])\
.lineTo([3.5; 7])\
.closePath()\
.fill("lightgreen")\
.stroke("olivedrab")\
.endPattern()

// Draw the ellipse
$svg.ellipse(350; 150).cx(400).cy(200).stroke(5).stroke("olive").fill("myPattern1")

// MARK:- Using pattern for filling and outline
$svg.comment(" 📌 Define a pattern and use it to fill and outline an ellipse\r"\
+" 🛈 Note: that the pattern was defined into the \"defs\" element ")

// Setting the pattern
$svg.definePattern("myPattern2"; {\
width: 80; \
height: 80; \
x: 0; \
y: 0; \
viewBox: [0; 0; 20; 20]})

$svg.rect(20; "myPattern2").stroke("white").fill("sandybrown").endPattern()

// Draw the ellipse
$svg.ellipse(350; 150).cx(400).cy(200).fill("myPattern2").stroke("myPattern2").translate(100; 200)


// MARK:- star pattern
$svg.comment(" 📌 Define a pattern and use it to fill and stroke of circles\r"\
+" 🛈 Note: that the pattern was defined into the \"defs\" element ")
var $pattern:=$svg.definePattern("star"; {\
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
[5; 2]]).fill("black")\
.addTo("star")

$svg.group().translate(390; 220)

// - fill with pattern
$svg.circle(50; 50; 50).fill("star")

// - ouline use pattern
$svg.circle(40; 180; 50).fill(False:C215).stroke(20).stroke("star")


//mark:-
$svg.preview()
