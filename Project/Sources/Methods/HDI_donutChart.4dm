//%attributes = {}
var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.title("Example donutChart01 - make a donut chart")\
.desc("Picture of a donut chart with the donut & wedge commands")\

$svg.group().stroke("blue")
$svg.rect(1000; 398).position(1; 1)

// Mark:- First 
$svg.donut("1st"; 200; 200; 120; 0)

// Draws the wedges 
$svg.wedge("1st"; 25).fill("lemonchiffon")
$svg.wedge("1st"; 12).fill("thistle")
$svg.wedge("1st"; 25).fill("palegreen")
$svg.wedge("1st"; 40).fill("lightcyan")
$svg.closePie()


$svg.preview()


