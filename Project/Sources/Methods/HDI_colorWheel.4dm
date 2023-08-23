//%attributes = {}
var $angle : Real
var $i; $colorNumber : Integer
var $hsl : Object
var $chart : cs:C1710.chart
var $color : cs:C1710.color

$colorNumber:=180

$angle:=100/$colorNumber
$hsl:={hue: 0; saturation: 70; lightness: 100}
$color:=cs:C1710.color.new()

$chart:=cs:C1710.chart.new().pie("wheel"; 400; 400; 240).rotate(-90)

For ($i; 1; $colorNumber; 1)
	
	$hsl.hue:=$i*360/$colorNumber
	$chart.wedge("wheel"; $angle).color($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
	
End for 

$chart.preview()
