//%attributes = {}
var $i : Integer
var $colors; $values : Collection
var $chart : cs:C1710.chart

$chart:=cs:C1710.chart.new()\
.title("Example pieChart01 - make a pie chart")\
.desc("Picture of a pie chart with the pie & wedge commands")

$chart.group().stroke("blue")
$chart.rect(1000; 398).position(1; 1)

// Mark:- First pie-chart starting at -10 degrees
//.pie($id; $cx; $cy; $r {; $options})
$chart.pie("1st"; 200; 200; 120; {origin: -10})

// Draws the wedges
$chart.wedge("1st"; 15).fill("mediumaquamarine")
$chart.wedge("1st"; 35).fill("yellow")
$chart.wedge("1st"; 50).fill("royalblue")
//$chart.closeChart("1st")  // Closing the chart

// Mark:-Second pie-chart, fit into a square defined by top-left corner [x, y] & side length [width]
//.pieBounded($id ; $x ; $y ; $width {; $options})
$chart.pieBounded("2nd"; 550; 30; 340)

$values:=[5.25; 8.75; 12.5; 8; 6; 12.5; 6; 14]
$colors:=["yellow"; "royalblue"; "coral"; "crimson"; "gold"; "darkkhaki"; "rosybrown"; "violet"; "mediumaquamarine"]

For ($i; 0; $values.length-1; 1)
	
	$chart.wedge("2nd"; $values[$i])\
		.fill($colors[$i])
	
End for 

// Complete the ring
$chart.wedge("2nd")\
.fill($colors[$i])

$chart.preview()