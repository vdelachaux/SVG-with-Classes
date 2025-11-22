//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

var $t:="Hello\reveryone,\rwe\rare\rrobots"
$svg.text($t).fontSize(40).x(20)
$svg.text($t).fontSize(24).x(300)
$svg.text($t).fontSize(80).x(500)

$svg.preview()