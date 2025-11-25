//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

$svg.group().scale(4)

// ⚠️ "tspan" are only rendered if they are in a "text" element.

// First create a text element
$svg.text("My").fontFamily("sans-serif").fontSize(13).fontStyle(Italic:K14:3).position(20; 35)

// Then append tspan elements
// ⚠️ Styles are added to the text container.
$svg.tspan("cat").y(35).fontStyle(Plain:K14:1).font({style: Bold:K14:2; size: 30; family: "sans-serif"})
$svg.tspan("is").y(55).dx(-30).font({style: Italic:K14:3; size: 13; family: "sans-serif"})
$svg.tspan("Grumpy!").y(55).font({style: Italic:K14:3; size: 40; family: "serif"; color: "darksalmon"})
$svg.closeCurrent()  // Close the text element & restore parent container (here the first group)

$svg.group().stroke("silver")
$svg.line(10; 60; 160; 60)
$svg.line(170; 60; 180; 60)
$svg.line(190; 60; 210; 60)

// Return to the main group (the 1st element of the root)
$svg.latest:=$svg.firstChild()

$svg.text("My").fontFamily("sans-serif").fontSize(13).fontStyle(Italic:K14:3).position(20; 100).rotate(-10)
$svg.tspan("dog").y(100).dx(0).fontStyle(Plain:K14:1).font({style: Bold:K14:2; size: 30; family: "sans-serif"})
$svg.tspan("is").y(120).dx(-30).font({style: Italic:K14:3; size: 13; family: "sans-serif"})
$svg.tspan("Grouchy!").y(120).font({style: Italic:K14:3; size: 40; family: "serif"; color: "mediumseagreen"})  // .rotate(5)
$svg.closeCurrent()  // Close the text element & restore parent container (here the first group)

$svg.group().stroke("silver").rotate(-10)
$svg.line(10; 125; 200; 125)
$svg.line(210; 125; 220; 125)

$svg.preview()