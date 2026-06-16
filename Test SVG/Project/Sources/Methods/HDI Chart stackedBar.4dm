//%attributes = {}
var $chart:=cs:C1710.svgx.chart.new()

$chart.newCanvas({width: 1080; height: 700; viewBox: "0 0 1080 700"})

$chart.text("HDI Chart: stackedBar").position(40; 30).fontSize(18).fontStyle(Bold:K14:2).fillColor("#1d3557")

var $data:=[\
{label: "Jan"; segments: [\
{value: 35; color: "#3b82f6"}; \
{value: 22; color: "#f97316"}; \
{value: 18; color: "#22c55e"}\
]}; \
{label: "Feb"; segments: [\
{value: 30; color: "#3b82f6"}; \
{value: 28; color: "#f97316"}; \
{value: 14; color: "#22c55e"}\
]}; \
{label: "Mar"; segments: [\
{value: 42; color: "#3b82f6"}; \
{value: 26; color: "#f97316"}; \
{value: 20; color: "#22c55e"}\
]}; \
{label: "Apr"; segments: [\
{value: 38; color: "#3b82f6"}; \
{value: 19; color: "#f97316"}; \
{value: 24; color: "#22c55e"}\
]}\
]

$chart.text("Vertical stacked").position(250; 70).fontSize(14).fontStyle(Bold:K14:2).fillColor("#334155")
$chart.verticalStackedBar("vstack"; 40; 90; 440; 260; {\
data: $data; \
showLabels: True:C214; \
showValues: True:C214; \
axis: True:C214; \
stroke: "white"\
})

$chart.text("Horizontal stacked").position(250; 420).fontSize(14).fontStyle(Bold:K14:2).fillColor("#334155")
$chart.horizontalStackedBar("hstack"; 40; 440; 440; 200; {\
data: $data; \
showLabels: True:C214; \
showValues: True:C214; \
axis: True:C214; \
stroke: "white"\
})

// Legend
$chart.rect(16; 16).position(620; 160).fill("#3b82f6")
$chart.text("Produit A").position(644; 174).fontSize(14).fillColor("#334155")
$chart.rect(16; 16).position(620; 190).fill("#f97316")
$chart.text("Produit B").position(644; 204).fontSize(14).fillColor("#334155")
$chart.rect(16; 16).position(620; 220).fill("#22c55e")
$chart.text("Produit C").position(644; 234).fontSize(14).fillColor("#334155")

$chart.preview()
