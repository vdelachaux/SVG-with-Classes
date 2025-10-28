//%attributes = {}
var $i : Integer
var $options : Object
var $colors; $data; $values : Collection
var $chart : cs:C1710.svgx.chart

$chart:=cs:C1710.svgx.chart.new()\
.title("Example pieChart02 - make a pie chart")\
.desc("Picture of a pie chart with the pie command")

$chart.group().stroke("blue")
$chart.rect(1000; 398).position(1; 1)

// Mark:- First pie-chart
$options:={}

// Specify values only, color will be automatic
$options.data:=[\
{value: 56}; \
{value: 125}; \
{value: 56}; \
{value: 100}; \
{value: 124}; \
{value: 236}; \
{value: 45}; \
{value: 200}; \
{value: 89}; \
{value: 12}; \
{value: 20}\
]

// Set the stroke color
$options.stroke:="lightgrey"

// Want to order the values
$options.orderBy:="asc"

$chart.pie("1st"; 200; 200; 120; $options)

// Mark:-Second pie-chart - Specify values & colors
$values:=[5.25; 8.75; 12.5; 8; 6; 12.5; 6; 14; 7]
$colors:=Split string:C1554("yellow,royalblue,coral,crimson,gold,darkkhaki,rosybrown,violet,mediumaquamarine"; ",")

$data:=[]

For ($i; 0; $values.length-1; 1)
	
	$data.push({value: $values[$i]; color: $colors[$i]})
	
End for 

$chart.pieBounded("2nd"; 550; 30; 340; {data: $data; stroke: "none"})

$chart.preview()