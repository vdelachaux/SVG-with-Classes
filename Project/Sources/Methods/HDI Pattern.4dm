//%attributes = {}
var $svg:=cs:C1710.svg.new()

// MARK:- Using pattern for filling
$svg.comment(" 📌 Setting a pattern and using it to fill an ellipse")

$svg.definePattern("fill"; {\
width: 100; \
height: 100; \
x: 0; \
y: 0; \
viewBox: [0; 0; 10; 10]})

$svg.path("fill")\
.moveTo([0; 0])\
.lineTo([7; 0])\
.lineTo([3.5; 7])\
.closePath()\
.fill("lightgreen")\
.stroke("olivedrab")\
.endPattern()

$svg.ellipse(350; 150).cx(400).cy(200).stroke(5).stroke("olive").pattern("fill")

// MARK:- Using pattern for filling and outline
$svg.comment(" 📌 Setting a pattern and using it to fill and stroke the outline of an ellipse\r"\
+" 🛈 Note: that the pattern was defined into rhe \"defs\" element ")

$svg.definePattern("fillAndStroke"; {\
width: 80; \
height: 80; \
x: 0; \
y: 0; \
viewBox: [0; 0; 20; 20]})

$svg.rect(20; "fillAndStroke").stroke("white").fill("sandybrown").endPattern()

$svg.ellipse(350; 150).cx(400).cy(200).pattern("fillAndStroke").pattern("fillAndStroke"; True:C214).translate(100; 200)

$svg.preview()
