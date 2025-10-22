//%attributes = {}
var $svg:=cs:C1710.svg.new()

// Define hueRotates filters
$svg.feColorMatrix($svg.defineFilter("hue_360"); "hueRotate"; 360)
$svg.feColorMatrix($svg.defineFilter("hue_300"); "hueRotate"; 300)
$svg.feColorMatrix($svg.defineFilter("hue_240"); "hueRotate"; 240)
$svg.feColorMatrix($svg.defineFilter("hue_180"); "hueRotate"; 180)
$svg.feColorMatrix($svg.defineFilter("hue_120"); "hueRotate"; 120)
$svg.feColorMatrix($svg.defineFilter("hue_60"); "hueRotate"; 60)

// Define styles
$svg.style("#pict_1{filter:url(#hue_360);}")
$svg.style("#pict_2{filter:url(#hue_300);}")
$svg.style("#pict_3{filter:url(#hue_240);}")
$svg.style("#pict_4{filter:url(#hue_180);}")
$svg.style("#pict_5{filter:url(#hue_120);}")
$svg.style("#pict_6{filter:url(#hue_60);}")

$svg.symbol("mona")
$svg.image(File:C1566("/RESOURCES/mona.jpg"); "mona")
$svg.close()

var $i : Integer
For ($i; 0; 5; 1)
	
	$svg.use("mona").setID("pict_"+String:C10($i+1)).translate(160*$i; 50*$i)
	
End for 

$svg.preview()