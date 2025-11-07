//%attributes = {}
var $chart:=cs:C1710.svgx.chart.new()

// Default font properties
var $font:=cs:C1710.svgx.font.new()
$font.style:=Bold:K14:2

// Labels font properties
var $labels:=cs:C1710.svgx.font.new()
$labels.size:=14
$labels.style:=Bold:K14:2
$labels.rotation:=-30
$labels.color:="red"

// Series
var $data:=[\
{label: "Jan"; value: 120; color: "yellow"; stroke: True:C214}; \
{label: "Feb"; value: 80; color: "tomato"}; \
{label: "Mar"; value: 200}; \
{label: "Apr"; value: 150}; \
{label: "May"; value: 180; stroke: "darkgreen"}; \
{label: "Jun"; value: 40}\
]

// Values font properties
var $values:=cs:C1710.svgx.font.new()
$values.style:=Bold:K14:2

var $options:={\
font: $font; \
data: $data; \
showValues: True:C214; \
labels: $labels; \
axis: True:C214; \
horizontalGridLines: {unit: 40; color: "blue"; dash: 4}; \
zoom: 1.5\
}

// Plot chart
$chart.verticalBar("demo_vertical_bar"; 10; 10; 400; 300; $options)

// Preview result
$chart.preview()
