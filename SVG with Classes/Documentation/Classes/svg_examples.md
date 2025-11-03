# Examples for cs.svg

Below are short examples adapted from the test methods in `Test SVG/Project/Sources/Methods`.

## Append text to a textArea
From `HDI Text Append to textArea.4dm`:

```4D
var $svg:=cs.svg.new()

$svg.rect(500; 200).position(10; 10).stroke("blue")

$svg.textArea("It is today, ")\
    .position(10; 30)\
    .width(500)\
    .height(200)\
    .fontFamily("Arial")\
    .fontSize(36)\
    .alignment(Align center)

// Append date and extra line breaks
$svg.appendText(String:C10(Current date:C33)+"\r\r")

// Append the time
$svg.appendText("and it was exactly "+String:C10(Current time:C178))

$svg.preview()
```

## Gradients

Example: linear gradients (from `HDI Gradient linear.4dm`). This shows several gradients with different rotation and spread options.

```4D
var $svg:=cs.svg.new()

$svg.defineLinearGradient("demoGradient_1"; "red"; "yellow")
$svg.rect(90; 90).position(10; 10).gradient("demoGradient_1")
$svg.textArea("rotation = 0\rrotation = 180").position(10; 100).width(90).alignment(Align center)

$svg.defineLinearGradient("demoGradient_2"; "red"; "yellow"; {rotation: -180})
$svg.rect(90; 90).position(110; 10).gradient("demoGradient_2")
$svg.textArea("rotation = -180").position(110; 100).width(100).alignment(Align center)

$svg.defineLinearGradient("demoGradient_3"; "red"; "yellow"; {rotation: 45})
$svg.rect(90; 90).position(10; 140).gradient("demoGradient_3")
$svg.textArea("rotation = 45").position(10; 230).width(90).alignment(Align center)

$svg.defineLinearGradient("demoGradient_4"; "red"; "yellow"; {rotation: -45})
$svg.rect(90; 90).position(110; 140).gradient("demoGradient_4")
$svg.textArea("rotation = -45").position(110; 230).width(90).alignment(Align center)

$svg.defineLinearGradient("demoGradient_5"; "red"; "yellow"; {rotation: 90})
$svg.rect(90; 90).position(10; 270).gradient("demoGradient_5")
$svg.textArea("rotation = 90").position(10; 360).width(90).alignment(Align center)

$svg.defineLinearGradient("demoGradient_6"; "red"; "yellow"; {rotation: -90})
$svg.rect(90; 90).position(110; 270).gradient("demoGradient_6")
$svg.textArea("rotation = -90").position(110; 360).width(90).alignment(Align center)

$svg.defineLinearGradient("demoGradient_7"; "red"; "yellow"; {rotation: -180; spreadMethod: "reflect"})
$svg.rect(90; 90).position(10; 400).gradient("demoGradient_7")
$svg.textArea("rotation = -180").position(10; 490).width(100).alignment(Align center)

$svg.defineLinearGradient("demoGradient_8"; "red"; "yellow"; {rotation: -180; spreadMethod: "reflect"; startOffset: 20; stopOffset: 80})
$svg.rect(90; 90).position(110; 400).gradient("demoGradient_8")
$svg.textArea("rotation = -180\roffset=20/80").position(110; 490).width(100).alignment(Align center)

$svg.preview()
```

Example: radial gradient (from `HDI Gradient radial.4dm`):

```4D
var $svg:=cs.svg.new()

$svg.defineRadialGradient("grad1"; "yellow"; "red")
$svg.rect(90).position(10; 10).gradient("grad1")
$svg.text("grad1").position(15; 25)

$svg.defineRadialGradient("grad2"; "yellow"; "red"; {cx: 50; cy: 50; r: 20; fx: 50; fy: 50})
$svg.rect(90).position(110; 10).gradient("grad2")
$svg.text("grad2").position(115; 25)

$svg.defineRadialGradient("grad3"; "yellow"; "red"; {cx: 80; cy: 60; r: 50; fx: 60; fy: 80})
$svg.rect(90).position(10; 110).gradient("grad3")
$svg.text("grad3").position(15; 125)

$svg.defineRadialGradient("grad4"; "yellow"; "red"; {cx: 20; cy: 50; r: 80; fx: 20; fy: 30})
$svg.rect(90).position(110; 110).gradient("grad4")
$svg.text("grad4").position(115; 125)

$svg.preview()
```

## Patterns

Example: define a pattern and use it to fill/outline (from `HDI Pattern.4dm`). Note the use of `.endPattern()` to finalize the pattern definition.

