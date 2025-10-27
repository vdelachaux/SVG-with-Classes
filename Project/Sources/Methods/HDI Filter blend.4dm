//%attributes = {}
var $svg:=cs:C1710.svg.new()

$svg.rect(380; 90)\
.position(10; 10)\
.fill("white")\
.stroke("darkblue")

$svg.textArea("Hello World!")\
.position(10; 20)\
.width(380)\
.fontFamily("arial")\
.fontSize(60)\
.alignment(Align center:K42:3)\
.color("orange")\
.blend()

$svg.text(".blend() - default input = sourceGraphic").position(10; 115)

$svg.rect(380; 90)\
.position(10; 130)\
.fill("white")\
.stroke("darkblue")

$svg.textArea("Hello World!")\
.position(10; 140)\
.width(380)\
.fontFamily("arial")\
.fontSize(60)\
.alignment(Align center:K42:3)\
.color("orange")\
.blend(True:C214)

$svg.text(".blend(True) - use sourceAlpha as input").position(10; 235)

$svg.preview()
