//%attributes = {}
/*

This example shows that with an opacity of 0.5 applied to the group, the yellow circle covers
the red circle and the opacity is applied to the whole.
With opacity applied to each circle, the part common to both circles is orange.

*/
var $svg:=cs:C1710.svgx.svg.new().height(250).width(450).viewbox(-25; -25; 450; 250)

$svg.group().opacity(0.5)
$svg.circle(50; 75; 100).fill("red")
$svg.circle(50; 125; 100).fill("yellow")
$svg.closeParent()

$svg.group()
$svg.circle(50; 275; 100).fill("red").opacity(0.5)
$svg.circle(50; 325; 100).fill("yellow").opacity(0.5)
$svg.closeParent()

$svg.group().fontStyle(Bold:K14:2).fontSize(16)
$svg.text("Opacity on group").alignment(Align center:K42:3).position(100; 180)
$svg.text("Opacity on element").alignment(Align center:K42:3).position(300; 180)

$svg.preview()