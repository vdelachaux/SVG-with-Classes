//%attributes = {}
var $chart:=cs:C1710.svgx.chart.new()

// Simple example
$chart.verticalBar("demo_vertical_bar"; 10; 10; 400; 300; {\
data: [\
{label: "Jan"; value: 120; color: "yellow"; stroke: True:C214}; \
{label: "Feb"; value: 80; color: "tomato"}; \
{label: "Mar"; value: 200}; \
{label: "Apr"; value: 150}; \
{label: "May"; value: 180; stroke: "darkgreen"}; \
{label: "Jun"; value: 40}\
]; \
gap: 0.2; \
showValues: True:C214; \
font: {style: Bold:K14:2}; \
labels: {angle: -30; font: {size: 14; style: Bold:K14:2}}; \
axis: True:C214; \
horizontalGridLines: {unit: 40; color: "blue"}\
})

//font: {size: 14; style: Bold}; 

// Preview result
$chart.preview()