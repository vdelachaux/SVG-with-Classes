//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

$svg.comment(" 🚧 Preparations ")

var $rotations:=[360; 300; 240; 180; 120; 60]

var $i; $r : Integer
For each ($r; $rotations)
	
	$i+=1
	
/* Define the filter */$svg.feColorMatrix($svg.defineFilter("hue_"+String:C10($r)); "hueRotate"; $r)
/* Define a style */$svg.style("#pict_"+String:C10($i)+"{filter:url(#hue_"+String:C10($r)+");}")
	
End for each 

// Define the source symbol
$svg.symbol("mona"; $svg.image(File:C1566("/RESOURCES/mona.jpg")))

$svg.comment(" Run the demo 😇 ")

$svg.group().fill("white").fontSize(24)

For ($i; 0; 5; 1)
	
	$svg.use("mona").setID("pict_"+String:C10($i+1)).translate(160*$i; 50*$i)
	$svg.text("hueRotate - "+String:C10($rotations[$i])).translate((160*$i)+20; (50*$i)+20)
	
End for 

$svg.preview()