//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new().size(1200; 1200)

$svg.style("path {fill:none}")

// Define a circle as marker
// Just setting the width,
// So by default, it will be a square and the reference point will be the center.
$svg.marker("circle"; "defs").width(12)
$svg.circle(3; 6; 6).fill("white").stroke(2)

// Create a group and assign it the marker
$svg.group("root").stroke(4).scale(4).marker("circle")

// Draw 3 paths, all will use markers
$svg.path().M([10; 50]).v(-20).h(40).v(-20).stroke("red")
$svg.path().M([30; 70]).v(-20).h(40).v(-20).stroke("green")
$svg.path().M([50; 90]).v(-20).h(40).v(-20).stroke("blue")


// MARK:- Start/mid/end
// Define 3 different circles as marker
$svg.marker("start"; "defs"; {width: 8; refX: 5})
$svg.circle(5; 5; 5).fill("green").opacity(0.5)

$svg.marker("mid"; "defs"; {width: 6.5; refX: 5})
$svg.circle(5; 5; 5).fill("skyblue").opacity(0.7)

$svg.marker("end"; "defs"; {width: 5; refX: 5})
$svg.circle(5; 5; 5).fill("maroon").opacity(0.7)

$svg.group("root").stroke("round").strokeWidth(4).scale(4).translate(100; 100)

// Create parth and assign it start, middle & end markers
// Note that only the third path displays the “start” marker, because for the other two, the last vertex is the same as the first vertex.
$svg.path().d("M10,10 h20 v20 z m40,0 h20 v20 z m40,0 h20 v20").fill(False:C215).linejoin("round")\
.marker("start"; "start")\
.marker("mid"; "mid")\
.marker("end"; "end")

// MARK:- Arrows
// Create a triangle as a symbol
// $svg.path().d("M 0 0 L 10 5 L 0 10 z").symbol("_triangle")
$svg.Triangle(5; 5; 5).symbol("_triangle")

// Use the symbol to create 2 markers with a different color
$svg.marker("_crimson"; "none"; {width: 4; height: 4; refX: 1; refY: 5; markerUnits: "strokeWidth"; viewBox: "0 0 10 10"})
$svg.use("_triangle").color("crimson")

$svg.marker("_olivedrab"; "none"; {width: 4; height: 4; refX: 1; refY: 5; markerUnits: "strokeWidth"; viewBox: "0 0 10 10"})
$svg.use("_triangle").color("olivedrab")

$svg.group("root").stroke(10).scale(2).fill("none").translate(200; 5)

// Create 2 curves with a end marker
$svg.path().d("M 100,75 C 125,50 150,50 175,75").stroke("crimson").marker("_crimson"; "end")
$svg.path().d("M 175,125 C 150,150 125,150 100,125").stroke("olivedrab").marker("_olivedrab"; "end")

$svg.preview()