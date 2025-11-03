//%attributes = {}
var $chart:=cs:C1710.svgx.chart.new()

$chart.horizontalBar("myHBar"; 10; 10; 400; 200; {\
data: [\
{label: "A"; value: 120; color: "tomato"}; \
{label: "B"; value: 80}; \
{label: "C"; value: 200; color: "steelblue"}\
]; \
gap: 0.2; \
showValues: True:C214; \
showLabels: True:C214; \
axis: True:C214\
})

$chart.preview()