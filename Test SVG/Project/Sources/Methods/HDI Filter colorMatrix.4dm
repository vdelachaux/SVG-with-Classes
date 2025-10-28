//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

var $grey:=[\
0.33; 0.33; 0.33; 0; 0; \
0.33; 0.33; 0.33; 0; 0; \
0.33; 0.33; 0.33; 0; 0; \
0.33; 0.33; 0.33; 0; 0\
]

$svg.group().stroke(False:C215).fill("coral").font({font: "Verdana"; size: 60; style: Bold:K14:2})
$svg.rect(800; 100).position(2; 0)
$svg.text("No filter").position(50; 70).fill("black")
$svg.rect(800; 100).position(2; 100).colorMatrix("matrix"; $grey)
$svg.text("Matrix").position(50; 170).fill("black")
$svg.rect(800; 100).position(2; 200).colorMatrix("saturate"; 0.5)
$svg.text("Saturate (0.5)").position(50; 270).fill("black")
$svg.rect(800; 100).position(2; 300).colorMatrix("hueRotate"; 90)
$svg.text("HueRotate (90)").position(50; 370).fill("black")
$svg.rect(800; 100).position(2; 400).colorMatrix("LuminanceToAlpha")
$svg.text("Luminance").position(50; 470).fill("black")

$svg.preview()