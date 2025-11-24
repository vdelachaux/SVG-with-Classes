//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()\
.desc("Example clip-path")

$svg.Square(96).fill("red").stroke(False:C215)

If (Shift down:C543)
	
	// Define the clipPath
	$svg.circle(96).clipPath("mask")
	
	$svg.comment("📌 Let's apply the clipPath to the image -> The red square is visible in the background.")
	
	// Place image & apply it the clipPath
	$svg.image(File:C1566("/RESOURCES/vdl.jpg")).clipPath("mask")
	
Else 
	
	$svg.comment("📌 If the clipPath is applied to the canvas -> The red square is no longer visible.")
	
	// Define a clipPath and apply it to the root.
	$svg.clipPath("mask"; "root")
	$svg.circle(96).stroke(False:C215).addTo("mask")
	
	// Place image
	$svg.image(File:C1566("/RESOURCES/vdl.jpg"))
	
End if 

$svg.preview()