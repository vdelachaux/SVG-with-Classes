//%attributes = {}

If (Shift down:C543)  // Use 4D SVG component
	
	// Create a new canvas
	var $root : Text
	$root:=SVG_New
	
	// Create a "background" layer at the root level
	var $background : Text
	$background:=SVG_New_group($root)
	
	// Create a "foreground" layer, at the root level, and apply a translation
	var $foreground : Text
	$foreground:=SVG_New_group($root)
	SVG_SET_TRANSFORM_TRANSLATE($foreground; 45; 45)
	
	// Create a yellow square into the "foreground" layer
	var $rect : Text
	$rect:=SVG_New_rect($foreground; 2.5; 2.5; 20; 20)
	SVG_SET_FILL_BRUSH($rect; "yellow")
	SVG_SET_STROKE_BRUSH($rect; "yellow")
	
	// Add, into the "background" layer, a blue circle without fill & with a border of 4 pixels
	var $circle : Text
	$circle:=SVG_New_circle($background; 100; 100; 50)
	SVG_SET_FILL_BRUSH($circle; "none")
	SVG_SET_STROKE_BRUSH($circle; "blue")
	SVG_SET_STROKE_WIDTH($circle; 4)
	
	// Create a red square into the "background" layer
	$rect:=SVG_New_rect($background; 10; 10; 100; 100)
	SVG_SET_FILL_BRUSH($rect; "red")
	SVG_SET_STROKE_BRUSH($rect; "red")
	
	// Show the result into the SVG viewer
	SVGTool_SHOW_IN_VIEWER($root)
	
	// Do not forget to release the memory !
	SVG_CLEAR($root)
	
Else   // Use svg class
	
	var $svg : cs:C1710.svgx.svg
	
	// Create a new canvas
	$svg:=cs:C1710.svgx.svg.new()
	
	// Create a "background" & '"foreground" group & apply a translation to the last one
	// [Layers are automatically created at the root level]
	$svg.layer("background"; "foreground").translate(45; 45)
	
	// Create a yellow square & memorize its reference as "original"
	// [The object is automatically added to the latest created/used "container" ("foreground")]
	$svg.Square(20).position(2.5; 2.5).color("yellow").push("original")
	
	// Set "background" layer for the next operations
	If ($svg.with("background"))
		
		// Add, a blue circle without fill & with a border of 4 pixels
		$svg.circle(50).color("blue").position(100; 100).fill(False:C215).stroke(4)
		
		// Clone the "original" square, colore it red, change its dimensions
		$svg.clone("original").color("red").position(10; 10).size(100; 100)
		
	End if 
	
	// Show the result into the SVG viewer
	// [The memory is automatically freed]
	$svg.preview()
	
End if 