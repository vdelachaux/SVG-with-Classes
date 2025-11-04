//%attributes = {}
var $chart:=cs:C1710.svgx.chart.new()

$chart.horizontalBar("myHBar"; 10; 10; 400; 200; {\
data: [\
{label: "First series"; value: 120}; \
{label: "Second series"; value: 80}; \
{label: "Third series"; value: 200}; \
{label: "Fourth series"; value: 150}\
]; \
gap: 0.2; \
showValues: True:C214; \
showLabels: True:C214; \
axis: True:C214\
})

$chart.preview()