//%attributes = {}
var $file:=File:C1566("/RESOURCES/logo.svg")

If (Not:C34($file.exists))
	
	return 
	
End if 

var $svg:=cs:C1710.svgx.svg.new()

$svg.removeAttribute($svg.root; "fill")

$svg.import($file)

$svg.preview()