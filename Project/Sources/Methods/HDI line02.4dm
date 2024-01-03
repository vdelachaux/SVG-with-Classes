//%attributes = {}
var $x : Integer
var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.desc("Example line02 - Dashed lines")

$svg.comment("Show outline of canvas using 'rect' element")
$svg.rect(1198; 398).position(1; 1)\
.stroke("blue").stroke(2)

$svg.comment("Dotted lines")
$svg.group().stroke(5)

$x:=100
$svg.line($x; 300; $x; 100).dasharray(10).color("gold")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(10.5).color("royalblue")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(1; 10).color("fushia")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(20; 5; 10; 5).color("crimson")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(5; 5).color("orchid")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(10; 5).color("darkkhaki")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(15; 5).color("rosybrown")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(5; 10).color("violet")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(15; 10; 5).color("mediumaquamarine")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(15; 10; 5; 10).color("blue")

$x+=20
$svg.line($x; 300; $x; 100).dasharray(15; 10; 5; 10; 5).color("slategray")

$svg.comment("Draw a grid with 2 lines")
$svg.group().stroke("violet").stroke(198).dasharray(1; 10)
$svg.line(400; 200; 599; 200)
$svg.line(500; 100; 500; 300)
$svg.square(198; "root").position(400.5; 100.5).stroke(1).stroke("purple")

$svg.comment("Rectangle with dashed line")
$svg.group().translate(700; 210).rotate(-30)
$svg.rect(400; 200).position(0; 0).radius(50)\
.fill(False:C215).stroke("olivedrab").stroke(5).dasharray(10.5; 5)

$svg.preview()