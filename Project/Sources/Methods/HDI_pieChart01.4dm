//%attributes = {}
var $i : Integer
var $colors; $values : Collection
var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()\
.title("Example pieChart01 - make a pie chart")\
.desc("Picture of a pie chart with the pie & wedge commands")

$svg.group().stroke("blue")
$svg.rect(1000; 398).position(1; 1)

// Mark:- First pie-chart starting at -10 degrees
//.pie($id; $cx; $cy; $r {; $start})
$svg.pie("1stPie"; 200; 200; 120; -10)
// Draws the wedges 
$svg.wedge("1stPie"; 15).fill("mediumaquamarine")
$svg.wedge("1stPie"; 35).fill("yellow")
$svg.wedge("1stPie"; 50).fill("royalblue")
$svg.closePie()

// Mark:-Second pie-chart, fit into a square, with no start point
//.pieBounded($id ; $x ; $y ; $width {; $start})
$svg.pieBounded("2ndPie"; 550; 30; 340)

$values:=[5.25; 8.75; 12.5; 8; 6; 12.5; 6; 14]
$colors:=["yellow"; "royalblue"; "coral"; "crimson"; "gold"; "darkkhaki"; "rosybrown"; "violet"; "mediumaquamarine"]

For ($i; 0; $values.length-1; 1)
	
	$svg.wedge("2ndPie"; $values[$i])\
		.fill($colors[$i])
	
End for 

// 📌 The pie is not complete, so call .wedge() without value.
$svg.wedge("2ndPie")\
.fill($colors[$i])

$svg.preview()