//%attributes = {}
/* https://www.w3.org/TR/SVG2/painting.html#LineCaps

stroke-linecap specifies the shape to be used at the end of open subpaths when they are stroked, 
and the shape to be drawn for zero length subpaths whether they are open or closed. 

The possible values are:

**butt**
This value indicates that the stroke for each subpath does not extend beyond its two endpoints. 
A zero length subpath will therefore not have any stroke.

**round**
This value indicates that at each end of each subpath, the shape representing the stroke will be extended by a half circle with a diameter equal to the stroke width. 
If a subpath, whether open or closed, has zero length, then the resulting effect is that the stroke for that subpath consists solely of a full circle centered at the subpath's point.

**square**
This value indicates that at the end of each subpath, the shape representing the stroke will be extended by a rectangle 
with the same width as the stroke width and whose length is half of the stroke width. 
If a subpath, whether open or closed, has zero length, then the resulting effect is that the stroke for that subpath consists solely of a square with side length 
equal to the stroke width, centered at the subpath's point, and oriented such that two of its sides are parallel to the effective tangent at that subpath's point.
*/

var $svg:=cs:C1710.svgx.svg.new()\
.size(600; 110).viewbox("0 0 600 110")\
.fill("white")\
.fontSize(16).alignment(Align center:K42:3)

// Define a 2 circles symbol.
$svg.symbol("circles"; "defs")\
.circle(4; -60; 0; "circles").setID("circle1").fill("#ccc").stroke(False:C215)\
.circle(4; 60; 0; "circles").setID("circle2").fill("#ccc").stroke(False:C215)

// Define a line symbol.
$svg.line(-60; 0; 60; 0).symbol("line1")

// Define 2 style classes to apply to the line.
$svg.style(".thick {stroke:black; stroke-width:35px;}")\
.style(".thin {stroke:#ccc; stroke-width:2px;}")

// MARK:- Butt 
$svg.group().translate(100; 40)\
.use("line1").class("thick").linecap("butt")\
.use("line1").class("thin")\
.use("circles")\
.text("‘butt’ cap").y(50)

// MARK:- Round
$svg.group("root").translate(300; 40)\
.use("line1").class("thick").linecap("round")\
.use("line1").class("thin")\
.use("circles")\
.text("‘round’ cap").y(50)

// MARK:- Square 
$svg.group("root").translate(500; 40)\
.use("line1").class("thick").linecap("square")\
.use("line1").class("thin")\
.use("circles")\
.text("‘square’ cap").y(50)

$svg.preview()