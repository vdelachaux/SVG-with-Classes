//%attributes = {}
/*

Shows some simple uses of cubic Bézier commands within a path. The example uses 
an internal CSS style sheet to assign styling properties. Note that the control 
point for the "S" command is computed automatically as the reflection of the 
control point for the previous "C" command relative to the start point of the 
"S" command.

https://www.w3.org/TR/SVG11/paths.html#PathDataCubicBezierCommands

*/

var $svg : cs:C1710.svgx.svg

$svg:=cs:C1710.svgx.svg.new()\
.title("Example cubic01- cubic Bézier commands in path data")\
.desc("Picture showing a simple example of path data\n        using both a \"C\" and an "\
+"\"S\" command,\n        along with annotations showing the control points\n     "\
+"   and end points")

var $css : Text
$css:="\n"
$css+=".Border{fill:none;stroke:blue;stroke-width:1}\n"
$css+=".Connect{fill:none;stroke:#888888;stroke-width:2}\n"
$css+=".SamplePath{fill:none;stroke:red;stroke-width:5}\n"
$css+=".EndPoint{fill:none;stroke:#888888;stroke-width:2}\n"
$css+=".CtlPoint{fill:#888888;stroke:none}\n"
$css+=".AutoCtlPoint{fill:white;stroke:blue;stroke-width:4}\n"
$css+=".Label{font-size:22;font-family:Verdana}"
$css+="\n"

$svg.style($css)

$svg.rect(498; 398)\
.position(1; 1)\
.class("Border")

$svg.polyline("100,200 100,100").class("Connect")
$svg.polyline("250,100 250,200").class("Connect")
$svg.polyline("250,100 250,300").class("Connect")
$svg.polyline("400,300 400,200").class("Connect")

$svg.path()\
.moveTo([100; 200])\
.cubicBezierCurveto([250; 200]; [100; 100]; [250; 100])\
.smoothCubicBezierCurveto([400; 200]; [400; 300])\
.class("SamplePath")

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