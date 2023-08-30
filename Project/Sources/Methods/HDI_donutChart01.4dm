//%attributes = {}
var $chart : cs:C1710.chart

$chart:=cs:C1710.chart.new()\
.title("Example donutChart01 - make a donut chart")\
.desc("Picture of donut charts with the donut & wedge commands")\

$chart.group().stroke("blue")
$chart.rect(1000; 398).position(1; 1)

// Mark:- First
//.donutBounded($id; $cx; $cy; $r {; $thickness {; $margin {; $options}}})
$chart.donut("1st"; 200; 200; 120).stroke("lightgray")

// Draws the wedges
$chart.wedge("1st"; 25).fill("lemonchiffon")
$chart.wedge("1st"; 12).fill("thistle")
$chart.wedge("1st"; 25).fill("palegreen")
$chart.wedge("1st"; 40).fill("lightcyan")

// Mark:-Second, fit into a square defined by top-left corner [x, y] & side length [width]
// The thickness is equal to 50% of the radius and the segments are separated by a margin of 10 
//.donutBounded($id; $x; $y; $width {; $thickness {; $margin {; $options}}})
$chart.donutBounded("2nd"; 550; 30; 340; 50; 10)
$chart.wedge("2nd"; 25).color("crimson")
$chart.wedge("2nd"; 12).color("gold")
$chart.wedge("2nd"; 25).color("mediumaquamarine")
$chart.wedge("2nd"; 40).color("coral")

$chart.preview()