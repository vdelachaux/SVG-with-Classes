# SVG-with-Classes

After creating and using the [4D SVG component](https://doc.4d.com/4Dv19/4D/19/4D-SVG-Component.100-5461938.en.html), I became aware of the need to build a new API much smaller, faster and closer to the SVG format and my use to manage the user interface. 

The goal of this class is to reduce the complexity of code to create and manipulate svg images/documents.
This class will be augmented according to my needs but you are strongly encouraged to participate yourself through pull request.

## Code sample
Using the 4D SVG component to create and manipulate SVG elements requires knowledge of many commands and becomes difficult to understand and maintain. Creating a simple SVG requires many lines of code:

```4d
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
```
The `svg` class simplifies the creation and manipulation of the SVG elements thanks to a set of simple functions and some automatisms, and decrease the number of variables needed. Here is the equivalent code to get the same result (<mark>only 8 lines of easily understandable code versus 21 complicated lines with the component</mark>):

```4d
var $svg : cs.svg
	
// Create a new canvas
$svg:=cs.svg.new()
	
// Create a "background" & '"foreground" group & apply a translation to the last one
// [Layers are automatically created at the root level]
$svg.layer("background"; "foreground").translate(45; 45)
	
// Create a yellow square & memorize its reference as "original"
// [The object is automatically added to the latest created/used "container" ("foreground")]
$svg.square(20).position(2.5; 2.5).color("yellow").push("original")
	
// Set "background" layer for the next operations
If ($svg.with("background"))
	
	// Add, a blue circle without fill & with a border of 4 pixels
	$svg.circle(50).color("blue").position(100; 100).fill(False).stroke(4)
		
	// Clone the "original" square, colore it red, change its dimensions
	$svg.clone("original").color("red").position(10; 10).size(100; 100)
		
End if 
	
// Show the result into the SVG viewer
// [The memory is automatically freed]
$svg.preview()
```
The svg tree created:

```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes" ?>
<svg xmlns="http://www.w3.org/2000/svg" fill="none" font-family="'lucida grande','segoe UI',sans-serif" font-size="12" preserveAspectRatio="none" shape-rendering="crispEdges" stroke="black" text-rendering="geometricPrecision" viewport-fill="none" xmlns:xlink="http://www.w3.org/1999/xlink">
  <g id="background">
    <circle cx="0" cy="0" fill="none" r="50" stroke="blue" stroke-width="4" transform="translate(100,100)"/>
    <rect fill="yellow" height="100" stroke="yellow" width="100" x="10" y="10"/>
  </g>
  <g id="foreground" transform="translate(45,45)">
    <rect fill="blue" height="20" stroke="blue" width="20" x="2.5" y="2.5"/>
  </g>
</svg>
```
The result image:

<img src="Documentation/svg.png">