```4D
var $svg:=cs.svg.new()

$svg.comment(" 📌 Setting a pattern and using it to fill an ellipse")

$svg.definePattern("myPattern1"; {\
width: 100; \
height: 100; \
x: 0; \
y: 0; \
viewBox: [0; 0; 10; 10]})

$svg.path("myPattern1")\
.moveTo([0; 0])\
.lineTo([7; 0])\
.lineTo([3.5; 7])\
.closePath()\
.fill("lightgreen")\
.stroke("olivedrab")\
.endPattern()

$svg.ellipse(350; 150).cx(400).cy(200).stroke(5).stroke("olive").pattern("myPattern1")

$svg.comment(" 📌 Define a pattern and use it to fill and outline an ellipse\r"\
+" 🛈 Note: that the pattern was defined into the \"defs\" element ")

$svg.definePattern("myPattern2"; {\
width: 80; \
height: 80; \
x: 0; \
y: 0; \
viewBox: [0; 0; 20; 20]})

$svg.rect(20; "myPattern2").stroke("white").fill("sandybrown").endPattern()

$svg.ellipse(350; 150).cx(400).cy(200).pattern("myPattern2").pattern("myPattern2"; True).translate(100; 200)

$svg.preview()
```

## Filters

Blur example (from `HDI Filter blur.4dm`):

```4D
cs.svg.new()\
.rect(50; 50).position(50; 50).fill("blue").fillOpacity(0.5).stroke("blue").strokeOpacity(0.5).blur(4)\
.preview()
```

Drop shadow example (from `HDI Filter dropShadow.4dm`):

```4D
var $svg:=cs.svg.new()
$svg.text("Hello world").fontSize(24).position(100; 100)
$svg.rect(70; 30).rx(8).position(164; 77).color("orangered").opacity(0.3).dropShadow()
$svg.preview()
```
 
### Color matrix / saturate / hueRotate / LuminanceToAlpha
 
Example combining several `colorMatrix` usages (from `HDI Filter colorMatrix.4dm`). This demo shows how to apply a custom matrix, saturate, hue rotation and LuminanceToAlpha.
 
```4D
var $svg:=cs.svg.new()
 
var $grey:=[0.33;0.33;0.33;0;0; 0.33;0.33;0.33;0;0; 0.33;0.33;0.33;0;0; 0.33;0.33;0.33;0;0]
 
$svg.group().stroke(False).fill("coral").font({font: "Verdana"; size: 60; style: Bold})
$svg.rect(800; 100).position(2; 0)
$svg.text("No filter").position(50; 70).fill("black")
$svg.rect(800; 100).position(2; 100).colorMatrix("matrix"; $grey)
$svg.text("Matrix").position(50; 170).fill("black")
$svg.rect(800; 100).position(2; 200).colorMatrix("saturate"; 0.5)
$svg.text("Saturate (0.5)").position(50; 270).fill("black")
$svg.rect(800; 100).position(2; 300).colorMatrix("hueRotate"; 90)
$svg.text("HueRotate (90)").position(50; 370).fill("black")
$svg.rect(800; 100).position(2; 400).colorMatrix("LuminanceToAlpha")
$svg.text("Luminance").position(50; 470).fill("black")
 
$svg.preview()
```
 
### Convert to greyscale (helper)
 
Quick example using `.convertToGrayScale()` (from `HDI Filter convertToGreyScale.4dm`). The optional parameter is the percentage (0..100) or 0..1 real.
 
```4D
var $svg:=cs.svg.new().fontSize(40)
 
$svg.image(File("/RESOURCES/lena.jpg")).position(5; 5)
$svg.text("Original").position(80; 100).color("white").dropShadow()
 
$svg.image(File("/RESOURCES/lena.jpg")).position(5; 5).convertToGrayScale(50).translate(250; 340)
$svg.text("50%").position(350; 440).color("white").dropShadow()
 
$svg.image(File("/RESOURCES/lena.jpg")).position(5; 5).convertToGrayScale().translate(80; 700)
$svg.text("Visual perception").position(180; 820).color("white").dropShadow()
 
$svg.preview()
```
 
### LuminanceToAlpha
 
Example: convert image luminance to alpha channel (from `HDI Filter LuminanceToAlpha.4dm`).
 
```4D
cs.svg.new().image(File("/RESOURCES/lena.jpg")).position(5;5).colorMatrix("LuminanceToAlpha").preview()
```
 
### Liquid glass / non-scaling stroke
 
The `liquidGlass` demo shows composition: gradients + blur + non-scaling stroke + drop shadow. Useful to demonstrate `.nonScalingStroke(True)`.
 
