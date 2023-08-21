//%attributes = {}
var $chart : cs:C1710.chart

$chart:=cs:C1710.chart.new()\
.title("Example donutChart01 - make a donut chart")\
.desc("Picture of a donut chart with the donut & wedge commands")\

$chart.group().stroke("blue")
$chart.rect(1000; 398).position(1; 1)

// Mark:- First 
$chart.donut("1st"; 200; 200; 120; 0)

// Draws the wedges 
$chart.wedge("1st"; 25).fill("lemonchiffon")
$chart.wedge("1st"; 12).fill("thistle")
$chart.wedge("1st"; 25).fill("palegreen")
$chart.wedge("1st"; 40).fill("lightcyan")
$chart.closePie()


$chart.preview()


