//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()
/*

A relative URL ("../picture.png") is particularly useful in client/server mode, 
when files are stored in the "Resources" folder. 

Relatives URLs can begin with:
"/", to indicate the "~/Resources/SVG/" path
"./", to indicate the "~/Resources/" path
"../", to indicate the package folder.

*/

// base is the database's folder
$svg.image("../apple.png")

// base is the "Resources/SVG" folder
$svg.image("/4d.svg").size(100; 100).position(100; 100)

// base is the "Resources" folder
$svg.image("./Relative URLs/medias/php.gif").size(80).position(30; 50)


$svg.group().translate(400; 100)
$svg.image("https://fr.4d.com/sites/all/themes/bactency/logo.png").setAttribute("width"; "20%").setAttribute("height"; "20%")

$svg.preview()