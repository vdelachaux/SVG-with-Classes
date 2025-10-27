//%attributes = {}
/*

Draw 6 solid squares where each uses a linear gradient paint server while varying the rotation and direction of the gradient vector.

*/

var $svg:=cs:C1710.svg.new()

$svg.defineLinearGradient("demoGradient_1"; "red"; "yellow")
$svg.rect(90; 90).position(10; 10).gradient("demoGradient_1")
$svg.textArea("rotation = 0\rrotation = 180").position(10; 100).width(90).alignment(Align center:K42:3)

$svg.defineLinearGradient("demoGradient_2"; "red"; "yellow"; {rotation: -180})
$svg.rect(90; 90).position(110; 10).gradient("demoGradient_2")
$svg.textArea("rotation = -180").position(110; 100).width(100).alignment(Align center:K42:3)

$svg.defineLinearGradient("demoGradient_3"; "red"; "yellow"; {rotation: 45})
$svg.rect(90; 90).position(10; 140).gradient("demoGradient_3")
$svg.textArea("rotation = 45").position(10; 230).width(90).alignment(Align center:K42:3)

$svg.defineLinearGradient("demoGradient_4"; "red"; "yellow"; {rotation: -45})
$svg.rect(90; 90).position(110; 140).gradient("demoGradient_4")
$svg.textArea("rotation = -45").position(110; 230).width(90).alignment(Align center:K42:3)

$svg.defineLinearGradient("demoGradient_5"; "red"; "yellow"; {rotation: 90})
$svg.rect(90; 90).position(10; 270).gradient("demoGradient_5")
$svg.textArea("rotation = 90").position(10; 360).width(90).alignment(Align center:K42:3)

$svg.defineLinearGradient("demoGradient_6"; "red"; "yellow"; {rotation: -90})
$svg.rect(90; 90).position(110; 270).gradient("demoGradient_6")
$svg.textArea("rotation = -90").position(110; 360).width(90).alignment(Align center:K42:3)

/*

Draw two solid squares, each using a linear gradient paint server with the same gradient vector rotation, 
but using a start and end offset for the second one.

*/

$svg.defineLinearGradient("demoGradient_7"; "red"; "yellow"; {rotation: -180; spreadMethod: "reflect"})
$svg.rect(90; 90).position(10; 400).gradient("demoGradient_7")
$svg.textArea("rotation = -180").position(10; 490).width(100).alignment(Align center:K42:3)

$svg.defineLinearGradient("demoGradient_8"; "red"; "yellow"; {rotation: -180; spreadMethod: "reflect"; startOffset: 20; stopOffset: 80})
$svg.rect(90; 90).position(110; 400).gradient("demoGradient_8")
$svg.textArea("rotation = -180\roffset=20/80").position(110; 490).width(100).alignment(Align center:K42:3)

$svg.preview()
