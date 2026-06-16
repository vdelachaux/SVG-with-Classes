//%attributes = {}

var $chart:=cs:C1710.chart.new()

$chart.newCanvas({width: 800; height: 500; viewBox: "0 0 800 500"})

$chart.text("Sparklines - KPI Metrics").position(400; 40).setAttribute("text-anchor"; "middle").fontSize(36).fontStyle(Bold:K14:2).fillColor("#163a7a")

// Sample data sets for sparklines
var $data1 : Collection:=[12; 19; 8; 15; 22; 17; 25; 20; 18; 24; 21]
var $data2 : Collection:=[45; 38; 42; 35; 48; 50; 43; 46; 44; 52; 55]
var $data3 : Collection:=[8; 12; 6; 14; 10; 16; 9; 13; 11; 15; 12]
var $data4 : Collection:=[100; 95; 105; 98; 110; 108; 115; 112; 118; 120; 125]

// Row 1: Sales
$chart.text("Sales").position(50; 110).fontSize(18).fontStyle(Bold:K14:2).fillColor("#333")
$chart.sparkline("spark_sales"; 50; 130; 300; 60; {data: $data1; color: "#2196F3"; fill: true; fillColor: "rgba(33, 150, 243, 0.2)"})

$chart.text("Revenue").position(450; 110).fontSize(18).fontStyle(Bold:K14:2).fillColor("#333")
$chart.sparkline("spark_revenue"; 450; 130; 300; 60; {data: $data2; color: "#4CAF50"; fill: true; fillColor: "rgba(76, 175, 80, 0.2)"})

// Row 2: Traffic & Errors
$chart.text("Traffic").position(50; 260).fontSize(18).fontStyle(Bold:K14:2).fillColor("#333")
$chart.sparkline("spark_traffic"; 50; 280; 300; 60; {data: $data3; color: "#FF9800"; fill: true; fillColor: "rgba(255, 152, 0, 0.2)"})

$chart.text("Users").position(450; 260).fontSize(18).fontStyle(Bold:K14:2).fillColor("#333")
$chart.sparkline("spark_users"; 450; 280; 300; 60; {data: $data4; color: "#E91E63"; fill: true; fillColor: "rgba(233, 30, 99, 0.2)"})

$chart.preview()
