//%attributes = {}

var $chart:=cs:C1710.svgx.chart.new()

$chart.newCanvas({width: 900; height: 650; viewBox: "0 0 900 650"})

$chart.text("Heatmap Charts - Matrix Visualization").position(450; 40).setAttribute("text-anchor"; "middle").fontSize(36).fontStyle(Bold:K14:2).fillColor("#163a7a")

// Sample heatmap data (5x7 matrix)
var $heatmapData : Collection:=[[\
	12; 19; 8; 15; 22; 17; 25]; \
	[45; 38; 42; 35; 48; 50; 43]; \
	[8; 12; 6; 14; 10; 16; 9]; \
	[100; 95; 105; 98; 110; 108; 115]; \
	[25; 30; 28; 32; 35; 33; 38]\
	]

var $rowLabels : Collection:=["Week 1"; "Week 2"; "Week 3"; "Week 4"; "Week 5"]
var $colLabels : Collection:=["Mon"; "Tue"; "Wed"; "Thu"; "Fri"; "Sat"; "Sun"]

$chart.text("Website Traffic by Day").position(120; 100).fontSize(16).fontStyle(Bold:K14:2).fillColor("#333")

$chart.heatmap("hmap1"; 100; 130; 280; 200; {\
	data: $heatmapData; \
	rowLabels: $rowLabels; \
	colLabels: $colLabels; \
	showRowLabels: true; \
	showColLabels: true; \
	showValues: true; \
	colors: ["#0571B0"; "#2E8BC0"; "#92C5DE"; "#F7F7F7"; "#F4A582"; "#E08214"; "#B35806"]\
	})

// Second heatmap with different color scheme
$chart.text("Temperature Distribution").position(520; 100).fontSize(16).fontStyle(Bold:K14:2).fillColor("#333")

var $tempData : Collection:=[[\
	15; 16; 17; 18; 19; 20; 21]; \
	[14; 15; 16; 17; 18; 19; 20]; \
	[12; 13; 14; 15; 16; 17; 18]; \
	[10; 11; 12; 13; 14; 15; 16]; \
	[8; 9; 10; 11; 12; 13; 14]\
	]

$chart.heatmap("hmap2"; 500; 130; 280; 200; {\
	data: $tempData; \
	rowLabels: $rowLabels; \
	colLabels: $colLabels; \
	showRowLabels: true; \
	showColLabels: true; \
	showValues: true; \
	colors: ["#1A237E"; "#283593"; "#3F51B5"; "#7986CB"; "#FFEB3B"; "#FFA726"; "#D84315"]\
	})

$chart.preview()
