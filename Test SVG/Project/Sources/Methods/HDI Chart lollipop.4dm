//%attributes = {}

var $chart:=cs:C1710.chart.new()

$chart.newCanvas({width: 800; height: 600; viewBox: "0 0 800 600"})

$chart.text("Lollipop Charts - Elegant Data Visualization").position(400; 40).setAttribute("text-anchor"; "middle").fontSize(36).fontStyle(Bold:K14:2).fillColor("#163a7a")

// Vertical Lollipop Chart
$chart.text("Sales by Quarter (Vertical)").position(200; 100).fontSize(16).fontStyle(Bold:K14:2).fillColor("#333")

var $vdata : Collection:=[\
	{label: "Q1"; value: 45}; \
	{label: "Q2"; value: 52}; \
	{label: "Q3"; value: 38}; \
	{label: "Q4"; value: 61}\
	]

$chart.verticalLollipop("vlollipop"; 50; 130; 300; 200; {\
	data: $vdata; \
	showLabels: true; \
	showValues: true; \
	axis: true; \
	circleRadius: 5; \
	max: 70\
	})

// Horizontal Lollipop Chart
$chart.text("Department Performance (Horizontal)").position(200; 380).fontSize(16).fontStyle(Bold:K14:2).fillColor("#333")

var $hdata : Collection:=[\
	{label: "Engineering"; value: 92}; \
	{label: "Sales"; value: 78}; \
	{label: "Marketing"; value: 85}; \
	{label: "Support"; value: 88}; \
	{label: "Operations"; value: 72}\
	]

$chart.horizontalLollipop("hlollipop"; 50; 420; 400; 150; {\
	data: $hdata; \
	showLabels: true; \
	showValues: true; \
	axis: true; \
	circleRadius: 6; \
	max: 100\
	})

$chart.preview()
