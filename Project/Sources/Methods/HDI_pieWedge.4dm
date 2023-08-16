//%attributes = {}
var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.title("Example arcs02 - pieWedge command")\
.desc("Picture of a pie chart with two pie wedges")

$svg.group().stroke("blue")

$svg.rect(600; 398).position(1; 1)
$svg.group("pie").stroke(2)

$svg.comment("25%"; "pie")
$svg.pieWedge(275; 175; 150; -90; 25)\
.fill("yellow")

$svg.comment("75%"; "pie")
$svg.pieWedge(300; 200; 150; 0; 75)\
.fill("red")

$svg.preview()