//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()


$svg.group("hello")  // it's the first so at root

$svg.cursor:="root"  // Reset the cursor to the root
$svg.group("world"; "hello")  //in the previous one

$svg.group("leMonde"; "root")  // force at root

$svg.cursor:="world"
$svg.group("Bonjour")

$svg.text("Hello")
$svg.tspan("world")

$svg.group("toto")  // must not be in to text or tspan

$svg.group("titi")  // must be in toto

$svg.group().translate(50; 20)
$svg.text("Hello\rWorld").fontSize(20).alignment(Align center:K42:3)

$svg.preview()