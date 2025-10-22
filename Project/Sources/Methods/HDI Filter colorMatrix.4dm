//%attributes = {}
var $svg:=cs:C1710.svg.new()

var $grey:=[\
0.33; 0.33; 0.33; 0; 0; \
0.33; 0.33; 0.33; 0; 0; \
0.33; 0.33; 0.33; 0; 0; \
0.33; 0.33; 0.33; 0; 0\
]

$svg.group().stroke(False:C215).fill("coral")
$svg.rect(800; 100).position(2; 0)
$svg.rect(800; 100).position(2; 100).colorMatrix("matrix"; $grey)
$svg.rect(800; 100).position(2; 200).colorMatrix("saturate"; 0.5)
$svg.rect(800; 100).position(2; 300).colorMatrix("hueRotate"; 90)
$svg.rect(800; 100).position(2; 400).colorMatrix("LuminanceToAlpha")

$svg.restoreRoot()

$svg.group().font({font: "Verdana"; size: 60; style: Bold:K14:2})
$svg.text("No filter").position(50; 70)
$svg.text("Matrix").position(50; 170)
$svg.text("Saturate (0.5)").position(50; 270)
$svg.text("HueRotate (90)").position(50; 370)
$svg.text("Luminance").position(50; 470)

$svg.preview()