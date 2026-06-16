<!-- cs.point.new(x; y {; polar}) -->
## point

A small helper class representing a 2D point. It stores its coordinates with a controlled precision (rounded to 5 decimals) and provides a polar → cartesian conversion.

### Summary

|Properties|Type|Description|Initial value|
|---------|:----:|------|:------:|
|**.value**|Collection|The `[x, y]` coordinates pair.|**[ , ]**|
|**.polar**|Boolean|`True` if the point is expressed in polar coordinates.|**True**|
|**.x**|Real|The x coordinate (accessor backed by `.value[0]`, rounded to 5 decimals).||
|**.y**|Real|The y coordinate (accessor backed by `.value[1]`, rounded to 5 decimals).||

> 📌 Getter functions return a specific result; the other function returns a new `cs.point` object so calls can be chained.

|Function|Action|
|--------|------|
|.**polarToCartesian** ( r : `Real` ; degree : `Integer` ) → `cs.point` | Returns a new point whose cartesian coordinates correspond to this point translated by the polar vector (`r`, `degree`). The angle is given in degrees.

### 🔸cs.point.new()

The class constructor takes the `x` and `y` coordinates and an optional `polar` flag (default `True`):

```4D
var $p:=cs.point.new(100; 50)        // polar by default
var $p:=cs.point.new(100; 50; False) // cartesian
```

The `.value` property exposes the pair as a collection, which is convenient to feed the path/shape commands of the `svg` class:

```4D
$svg.moveTo(cs.point.new($cx; $cy).value)
```

### 🔹 polarToCartesian ()

> polarToCartesian ( r : `Real` ; degree : `Integer` ) → `cs.point`

Computes the cartesian position of a point located at distance `r` and angle `degree` (in degrees) from the current point:

$$x = x_0 + r\cos\left(\frac{\pi\,degree}{180}\right), \quad y = y_0 + r\sin\left(\frac{\pi\,degree}{180}\right)$$

```4D
// Point on a circle of radius 120, at 45°, around (200, 200)
var $p:=cs.point.new(200; 200).polarToCartesian(120; 45)
```
