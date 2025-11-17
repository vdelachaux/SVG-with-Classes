//%attributes = {}
/* https://www.w3.org/TR/SVG2/painting.html#LineJoin

stroke-linejoin specifies the shape to be used at the corners of paths or basic shapes when they are stroked. 

**miter**
This value indicates that a sharp corner is to be used to join path segments. The corner is formed by extending the outer edges of the stroke at the tangents of the path segments until they intersect. If the stroke-miterlimit is exceeded, the line join falls back to bevel (see below).

**round**
This value indicates that a round corner is to be used to join path segments. The corner is a circular sector centered on the join point.

**bevel**
This value indicates that a bevelled corner is to be used to join path segments. The bevel shape is a triangle that fills the area between the two stroked segments.

**arcs**
This value indicates that an arcs corner is to be used to join path segments. The arcs shape is formed by extending the outer edges of the stroke at the join point with arcs that have the same curvature as the outer edges at the join point.

*/

var $svg:=cs:C1710.svgx.svg.new()\
.size(800; 180).viewbox(0; 0; 800; 180)

$svg.style(".thick { stroke: black; stroke-width: 35px }")
$svg.style(".thin { stroke: #ccc; stroke-width: 2px }")
$svg.style(".point { fill: #ccc; stroke: none }")

// Define symbols.
$svg.path().d("m 25,130 c 0,-40 50,-75 100,-75 -35,20 -50,50 -50,75").symbol("path1")
$svg.circle(4; 125; 55).symbol("circle1")


// MARK:- miter (default)
$svg.group().translate(0; 0)\
.use("path1").class("thick")\
.use("path1").class("thin")\
.use("circle1").class("point")\
.text("‘miter’ join (default)").fontSize(16).x(5).y(160)

// MARK:- round
$svg.group("root").translate(200; 0)\
.use("path1").class("thick").linejoin("round")\
.use("path1").class("thin")\
.use("circle1").class("point")\
.text("‘round’ join").fontSize(16).x(10).y(160)

// MARK:- bevel
$svg.group("root").translate(400; 0)\
.use("path1").class("thick").linejoin("bevel")\
.use("path1").class("thin")\
.use("circle1").class("point")\
.text("‘bevel’ join").fontSize(16).x(10).y(160)

// MARK:- arcs
$svg.path("root").d("m 724,37.5 c 18,0 41,3.6 65,17.7 C 769,55.6 750,60.7 733,70.6 Z").fill("black").setID("join")
$svg.group("root").translate(600; 0)\
.use("path1").class("thick").linejoin("bevel")\
.use("path1").class("thin")\
.use("circle1").class("point")\
.text("‘arcs’ join").fontSize(16).x(10).y(160)

$svg.preview()