//%attributes = {}
var $chart:=cs:C1710.svgx.chart.new()

$chart.newCanvas({width: 1100; height: 720; viewBox: "0 0 1100 720"})

$chart.text("HDI Chart: groupedBar").position(40; 30).fontSize(18).fontStyle(Bold:K14:2).fillColor("#1d3557")
$chart.text("Vertical grouped").position(250; 70).fontSize(14).fontStyle(Bold:K14:2).fillColor("#334155")
$chart.text("Horizontal grouped").position(250; 418).fontSize(14).fontStyle(Bold:K14:2).fillColor("#334155")

var $data:=[\
{label: "Jan"; groups: [\
{value: 42; color: "#3b82f6"; name: "Produit A"}; \
{value: 26; color: "#f97316"; name: "Produit B"}; \
{value: 18; color: "#22c55e"; name: "Produit C"}\
]}; \
{label: "Feb"; groups: [\
{value: 35; color: "#3b82f6"; name: "Produit A"}; \
{value: 31; color: "#f97316"; name: "Produit B"}; \
{value: 22; color: "#22c55e"; name: "Produit C"}\
]}; \
{label: "Mar"; groups: [\
{value: 46; color: "#3b82f6"; name: "Produit A"}; \
{value: 29; color: "#f97316"; name: "Produit B"}; \
{value: 26; color: "#22c55e"; name: "Produit C"}\
]}; \
{label: "Apr"; groups: [\
{value: 39; color: "#3b82f6"; name: "Produit A"}; \
{value: 24; color: "#f97316"; name: "Produit B"}; \
{value: 21; color: "#22c55e"; name: "Produit C"}\
]}\
]

$chart.verticalGroupedBar("vgroup"; 40; 90; 460; 280; {\
data: $data; \
showLabels: True:C214; \
showValues: True:C214; \
axis: True:C214; \
stroke: "white"\
})

$chart.horizontalGroupedBar("hgroup"; 40; 450; 460; 220; {\
data: $data; \
showLabels: True:C214; \
showValues: True:C214; \
axis: True:C214; \
stroke: "white"\
})

// Legend
$chart.rect(16; 16).position(650; 170).fill("#3b82f6")
$chart.text("Produit A").position(674; 184).fontSize(14).fillColor("#334155")
$chart.rect(16; 16).position(650; 200).fill("#f97316")
$chart.text("Produit B").position(674; 214).fontSize(14).fillColor("#334155")
$chart.rect(16; 16).position(650; 230).fill("#22c55e")
$chart.text("Produit C").position(674; 244).fontSize(14).fillColor("#334155")

$chart.preview()
