//%attributes = {}

var $chart:=cs:C1710.svgx.chart.new()

$chart.newCanvas({width: 1000; height: 550; viewBox: "0 0 1000 550"})

$chart.text("Radar Charts - Multi-Criteria Evaluation").position(500; 40).setAttribute("text-anchor"; "middle").fontSize(36).fontStyle(Bold:K14:2).fillColor("#163a7a")

// Employee Evaluation Radar
$chart.text("Employee Skills Assessment").position(250; 100).setAttribute("text-anchor"; "middle").fontSize(16).fontStyle(Bold:K14:2).fillColor("#333")

var $skillLabels : Collection:=["Technical"; "Communication"; "Leadership"; "Problem-Solving"; "Teamwork"; "Creativity"]

var $radarData1 : Object:={\
	labels: $skillLabels; \
	series: [\
		{label: "Alice"; values: [9; 8; 7; 9; 8; 7]; color: "#FF6B6B"}; \
		{label: "Bob"; values: [7; 9; 8; 7; 9; 8]; color: "#4ECDC4"}; \
		{label: "Charlie"; values: [8; 7; 9; 8; 7; 9]; color: "#45B7D1"}\
		]\
	}

$chart.radar("radar1"; 250; 280; 150; {data: $radarData1; max: 10; levels: 5; showLegend: false})

// Product Comparison Radar
$chart.text("Product Feature Comparison").position(750; 100).setAttribute("text-anchor"; "middle").fontSize(16).fontStyle(Bold:K14:2).fillColor("#333")

var $featureLabels : Collection:=["Performance"; "Design"; "Usability"; "Support"; "Price"; "Reliability"]

var $radarData2 : Object:={\
	labels: $featureLabels; \
	series: [\
		{label: "Product A"; values: [8; 7; 9; 6; 5; 9]; color: "#FFD93D"}; \
		{label: "Product B"; values: [7; 9; 7; 8; 8; 7]; color: "#6BCB77"}; \
		{label: "Product C"; values: [9; 8; 8; 9; 7; 8]; color: "#4D96FF"}\
		]\
	}

$chart.radar("radar2"; 750; 280; 150; {data: $radarData2; max: 10; levels: 5; showLegend: true; legendGap: 20})

$chart.preview()
