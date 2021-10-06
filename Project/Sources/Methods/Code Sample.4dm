//%attributes = {}
var $svg : cs:C1710.svg

// Create a new canvas
$svg:=cs:C1710.svg.new()

// Create a symbol
$svg.square(20).color("orange").symbol("square")

// Create a "background" & "foreground" group & apply a translation to the last one
$svg.layer("background"; "foreground").translate(45; 45)  // Layers are automatically created at the root level

// Create a yellow square and store its reference associated with the label "original"
// Note: Will be automatically created into the last used/created container (here "foreground")
$svg.square(20).position(2.5; 2.5).color("yellow").push("original")

// Add, into the "background" layer, a blue circle without fill & with a border of 4 pixels
$svg.circle(50).color("blue").position(130; 130).fill(False:C215).stroke(4).attachTo("background")

// Clone the "original" square, colore it red, change its dimensions
// Note: Will be automatically created into the last used container (here "background")
$svg.clone("original").color("red").position(10; 10).size(130; 130)

If ($svg.with("foreground"))  // All enclosed actions refer to the "foreground" layer
	
	// Put the symbol "square", zoom x2, apply a translation of 80 px in both directions and define the ID
	$svg.use("square").scale(2).translate(80; 80).id("use1")
	
	// Draw a polyline by giving points as formatted text
	$svg.polyline("50,375 150,375 150,325 250,325 250,375 350,375 350,250 450,250 450,375 550,375 550,175 650,175 650,375 750,375 750,100 850,100 850,375 950,375 950,25 1050,25 1050,375 1150,375")\
		.stroke(10).stroke("dimgray")
	
End if 

// Draw, into the "background" layer, a red star with a blue border of 10 pixels wide by giving points as a collection of points
$svg.polygon()\
.points(JSON Parse:C1218("[[350,75],[379,161],[469,161],[397,215],[423,301],[350,250],[277,301],[303,215],[231,161],[321,161]]"))\
.fill("red")\
.stroke("blue").stroke(10)\
.translate(0; -40)\
.attachTo("background")

If ($svg.with("foreground"))  // All enclosed actions refer to the "foreground" layer
	
	// Draw an ellipse
	$svg.ellipse(300; 100; 500)
	
	// Put a text
	$svg.textArea("Hello\nworld").translate(3; -3).fontSize(26)
	
	If ($svg.with("original"))  // All enclosed actions refer to the "original" element
		
		$svg.moveHorizontally(1)
		$svg.width(18)
		
	End if 
End if 

If ($svg.with("background"))  // Set "background" layer for the next operations
	
	// Draw a green hexagon with a blue border 10 pixels wide, translate & rotate. The plot is defined point by point
	$svg.polygon()\
		.M(New collection:C1472(850; 75))\
		.L(New collection:C1472(958; 137.5))\
		.L(New collection:C1472(958; 262.5))\
		.L(New collection:C1472(850; 325))\
		.L(New collection:C1472(742; 262.6))\
		.L(New collection:C1472(742; 137.5))\
		.fill("lime")\
		.stroke("blue").stroke(10)\
		.translate(0; -40).rotate(20; 850; 160)
	
End if 

// Show the result into the SVG viewer
// Note: The memory is automatically freed
$svg.preview()