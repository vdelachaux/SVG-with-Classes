//%attributes = {}
/*
cs.svgx.svg.new()\
.desc("Example clip-path")\
.square(96).radius(30).clipPath("mask")\
.image(File("/RESOURCES/vdl.jpg"))\
.preview()
*/

var $svg:=cs:C1710.svgx.svg.new()\
.desc("Example clip-path")

If (Shift down:C543)
	
	$svg.square(96).radius(30).clipPath("mask"; "root")
	
Else 
	
	$svg.clipPath("mask"; "none").clipPath("mask"; "root")
	$svg.square(96).radius(30).addTo("mask")
	//$svg.clipPath("mask"; "root")
	
End if 

$svg.image(File:C1566("/RESOURCES/vdl.jpg"))

$svg.preview()