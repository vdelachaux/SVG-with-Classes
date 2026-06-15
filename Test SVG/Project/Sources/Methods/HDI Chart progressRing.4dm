//%attributes = {}

var $chart:=cs:C1710.svgx.chart.new()

$chart.newCanvas({width: 700; height: 450; viewBox: "0 0 700 450"})

$chart.text("HDI Chart: progressRing").position(40; 26).fontSize(16).fontStyle(Bold:K14:2).fillColor("#1d3557")

// Example 1: default options
$chart.progressRing("ring_1"; 150; 180; 70; 68; 100; {\
showValue: True:C214\
})
$chart.text("68 / 100").position(150; 290).fontSize(16).setAttribute("text-anchor"; "middle").fillColor("#666").fontStyle(Bold:K14:2)

// Example 2: custom colors and thickness
$chart.progressRing("ring_2"; 350; 180; 70; 42; 80; {\
thickness: 0.62; \
origin: -90; \
trackColor: "#edf2f7"; \
color: "#ff7f11"; \
showValue: True:C214; \
valueFont: {size: 22; style: Bold:K14:2; color: "#4a4a4a"}\
})
$chart.text("42 / 80").position(350; 290).fontSize(16).setAttribute("text-anchor"; "middle").fillColor("#666").fontStyle(Bold:K14:2)

// Example 3: clamped value + custom label (value > max)
$chart.progressRing("ring_3"; 550; 180; 70; 140; 120; {\
thickness: 0.75; \
trackColor: "#f1f5f9"; \
color: "#2a9d8f"; \
showValue: True:C214; \
label: "116.7%"; \
valueFont: {size: 20; style: Bold:K14:2; color: "#2a9d8f"}\
})
$chart.text("value > max (clamped)").position(550; 290).fontSize(16).setAttribute("text-anchor"; "middle").fillColor("#666").fontStyle(Bold:K14:2)

$chart.preview()