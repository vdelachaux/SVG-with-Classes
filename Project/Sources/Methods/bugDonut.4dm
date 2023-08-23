//%attributes = {}
//https://github.com/vdelachaux/SVG-with-Classes/issues/6#issuecomment-1688479882

var $i; $segment : Integer
var $hsl : Object
var $chart : cs:C1710.chart
var $color : cs:C1710.color

$chart:=cs:C1710.chart.new().donut("bug"; 400; 400; 240; 0; 5).translate(200; 50)

$chart.line(400; 0; 400; 800).stroke(0.5).stroke("lightblue")
$chart.line(0; 400; 800; 400).stroke(0.5).stroke("lightblue")

$hsl:={hue: 0; saturation: 100; lightness: 100}

$color:=cs:C1710.color.new()

$segment:=12

For ($i; 1; $segment; 1)
	
	$hsl.hue:=$i*360/$segment
	$chart.wedge("bug"; 100/$segment).color($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
	
End for 

$chart.preview()