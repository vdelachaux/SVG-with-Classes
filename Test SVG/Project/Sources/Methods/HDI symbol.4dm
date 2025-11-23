//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()\
.desc("ℹ️ Create a complex symbol once and use it as many times as you want.")


// Define a symbol consisting of 2 squares and 2 circles
var $group : Text:=$svg.group().latest
$svg.circle(25; 30; 30).stroke("red").fill("palevioletred")
$svg.rect(40).position(10; 60).stroke("blue").fill("cornflowerblue")
$svg.rect(40).position(60; 10).stroke("blue").fill("cornflowerblue")
$svg.circle(25; 80; 80).stroke("red").fill("palevioletred")

// 💡 A symbol can be defined by passing the reference of the source element.
$svg.symbol("mySymbol"; $group)

// Draw a background
$svg.rect(650; 650).stroke("gray").fill("lemonchiffon").translate(20; 20)

// Place the pattern 36 times, varying their position, opacity, and rotation
$svg.group().translate(20; 20)

var $x; $y : Integer

For ($x; 0; 540; 90)  // 6 columns
	
	For ($y; 0; 540; 90)  // 6 rows
		
		$svg.use("mySymbol").width(110).height(110).position($x; $y).opacity(100-($y/6)+($x/6)).rotate(($x*(18/50))+($y*(18/50)); ($x+55); ($y+55))
		
	End for 
End for 

$svg.preview()