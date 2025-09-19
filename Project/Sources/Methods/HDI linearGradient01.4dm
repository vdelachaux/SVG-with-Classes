//%attributes = {}
/* OLD CODE

$svg:=SVG_New

SVG_Define_linear_gradient($svg; "demoGradient_1"; "red"; "yellow")
SVG_New_rect($svg; 10; 10; 90; 90; 0; 0; "black"; "url(#demoGradient_1)")
SVG_New_text($svg; "rotation = 0\rrotation = 180"; 50; 40; ""; -1; -1; Align center)

SVG_Define_linear_gradient($svg; "demoGradient_2"; "red"; "yellow"; -180)
SVG_New_rect($svg; 110; 10; 90; 90; 0; 0; "black"; "url(#demoGradient_2)")
SVG_New_text($svg; "rotation = -180"; 150; 50; ""; -1; -1; Align center)

SVG_Define_linear_gradient($svg; "demoGradient_3"; "red"; "yellow"; 45)
SVG_New_rect($svg; 10; 110; 90; 90; 0; 0; "black"; "url(#demoGradient_3)")
SVG_New_text($svg; "rotation = 45"; 50; 150; ""; -1; -1; Align center)

SVG_Define_linear_gradient($svg; "demoGradient_4"; "red"; "yellow"; -45)
SVG_New_rect($svg; 110; 110; 90; 90; 0; 0; "black"; "url(#demoGradient_4)")
SVG_New_text($svg; "rotation = -45"; 150; 150; ""; -1; -1; Align center)

SVG_Define_linear_gradient($svg; "demoGradient_5"; "red"; "yellow"; 90)
SVG_New_rect($svg; 10; 210; 90; 90; 0; 0; "black"; "url(#demoGradient_5)")
SVG_New_text($svg; "rotation = 90"; 50; 250; ""; -1; -1; Align center)

SVG_Define_linear_gradient($svg; "demoGradient_6"; "red"; "yellow"; -90)
SVG_New_rect($svg; 110; 210; 90; 90; 0; 0; "black"; "url(#demoGradient_6)")
SVG_New_text($svg; "rotation = -90"; 150; 250; ""; -1; -1; Align center)

SVG_Define_linear_gradient($svg;"demoGradient_6";"red";"yellow";-180;"reflect")
SVG_New_rect($svg;10;10;90;90;0;0;"black";"url(#demoGradient_6)")
SVG_New_text($svg;"offset=0/100";50;50;"";-1;-1;Align center)
 
SVG_Define_linear_gradient($svg;"demoGradient_7";"red";"yellow";-180;"reflect";20;80)
SVG_New_rect($svg;110;10;90;90;0;0;"black";"url(#demoGradient_7)")
SVG_New_text($svg;"offset=20/80";150;50;"";-1;-1;Align center)

SVGTool_SHOW_IN_VIEWER($svg)
*/

var $svg:=cs:C1710.svg.new()

$svg.linearGradient("demoGradient_1"; "red"; "yellow")
$svg.rect(90; 90).position(10; 10).fill("url(#demoGradient_1)")
$svg.textArea("rotation = 0\rrotation = 180").position(10; 100).width(90).alignment(Align center:K42:3)

$svg.linearGradient("demoGradient_2"; "red"; "yellow"; {rotation: -180})
$svg.rect(90; 90).position(110; 10).fill("url(#demoGradient_2)")
$svg.textArea("rotation = -180").position(110; 100).width(100).alignment(Align center:K42:3)

$svg.linearGradient("demoGradient_3"; "red"; "yellow"; {rotation: 45})
$svg.rect(90; 90).position(10; 140).fill("url(#demoGradient_3)")
$svg.textArea("rotation = 45").position(10; 230).width(90).alignment(Align center:K42:3)

$svg.linearGradient("demoGradient_4"; "red"; "yellow"; {rotation: -45})
$svg.rect(90; 90).position(110; 140).fill("url(#demoGradient_4)")
$svg.textArea("rotation = -45").position(110; 230).width(90).alignment(Align center:K42:3)

$svg.linearGradient("demoGradient_5"; "red"; "yellow"; {rotation: 90})
$svg.rect(90; 90).position(10; 270).fill("url(#demoGradient_5)")
$svg.textArea("rotation = 90").position(10; 360).width(90).alignment(Align center:K42:3)

$svg.linearGradient("demoGradient_6"; "red"; "yellow"; {rotation: -90})
$svg.rect(90; 90).position(110; 270).fill("url(#demoGradient_6)")
$svg.textArea("rotation = -90").position(110; 360).width(90).alignment(Align center:K42:3)

$svg.linearGradient("demoGradient_6"; "red"; "yellow"; {rotation: -180; spreadMethod: "reflect"})
$svg.rect(90; 90).position(10; 400).fill("url(#demoGradient_6)")
$svg.textArea("rotation = -180\roffset=0/100").position(10; 490).width(100).alignment(Align center:K42:3)

$svg.linearGradient("demoGradient_7"; "red"; "yellow"; {rotation: -180; spreadMethod: "reflect"; startOffset: 20; stopOffset: 80})
$svg.rect(90; 90).position(110; 400).fill("url(#demoGradient_7)")
$svg.textArea("rotation = -180\roffset=20/80").position(110; 490).width(100).alignment(Align center:K42:3)

$svg.preview()
