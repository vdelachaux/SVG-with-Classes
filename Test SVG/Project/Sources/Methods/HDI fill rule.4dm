//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new().size(1100; 800).viewbox(0; 0; 1100; 800)

// MARK: nonzero
$svg.path().d("M10,10 h80 v80 h-80 Z M30,30 h40 v40 h-40 Z").fill("orange").fill("nonzero")

// MARK: evenodd
$svg.path().d("M10,10 h80 v80 h-80 Z M30,30 h40 v40 h-40 Z").translate(100; 0).fill("orange").fill("evenodd")

$svg.goUp().group().translate(0; 100)\
.text("nonzero").position(25; 10)\
.text("evenodd").position(25; 10).translate(100; 0)

/*
The fill-rule property indicates the algorithm (or winding rule) which is to be used to determine what parts of the canvas are included inside the shape. 
For a simple, non-intersecting path, it is intuitively clear what region lies "inside"; 
however, for a more complex path, such as a path that intersects itself or where one subpath encloses another, the interpretation of "inside" is not so obvious.

The fill-rule property provides two options for how the inside of a shape is determined:
*/

// MARK:- nonzero
/*
This rule determines the "insideness" of a point on the canvas by drawing a ray from that point to infinity in any direction 
and then examining the places where a segment of the shape crosses the ray. 
Starting with a count of zero, add one each time a path segment crosses the ray from left to right 
and subtract one each time a path segment crosses the ray from right to left. After counting the crossings, 
if the result is zero then the point is outside the path. Otherwise, it is inside. 

The following drawing illustrates the nonzero rule:
*/

$svg.path().d("M 16,0 L -8,9 v-18 z").fill("blue").stroke(False:C215).symbol("triangle")

var $g:=$svg.group().fill("red").fill("nonzero").stroke("black").strokeWidth(3).translate(-100; 100).latest

$svg.path().d("M 250,75 L 323,301 131,161 369,161 177,301 z")\
.use("triangle").translate(306.21; 249).rotate(72)\
.use("triangle").translate(175.16; 193.2).rotate(216)\
.use("triangle").translate(314.26; 161)\
.use("triangle").translate(221.16; 268.8).rotate(144)\
.use("triangle").translate(233.21; 126.98).rotate(288)

$svg.path().d("M 600,81 A 107,107 0 0,1 600,295 A 107,107 0 0,1 600,81 z M 600,139 A 49,49 0 0,1 600,237 A 49,49 0 0,1 600,139 z")
$svg.group().translate(600; 188)\
.use("triangle").translate(107; 0).rotate(90)\
.use("triangle").setAttribute("transform"; "rotate(120) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(240) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(60) translate(49; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(180) translate(49; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(300) translate(49; 0) rotate(90)")

$svg.path($g).d("M 950,81 A 107,107 0 0,1 950,295 A 107,107 0 0,1 950,81 z M 950,139 A 49,49 0 0,0 950,237 A 49,49 0 0,0 950,139 z")
$svg.group($g).translate(950; 188)\
.use("triangle").setAttribute("transform"; "rotate(0) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(120) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(240) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(60) translate(49; 0) rotate(-90)")\
.use("triangle").setAttribute("transform"; "rotate(180) translate(49; 0) rotate(-90)")\
.use("triangle").setAttribute("transform"; "rotate(300) translate(49; 0) rotate(-90)")

$svg.goUp(2).text("The effect of a \"nonzero\" fill rule on paths with self-intersections and enclosed subpaths.").position(110; 340).fontSize(24).color("black")


// MARK: evenodd
/*
This rule determines the "insideness" of a point on the canvas by drawing a ray from that point to infinity in any direction 
and counting the number of path segments from the given shape that the ray crosses. 
If this number is odd, the point is inside; if even, the point is outside. 

The following drawing illustrates the evenodd rule:
*/
$svg.goUp(2).group().fill("red").fill("evenodd").stroke("black").strokeWidth(3).translate(-80; 400)

$svg.path().d("M 250,75 L 323,301 131,161 369,161 177,301 z")\
.use("triangle").translate(306.21; 249).rotate(72)\
.use("triangle").translate(175.16; 193.2).rotate(216)\
.use("triangle").translate(314.26; 161)\
.use("triangle").translate(221.16; 268.8).rotate(144)\
.use("triangle").translate(233.21; 126.98).rotate(288)

$svg.goUp().path().d("M 600,81 A 107,107 0 0,1 600,295 A 107,107 0 0,1 600,81 z M 600,139 A 49,49 0 0,1 600,237 A 49,49 0 0,1 600,139 z")
$svg.group().translate(600; 188)\
.use("triangle").translate(107; 0).rotate(90)\
.use("triangle").setAttribute("transform"; "rotate(120) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(240) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(60) translate(49; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(180) translate(49; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(300) translate(49; 0) rotate(90)")

$svg.goUp(2).path().d("M 950,81 A 107,107 0 0,1 950,295 A 107,107 0 0,1 950,81 z M 950,139 A 49,49 0 0,0 950,237 A 49,49 0 0,0 950,139 z")
$svg.goUp().group().translate(950; 188)\
.use("triangle").setAttribute("transform"; "rotate(0) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(120) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(240) translate(107; 0) rotate(90)")\
.use("triangle").setAttribute("transform"; "rotate(60) translate(49; 0) rotate(-90)")\
.use("triangle").setAttribute("transform"; "rotate(180) translate(49; 0) rotate(-90)")\
.use("triangle").setAttribute("transform"; "rotate(300) translate(49; 0) rotate(-90)")

$svg.goUp(2).text("The effect of an \"evenodd\" fill rule on paths with self-intersections and enclosed subpaths.").position(90; 340).fontSize(24).color("black")

$svg.preview()