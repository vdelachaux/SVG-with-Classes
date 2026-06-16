<!-- cs.font.new() -->
## font

A small helper class describing a text style (font family, size, style, color, alignment…). A `cs.font` object can be passed to the `svg` class `.font()` function to apply a complete text style at once, and it is used internally by the `chart` class.

### Summary

|Properties|Type|Description|Initial value|
|---------|:----:|------|:------:|
|**.family**|Text|The `font-family` value.|*see default()*|
|**.size**|Integer|The `font-size` (in pixels).|**12**|
|**.style**|Integer|Bitmask combining `font-style`, `font-weight` and `text-decoration` (see below).|**Normal**|
|**.color**|Text \| Integer|The text `fill` color (CSS text or 4D color).|**"black"**|
|**.alignment**|Integer|`text-anchor` (text) / `text-align` (textArea). See below.|**Align default**|
|**.rendering**|Text|`text-rendering`: `"auto"`, `"optimizeSpeed"`, `"optimizeLegibility"`, `"geometricPrecision"`, `"inherit"`.|**"geometricPrecision"**|
|**.rotation**|Real|Rotation applied to the text (degrees).|**0**|
|**.stretch**|Variant|Optional horizontal stretch factor (removed by default).|**—**|

> 📌 The `.style` property is a bitmask: `Normal` (0), or any sum of `Bold` (1) + `Italic` (2) + `Underline` (4) + `Line-through` (8).

> 📌 The `.alignment` property accepts the 4D constants `Align default` (left), `Align center`, `Align right`, `Align left`, or `5` (justified).

|Function|Action|
|--------|------|
|.**default** () | Resets all properties to their default values (family, size 12, `Normal` style, black color, default alignment, `geometricPrecision` rendering, no rotation, no stretch).

### 🔸cs.font.new()

The class constructor creates a font object. Call `.default()` to (re)initialize it with sensible defaults:

```4D
var $font:=cs.font.new()
$font.default()
$font.size:=18
$font.style:=Bold+Italic
$font.color:="#163a7a"
```

### Usage with the svg class

A `cs.font` object can be applied to the current text element via the `svg` `.font()` function:

```4D
$svg.text("Title").position(20; 30).font($font)
```
