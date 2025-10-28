//%attributes = {}
var $colorNumber : Integer:=180
var $angle:=100/$colorNumber
var $hsl:={hue: 0; saturation: 70; lightness: 100}
var $color:=cs:C1710.svgx.color.new()
var $chart : cs:C1710.svgx.chart:=cs:C1710.svgx.chart.new().pie("wheel"; 300; 300; 240)
var $i : Integer
For ($i; 1; $colorNumber; 1)
	
	$hsl.hue:=$i*360/$colorNumber
	$chart.wedge("wheel"; $angle).color($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
	
End for 

$chart.preview()