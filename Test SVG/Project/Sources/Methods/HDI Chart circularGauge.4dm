//%attributes = {}
var $chart:=cs:C1710.svgx.chart.new()

$chart.newCanvas({width: 980; height: 420; viewBox: "0 0 980 420"})

$chart.text("HDI Chart: circularGauge").position(40; 30).fontSize(18).fontStyle(Bold:K14:2).fillColor("#1d3557")

var $zones : Collection:=[\
{limit: 60; color: "#22a06b"}; \
{limit: 85; color: "#ff8b00"}; \
{limit: 100; color: "#d7263d"}\
]

$chart.circularGauge("g_low"; 170; 230; 120; 35; 100; {\
zones: $zones; \
unit: "%"; \
label: "35%"; \
needleColor: "#0f172a"\
})
$chart.text("Low load").position(170; 380).setAttribute("text-anchor"; "middle").fontSize(16).fillColor("#334155")

$chart.circularGauge("g_mid"; 490; 230; 120; 72; 100; {\
zones: $zones; \
unit: "%"; \
label: "72%"; \
needleColor: "#0f172a"\
})
$chart.text("Nominal zone").position(490; 380).setAttribute("text-anchor"; "middle").fontSize(16).fillColor("#334155")

$chart.circularGauge("g_high"; 810; 230; 120; 94; 100; {\
zones: $zones; \
unit: "%"; \
label: "94%"; \
needleColor: "#0f172a"\
})
$chart.text("High zone").position(810; 380).setAttribute("text-anchor"; "middle").fontSize(16).fillColor("#334155")

$chart.preview()