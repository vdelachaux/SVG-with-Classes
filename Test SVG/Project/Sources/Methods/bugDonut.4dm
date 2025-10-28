//%attributes = {}
/*
"https://Github.com/vdelachaux/SVG-with-Classes/issues/6#issuecomment-1688479882"
*/

var $segment:=31
var $margin:=4

var $color : cs:C1710.svgx.color:=cs:C1710.svgx.color.new()

var $hsl:={\
hue: 0; \
saturation: 100; \
lightness: 100}

var $chart : cs:C1710.svgx.chart:=cs:C1710.svgx.chart.new()

$chart.group().translate(200; 50).stroke(0.8).stroke("lightblue")

$chart.line(400; 0; 400; 800)
$chart.line(0; 400; 800; 400)

$chart.pie("dev"; 400; 400; 240).fill(False:C215).stroke(1)

var $i : Integer
For ($i; 1; $segment; 1)
	
	$chart.wedge("dev"; 100/$segment).fill($i%2=0 ? "aliceblue" : False:C215)
	
End for 

$chart.donut("bug"; 400; 400; 240; 0; $margin)

For ($i; 1; $segment; 1)
	
	$hsl.hue:=$i*360/$segment
	$chart.wedge("bug"; 100/$segment).color($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
	
End for 

$chart.preview()