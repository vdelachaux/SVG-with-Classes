//%attributes = {}
var $chart:=cs:C1710.svgx.chart.new()

// Simple example
$chart.verticalBar("demo1"; 10; 10; 400; 300; {\
data: [\
{label: "Jan"; value: 120; color: "tomato"}; \
{label: "Feb"; value: 80}; \
{label: "Mar"; value: 200; color: "steelblue"}; \
{label: "Apr"; value: 150}; \
{label: "May"; value: 180}\
]; \
barGap: 0.2; \
showValues: True:C214; \
showLabels: True:C214; \
axis: True:C214\
})

// Preview result
$chart.preview()