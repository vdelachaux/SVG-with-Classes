//%attributes = {}

var $chart:=cs:C1710.svgx.chart.new()

$chart.newCanvas({width: 680; height: 760; viewBox: "0 0 680 760"})

$chart.text("Répartition de la facture")\
.position(340; 52)\
.setAttribute("text-anchor"; "middle")\
.fontSize(44)\
.fontStyle(Bold:K14:2)\
.fillColor("#163a7a")

var $thickness : Real:=0.62
var $margin : Integer:=2
var $radius : Real:=120

var $pink : Text:="#e63772"
var $green : Text:="#4f8b00"
var $orange : Text:="#f17d1f"
var $blue : Text:="#1271d5"

// 2025
$chart.semiDonut("bill_2025"; 190; 255; $radius; $thickness; $margin; {origin: -90})
$chart.wedge("bill_2025"; 34).fill($pink)
$chart.wedge("bill_2025"; 54).fill($green)
$chart.wedge("bill_2025"; 7).fill($orange)
$chart.wedge("bill_2025"; 5).fill($blue)
$chart.text("256 €").position(190; 125).setAttribute("text-anchor"; "middle").fontSize(40).fontStyle(Bold:K14:2).fillColor("#2c4f95")
$chart.text("2025").position(190; 325).setAttribute("text-anchor"; "middle").fontSize(34).fontStyle(Bold:K14:2).fillColor("#2c4f95")

// 2024
$chart.semiDonut("bill_2024"; 490; 255; $radius; $thickness; $margin; {origin: -90})
$chart.wedge("bill_2024"; 33).fill($pink)
$chart.wedge("bill_2024"; 56).fill($green)
$chart.wedge("bill_2024"; 6).fill($orange)
$chart.wedge("bill_2024"; 5).fill($blue)
$chart.text("247 €").position(490; 125).setAttribute("text-anchor"; "middle").fontSize(40).fontStyle(Bold:K14:2).fillColor("#2c4f95")
$chart.text("2024").position(490; 325).setAttribute("text-anchor"; "middle").fontSize(34).fontStyle(Bold:K14:2).fillColor("#2c4f95")

// 2023
$chart.semiDonut("bill_2023"; 340; 490; $radius; $thickness; $margin; {origin: -90})
$chart.wedge("bill_2023"; 35).fill($pink)
$chart.wedge("bill_2023"; 53).fill($green)
$chart.wedge("bill_2023"; 6).fill($orange)
$chart.wedge("bill_2023"; 6).fill($blue)
$chart.text("249 €").position(340; 360).setAttribute("text-anchor"; "middle").fontSize(40).fontStyle(Bold:K14:2).fillColor("#2c4f95")
$chart.text("2023").position(340; 560).setAttribute("text-anchor"; "middle").fontSize(34).fontStyle(Bold:K14:2).fillColor("#2c4f95")

// Legend line 1
$chart.rect(20; 20).position(160; 625).fill($pink)
$chart.text("Conso energie HT").position(190; 642).fontSize(18).fillColor("#1f376e")
$chart.rect(20; 20).position(370; 625).fill($green)
$chart.text("Abonnement HT").position(400; 642).fontSize(18).fillColor("#1f376e")

// Legend line 2
$chart.rect(20; 20).position(220; 680).fill($orange)
$chart.text("Taxe hors TVA").position(250; 697).fontSize(18).fillColor("#1f376e")
$chart.rect(20; 20).position(420; 680).fill($blue)
$chart.text("TVA").position(450; 697).fontSize(18).fillColor("#1f376e")

$chart.preview()

