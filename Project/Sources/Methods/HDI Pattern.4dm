//%attributes = {}
var $svg:=cs:C1710.svg.new()

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
$svg.ellipse(350; 150).cx(400).cy(200).stroke(5).stroke("olive").pattern("myPattern1")

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
$svg.ellipse(350; 150).cx(400).cy(200).pattern("myPattern2").pattern("myPattern2"; True:C214).translate(100; 200)

//mark:-
$svg.preview()
