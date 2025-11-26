//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

If (Shift down:C543)
	
	TRACE:C157
	
End if 

var $cursor:=$svg.cursor

$svg.addElement("g"; {id: "group1"})
$cursor:=$svg.cursor

$svg.addElement("rect"; {width: 200; height: 20; x: 10; y: 10; id: "rect1"})  // Automatically in “group1”
$cursor:=$svg.cursor

$svg.addElement("circle"; {cx: 200; cy: 100; r: 50; id: "circle1"}; "root")  // At the first level
$cursor:=$svg.cursor

$svg.addElement("rect"; {width: 200; height: 20; x: 40; y: 40; id: "rect2"}; "group1")  // Within “group1”
$cursor:=$svg.cursor

/*
The current target element is the last one created, in this case “rect2.”
Therefore, if we want to modify “rect1” without modifying the current target, we must pass the “applyTo” parameter.
*/

$svg.fill("blue"; "rect1")
$cursor:=$svg.cursor  // The last target element has not been modified and remains “rect2.”  

$svg.rotate(45).translate(40).fill("yellow")  // will apply to "rect2"

$svg.cursor:="circle1"  // <- Here, we force “circle1” to be the target of the next actions.
$svg.stroke(2).stroke("red")
$cursor:=$svg.cursor

// If we want to return to the root
$svg.cursor:="root"
$cursor:=$svg.cursor

$svg.preview()