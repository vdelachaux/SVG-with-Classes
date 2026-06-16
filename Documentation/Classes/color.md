<!-- cs.color.new({color}) -->
## color

This class is dedicated to manages color expressions, conversions from one system to another and the calculation of color harmonies.

### Summary

|Properties|Type|Description|Initial value|
|---------|:----:|------|:------:|
|**.main**| Integer|4D color\*|**0x0000**|
|**.rgb**|Object|{<br/>   "red",<br/>   "blue",<br/>   "lightness"<br/>}|**Null**|
|**.hsl**|Object|{<br/>   "hue",<br/>   "saturation",<br/>   "green"<br/>}||**Null**|
|**.css**|Object|{<br/>   "components" [rgb(red, green, blue)], <br/>   "percentage" [rgb(%red, %green, %blue)],<br/>   "hex" [#RGB],<br/>   "hexLong" [#RRGGBB], <br/>   "hsl" [hsl(hue, saturation, lightness)],<br/>    "name" [named color]<br/>}|**Null**|

> 📌 With the exception of functions that return a specific result (getter function), each call returns the original `cs.color` object, and you can include one call after another.

|Function|Action|
|--------|------|   
|.**setColor** ( color : `Integer` ) → `cs.color` | Set the main color with the 4D color\* expression
|.**setRGB** ( color : `Object` ) → `cs.color` | Set the main color with a RGB color object
|.**setHSL** ( color : `Object` ) → `cs.color` | Set the main color with a HSL color object
|.**setCSS** ( color : `Text` ) → `cs.color` | Set the main color with an HTML color
|.**setColorIndexed** ( index : `Integer` ) → `cs.color` | Set the main color with the legacy 4D palette index
|.**colorPicker** () → `Integer` | Displays the system color selection window and returns the 4D color\* selected by the user. This function updates the `main`, `rgb`, `hsl` and `css` properties.
|.**colorToRGB** ( color : `Integer` ) → `Object` | Returns a RGB color object
|.**colorToCSS** ( color : `Integer` ) → `Object` | Returns a HTML color object
|.**colorToHSL** ( color : `Integer` ) → `Object` | Returns a HSL color object
|.**rgbToColor** ( rgb : `Object` ) → `Integer` | Returns an 4D color\* expression from an RGB object
|.**rgbToHSL** ( hsl : `Object` ) → `Object ` | Returns an HSL color object from an RGB object
|.**hslToColor** ( hsl : `Object` ) → `Integer` | Returns an 4D color\* expression from an HSL object
|.**hslToRGB** ( hsl : `Object` ) → `Object` | Returns an RGB color object from an HSL object
|.**hslToCss** ( hsl : `Object` ) → `Object` | Returns an HTML color object from an HSL object
|.**[getMatchingColors](#getMatchingColors)** ( scheme : `Integer` ) → `Collection` | Returns a collection of harmonized colors (see HDI_COLOR dialog)
|.**[fontColor](#fontColor)** ( ) → `Text` | Gives the color to make a text readable on a background color.
|.**isValid** ( ) → `Boolean` | Returns `True` when the color object is fully defined (`.rgb`, `.hsl` and `.css` are all set).

### 🔸cs.color.new()

The class constructor `cs.color.new()` can be called without parameters to create an empty color object in memory.
>`cs.color.new()

The class constructor also accepts an optional parameter, so you can create a color object by passing an integer (4D color\*), an RGB color object, an HSL color object or a CSS value as text.
>`cs.color.new(color)

### 🔹<a name="getMatchingColors">getMatchingColors ()</a>

> getMatchingColors ( scheme : `Integer` ) → `Collection`

The `getMatchingColors` function returns a collection of harmonized colors with the main color. The number and calculation of colors returned depends on the type of calculation requested. There are 6 [color schemes](https://en.wikipedia.org/wiki/Color_scheme) available according to the `scheme`value:

|Value|Color scheme|Number of colors|
|:---:|----|:----:|
|0|Complementary color|1|
|1|Complementary colors separated|2|
|2|Triadic complementary colors|2|
|3|Analogous colors|2|
|4|Monochromatic colors|3|
|5|Tetradic complementary colors|4|

### 🔹<a name="fontColor"> fontColor ()</a>

The `fontColor` function returns the name of the color ("black" or "white") to use to make the text readable on a background color.

> fontColor** ( ) → `"black"` | `"white"`

No parameter to use as background color the main color of the class (**This**.main)    

> fontColor** ( red : `Integer` {; green : `Integer` {; blue : `Integer `}}) → `"black"` | `"white"`
    
To determine the font color for an RGB background color, pass the red and optionally the green and blue.

> fontColor** ( color : `Object`) → `"black"` | `"white"`

Give a color object to use as a background color

----
\* ***4D color*** *is a 4-byte Long Integer (format 0x00rrggbb).*
	
	rr = red component of the color
	gg = green component of the color
	bb = blue component of the color
