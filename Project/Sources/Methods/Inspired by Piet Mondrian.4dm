//%attributes = {}
var $svg : cs:C1710.svg

$svg:=cs:C1710.svg.new()
$svg.group("mondrian").stroke(4).translate(10; 10).scale(2)
$svg.rect(40; 60).position(2; 144).fill("midnightblue")
$svg.rect(120; 142).position(42; 2).fill("red")
$svg.textArea("Inspired by Piet Mondrian - 1930,\rComposition II in Red, Blue, and Yellow").position(0; 210).fontSize(8).alignment(Align center:K42:3)
$svg.group().fill("white")
$svg.rect(40; 40).position(2; 2)
$svg.rect(40; 100).position(2; 43)
$svg.rect(95; 60).position(42; 144)
$svg.rect(25; 25).position(137; 144)
$svg.rect(25; 35).position(137; 169).fill("yellow")
$svg.preview()