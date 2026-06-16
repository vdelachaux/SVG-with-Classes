//%attributes = {}

var $chart:=cs:C1710.chart.new()

$chart.newCanvas({width: 900; height: 650; viewBox: "0 0 900 650"})

$chart.text("Waterfall Charts - Cumulative Analysis").position(450; 40).setAttribute("text-anchor"; "middle").fontSize(36).fontStyle(Bold:K14:2).fillColor("#163a7a")

// Vertical Waterfall - Financial Analysis
$chart.text("2024 Profit Analysis (Vertical)").position(180; 100).fontSize(16).fontStyle(Bold:K14:2).fillColor("#333")

var $vwaterfallData : Collection:=[\
	{label: "Start"; value: 0; isTotal: true; color: "#1f2937"}; \
	{label: "Revenue"; value: 150}; \
	{label: "COGS"; value: -60}; \
	{label: "OpEx"; value: -25}; \
	{label: "Tax"; value: -15}; \
	{label: "Final"; value: 50; isTotal: true; color: "#1f2937"}\
	]

$chart.verticalWaterfall("vwf"; 50; 130; 300; 280; {\
	data: $vwaterfallData; \
	showLabels: true; \
	showValues: true; \
	axis: true; \
	padding: 12\
	})

// Horizontal Waterfall - Performance Breakdown
$chart.text("Q4 Performance Breakdown (Horizontal)").position(550; 100).fontSize(16).fontStyle(Bold:K14:2).fillColor("#333")

var $hwaterfallData : Collection:=[\
	{label: "Target"; value: 100; isTotal: true; color: "#1f2937"}; \
	{label: "Base Sales"; value: 120}; \
	{label: "Discounts"; value: -15}; \
	{label: "Returns"; value: -8}; \
	{label: "Bonus Sales"; value: 25}; \
	{label: "Actual"; value: 122; isTotal: true; color: "#1f2937"}\
	]

$chart.horizontalWaterfall("hwf"; 420; 130; 350; 220; {\
	data: $hwaterfallData; \
	showLabels: true; \
	showValues: true; \
	axis: true; \
	padding: 15\
	})

$chart.preview()
