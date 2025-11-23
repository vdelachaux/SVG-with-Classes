//%attributes = {}
/*

Specifies a path in the shape of a triangle.

https://www.w3.org/TR/SVG11/paths.html#PathDataGeneralInformation
*/

var $svg : cs:C1710.svgx.svg

$svg:=cs:C1710.svgx.svg.new()\
.title("ℹ️ Example triangle01- simple example of a 'path'")\
.desc("📐 A path that draws a triangle")

$svg.rect(800; 380).position(1; 1)\
.stroke("blue")

$svg.solidColor("myFill"; "lightsalmon"; 80)
$svg.solidColor("myStroke"; "tomato"; 0.5)

$svg.path()\
.fill("myFill")\
.stroke("myStroke")\
.stroke(3)\
.moveTo([100; 100])\
.lineTo([300; 100; 200; 300])\
.closePath()

/*

Using the high-level Triangle() command 

*/

$svg.comment("📌 high-level Triangle() command")
$svg.group().fillOpacity(0.5).translate(400; 20).scale(1.5)

$svg.Triangle(100; 100; 100).color("red")  // No rotation
$svg.Triangle(100; 100; 100; 0.25).color("green")  // 1/4 turn
$svg.Triangle(100; 100; 100; 0.5).color("blue")  // 1/2 turn
$svg.Triangle(100; 100; 100; 3/4).color("green")  // 3/4 turn

$svg.preview()
