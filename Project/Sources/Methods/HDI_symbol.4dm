//%attributes = {}
var $ref : Text
var $chart : cs:C1710.chart

$chart:=cs:C1710.chart.new()\
.title("Example symbol & use")\
.desc("Prepare elements then place them where you want")

// Mark:-Prepare the elements
$chart.donut("1st"; 200; 200; 120).stroke("lightgray")
$chart.wedge("1st"; 25).fill("lemonchiffon")
$chart.wedge("1st"; 12).fill("thistle")
$chart.wedge("1st"; 25).fill("palegreen")
$chart.wedge("1st"; 40).fill("lightcyan")
$chart.symbol("donut"; "1st")  // Making it a symbol

$chart.pie("2nd"; 200; 200; 120)
$chart.wedge("2nd"; 15).fill("mediumaquamarine")
$chart.wedge("2nd"; 35).fill("yellow")
$chart.wedge("2nd"; 50).fill("royalblue")
$chart.symbol("pie"; "2nd")  // Making it a symbol

$chart.fivePointStar(125*2; 350; 200).color("red")
$chart.symbol("star"; $chart.latest)  // Making it a symbol

// Mark:-Place elements where you want them
$chart.use("donut"; $chart.root).position(10; 10)
$chart.use("pie"; $chart.root).position(10; 400)
$chart.use("star"; $chart.root).position(300; 80).scale(0.5)

$chart.preview()