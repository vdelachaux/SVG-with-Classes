//%attributes = {}
//var $svg:=cs.svgx.svg.new()


//var $side:=96
//$svg.square($side).radius(30).clipPath("mask")
//$svg.image(File("/RESOURCES/logo.svg")).width($side).height($side)

//$svg.preview()

// Definition of multi-style text
var $t:="<span style=\"font-size:18pt\">Hello </span>"+\
"<span style=\"font-size:24pt;font-weight:bold;color:#D81E05\">World</span>"+\
"<span style=\"font-size:36pt\">!</span><BR/>"+\
"<span style=\"font-size:19pt;font-style:italic\">It's </span>"+\
"<span style=\"font-size:24pt\">Monday</span>"

If (False:C215)  // Text multi-style
	
	var $dom : Text:=SVG_New
	//title
	SVG_SET_FONT_COLOR(SVG_New_text($dom; "_______ svg_Newtext _______"; 10; 30); "blue")
	//text
	var $node : Text:=SVG_New_text($dom; $t; 50; 50)
	SVGTool_SHOW_IN_VIEWER($dom)
	SVG_CLEAR($dom)
	
Else 
	
	
	
	var $svg:=cs:C1710.svgx.svg.new()
	
	$svg.text("_______ svg_Newtext _______").position(10; 30).color("blue")
	
	$svg.text($t).position(50; 50)
	
	$svg.preview()
	
End if 