```4D
var $svg:=cs.svg.new()
 
$svg.defineLinearGradient("linearLiquidGlass"; "white"; "silver"; {rotation: -90; startOffset: 20})
$svg.defineRadialGradient("radialLiquidGlass"; "white"; "silver")
 
$svg.image(File("/RESOURCES/lena.jpg"))
 
$svg.group().gradient("linearLiquidGlass")
$svg.rect(602; 102).position(9; 99).radius(20).fillOpacity(0.4).stroke(False).blur()
$svg.group().strokeOpacity(0.5).nonScalingStroke(True)
$svg.rect(600; 101).position(11; 100).radius(20).fill(False).stroke("white")
$svg.rect(600; 100).position(10; 100).radius(20).fill(False).stroke("silver")
$svg.dropShadow()
 
$svg.preview()
```
 
### Dasharray (dashed lines)
 
Example showing various `dasharray` patterns (from `HDI dasharray.4dm`).
 
```4D
var $svg:=cs.svg.new()
 
$svg.rect(1198; 398).position(1;1).stroke("blue").stroke(2)
 
var $x := 100
$svg.line($x; 300; $x; 100).dasharray(10).color("gold")
$x += 20
$svg.line($x; 300; $x; 100).dasharray(10.5).color("royalblue")
$x += 20
$svg.line($x; 300; $x; 100).dasharray(1; 10).color("fushia")
 
$svg.preview()
```
 
### Arcs
 
Short arc example using `.arc()` within a `path()` (from `HDI arcs.4dm`).
 
```4D
var $svg:=cs.svg.new()
 
$svg.path().fill("red").stroke("blue").stroke(5)
.moveTo([300;200]).relative().horizontalLineto(-150)
.arc([150; -150]; 150; 0; [1;0]).closePath()
 
$svg.preview()
```
 
### Quadratic Bézier (Q/T)
 
Example showing `.quadraticBezierCurveto()` and `.smoothQuadraticBezierCurveto()` (from `HDI Bezier quadratic.4dm`).
 
```4D
var $svg:=cs.svg.new()
 
$svg.path().fill(False).stroke("red").stroke(5)
.moveTo([200;300])
.quadraticBezierCurveto([600;300]; [400;50])
.smoothQuadraticBezierCurveto([1000;300])
 
$svg.preview()
```

## ClipPath

Example (from `HDI ClipPath.4dm`):

```4D
cs.svg.new()\
.desc("Example clip-path")\
.square(96).radius(30).clipPath("mask")\
.image(File("/RESOURCES/vdl.jpg"))\
.preview()
```

## Symbol / use

Example (from `HDI symbol.4dm` — chart-based demo showing `symbol()` + `use()` semantics):

```4D
var $chart:=cs.chart.new()
$chart.title("Example symbol and use")

$chart.donut("1st"; 200; 200; 120).stroke("lightgray")
$chart.wedge("1st"; 25).fill("lemonchiffon")
$chart.wedge("1st"; 12).fill("thistle")
$chart.wedge("1st"; 25).fill("palegreen")
$chart.wedge("1st"; 40).fill("lightcyan")
$chart.symbol("donut"; "1st")  // make it a symbol

$chart.use("donut").position(10; 10)
$chart.preview()
```

## Path: cubic Bézier (example)

Taken from `HDI Bezier cubic.4dm` — shows `cubicBezierCurveto()` and `smoothCubicBezierCurveto()` usage inside a `path()`.

```4D
var $svg:=cs.svg.new()
$svg.style(".SamplePath{fill:none;stroke:red;stroke-width:5}")

$svg.path()\
.moveTo([100; 200])\
.cubicBezierCurveto([250; 200]; [100; 100]; [250; 100])\
.smoothCubicBezierCurveto([400; 200]; [400; 300])\
.class("SamplePath")

$svg.preview()
```

---

More examples will be added (clipPath variants, more filters, path/arc/quadratic examples). If you want, I can now proceed to integrate chart examples into a dedicated `svg_charts.md` file.


## Convert text to a Picture
From `HDI Text to Picture.4dm`:

```4D
SET PICTURE TO PASTEBOARD:C521(cs.svg.new().TextToPicture("hello world"; {size: 48; font: "sans-serif"; color: "red"}))
INVOKE ACTION:C1439(ak show clipboard:K76:58)
```

## Point helper and polar → cartesian
Small example showing `point()` and `polarToCartesian()`:

```4D
var $svg:=cs.svg.new()// Defining a point at x = 100 and y = 100var $point:=$svg.point(100; 100)// Move point by radius 50 at 45 degrees$point:=$svg.polarToCartesian($point; 50; 45)// & use it$svg.circle(10; $point[0]; $point[1]).fillColor("blue")$svg.preview()
```
