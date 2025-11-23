//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()\
.desc("Example using the high-level commands Star(), RegularPolygon() & FivePointStar()")

$svg.comment("📌 FivePointStar")
$svg.FivePointStar(125*2; 150; 200)\
.fill("darksalmon").stroke("darkred").stroke(2)

$svg.comment("📌 RegularPolygon() Draws a regular polygon with number of sides fit into a circle")
$svg.RegularPolygon(125*2; 6; 550; 200)\
.fill("plum").stroke("purple").stroke(2).rotate(-(360/6)/2; 550; 200)


$svg.comment("📌 stars() allows you to define the number of branches")
$svg.Star(7; 50*2; 150; 500).color("khaki")
$svg.Star(15; 50*2; 350; 500).color("orange")
$svg.Star(39; 50*2; 550; 500).color("gold")


$svg.comment("📌 star() allows you to define the inner/outer ratio. Default is 0.5")
$svg.Star(5; 50*2; 150; 800).color("coral")

$svg.comment("📌 If you want a more “pointed” star, decrease the ratio.")
$svg.Star(5; 50*2; 350; 800; 0.3).color("darkorange")

$svg.comment("📌 For a more “round” star, increase the ratio.")
$svg.Star(5; 50*2; 550; 800; 0.7).color("orangered")



$svg.preview()