//%attributes = {}
var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()

//TODO: title() & desc()

var $css : Text
$css:=".Border{fill:none;stroke:blue;stroke-width:1}\n"
$css+=".Connect{fill:none;stroke:#888888;stroke-width:2}\n"
$css+=".SamplePath{fill:none;stroke:red;stroke-width:5}\n"
$css+=".EndPoint{fill:none;stroke:#888888;stroke-width:2}\n"
$css+=".CtlPoint{fill:#888888;stroke:none}\n"
$css+=".AutoCtlPoint{fill:white;stroke:blue;stroke-width:4}\n"
$css+=".Label{font-size:22;font-family:Verdana}"

$svg.style($css)

$svg.rect(498; 398)\
.position(1; 1)\
.class("Border")

$svg.polyline("100,200 100,100").class("Connect")
$svg.polyline("250,100 250,200").class("Connect")
$svg.polyline("250,100 250,300").class("Connect")
$svg.polyline("400,300 400,200").class("Connect")

$svg.path()\
.M([100; 200])\
.C(100; 100; 250; 100; 250; 200)\
.S(400; 300; 400; 200)\
.class("SamplePath")

$svg.latest:=$svg.root
$svg.circle(10; 100; 200).class("EndPoint")
$svg.circle(10; 250; 200).class("EndPoint")
$svg.circle(10; 400; 200).class("EndPoint")
$svg.circle(10; 100; 100).class("CtlPoint")
$svg.circle(10; 250; 100).class("CtlPoint")
$svg.circle(10; 400; 300).class("CtlPoint")
$svg.circle(10; 250; 300).class("AutoCtlPoint")

$svg.text("M100,200 C100,100 250,100 250,200")\
.position(25; 70)\
.class("Label")

$svg.text("S400,300 400,200"; "root")\
.position(325; 350)\
.alignment(Align center:K42:3)\
.class("Label")

$svg.preview()