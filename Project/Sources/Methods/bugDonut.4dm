//%attributes = {}
var $chart : cs:C1710.chart

$chart:=cs:C1710.chart.new()\
.title("Example donutChart02 - make a donut chart")\
.desc("Picture of donut charts with the donut & wedge commands")\

//$chart.group().stroke("blue")
//$chart.rect(1000; 398).position(1; 1)

// Mark:- First
//.donutBounded($id; $cx; $cy; $r {; $thickness {; $margin {; $options}}})
$chart.donut("1st"; 400; 400; 240; 0.2; 5)  //.stroke(5)

var $segment : Integer
$segment:=12
var $percent : Real
$percent:=(100/$segment)-(5/$segment)
var $degree : Real
$degree:=360/$segment

var $i : Integer
For ($i; 1; $segment; 1)
	
	If ($i=12)
		
		$chart.wedge("1st"; $percent).fill(False:C215).stroke("red")
		
	Else 
		
		If ($i=11)
			
			$chart.wedge("1st"; $percent).fill(False:C215).stroke("green")
			
		Else 
			
			$chart.wedge("1st"; $percent).fill(False:C215).stroke("lightgray")
			
		End if 
		
	End if 
End for 

//$chart.closeChart("1st")  // Closing the chart

//// Mark:-Second, fit into a square defined by top-left corner [x, y] & side length [width]
//// The thickness is equal to 50% of the radius and the segments are separated by a margin of 10 
////.donutBounded($id; $x; $y; $width {; $thickness {; $margin {; $options}}})
//$chart.donutBounded("2nd"; 550; 30; 340; 50; 10)
//$chart.wedge("2nd"; 25).fill("crimson")
//$chart.wedge("2nd"; 12).fill("gold")
//$chart.wedge("2nd"; 25).fill("mediumaquamarine")
//$chart.wedge("2nd"; 40).fill("coral")
//$chart.closeChart()  // Closing the chart


$chart.preview()