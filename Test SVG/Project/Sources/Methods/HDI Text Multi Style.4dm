//%attributes = {}
// Test de la nouvelle fonctionnalité de texte multi-style
// La fonction text() détecte automatiquement les spans HTML et les convertit en tspans SVG

var $svg:=cs:C1710.svgx.svg.new()

$svg.newCanvas({\
width: 600; \
height: 600; \
viewBox: "0 0 600 600"})

// Titre
$svg.text("Multi-Style Text Examples").position(10; 30).fontSize(18).fillColor("navy")

// ═════════════════════════════════════════════════════════════════════
// Exemple 1: Texte Hello World avec styles différents
// ═════════════════════════════════════════════════════════════════════

var $helloWorld:=\
"<span style=\"font-size:18pt\">Hello </span>"+\
"<span style=\"font-size:24pt;font-weight:bold;color:#D81E05\">World</span>"+\
"<span style=\"font-size:36pt\">!</span>"

$svg.text($helloWorld).position(20; 80)

// ═════════════════════════════════════════════════════════════════════
// Exemple 2: Texte multi-ligne avec <br/>
// ═════════════════════════════════════════════════════════════════════

var $multiLine:=\
"<span style=\"font-size:19pt;font-style:italic\">It's </span>"+\
"<span style=\"font-size:24pt;font-weight:bold\">Monday</span><br/>"+\
"<span style=\"font-size:16pt;color:green\">Have a great day!</span>"

$svg.textArea($multiLine).position(20; 150)

// ═════════════════════════════════════════════════════════════════════
// Exemple 3: Texte avec couleurs variées
// ═════════════════════════════════════════════════════════════════════

var $colorful:=\
"<span style=\"color:red\">Red </span>"+\
"<span style=\"color:orange\">Orange </span>"+\
"<span style=\"color:gold\">Yellow </span>"+\
"<span style=\"color:green\">Green </span>"+\
"<span style=\"color:blue\">Blue </span>"+\
"<span style=\"color:purple\">Purple</span>"

$svg.text($colorful).position(20; 250).fontSize(48)

// ═════════════════════════════════════════════════════════════════════
// Exemple 4: Combinaison de tous les styles
// ═════════════════════════════════════════════════════════════════════

var $allStyles:=\
"<span style=\"font-size:14pt;color:darkblue;font-weight:bold\">BOLD</span> "+\
"<span style=\"font-size:14pt;color:darkred;font-style:italic\">italic</span> "+\
"<span style=\"font-size:12pt;color:gray\">small</span>"

$svg.textArea($allStyles).position(20; 320)

// Afficher en aperçu
$svg.preview()

