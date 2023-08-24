//%attributes = {}
//https:// Github.com/vdelachaux/SVG-with-Classes/issues/6#issuecomment-1688479882

var $i; $segment : Integer
var $hsl : Object
var $chart : cs:C1710.chart
var $color : cs:C1710.color

$segment:=12

$hsl:={hue: 0; saturation: 100; lightness: 100}
$color:=cs:C1710.color.new()

$chart:=cs:C1710.chart.new()

$chart.group().translate(200; 50).stroke(0.8).stroke("lightblue")

$chart.line(400; 0; 400; 800)
$chart.line(0; 400; 800; 400)

$chart.pie("dev"; 400; 400; 240).fill(False:C215).stroke(1)

For ($i; 1; $segment; 1)
	
	$chart.wedge("dev"; (100/$segment))
	
End for 

$chart.donut("bug"; 400; 400; 240; 0; 5)

For ($i; 1; $segment; 1)
	
	$hsl.hue:=$i*360/$segment
	$chart.wedge("bug"; 100/$segment).stroke($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
	
End for 

$chart.preview()