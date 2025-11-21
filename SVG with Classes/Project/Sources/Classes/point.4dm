property value:=[].resize(2)
property polar : Boolean  // True if polar coordinates

//———————————————————————————————————————————————————————————
Class constructor($x : Real; $y : Real; $polar : Boolean)
	
	This:C1470.x:=$x
	This:C1470.y:=$y
	
	This:C1470.polar:=Count parameters:C259>=3 ? $polar : True:C214
	
	//———————————————————————————————————————————————————————————
Function get x : Real
	
	return This:C1470.value[0]
	
	//———————————————————————————————————————————————————————————
Function set x($x : Real)
	
	This:C1470.value[0]:=Round:C94($x; 5)
	
	//———————————————————————————————————————————————————————————
Function get y : Real
	
	return This:C1470.value[1]
	
	//———————————————————————————————————————————————————————————
Function set y($y : Real)
	
	This:C1470.value[1]:=Round:C94($y; 5)
	
	//———————————————————————————————————————————————————————————
	// Transforms the point's polar coordinates into cartesian coordinate
Function polarToCartesian($r : Real; $degree : Integer) : cs:C1710.point
	
	var $rad : Real:=($degree*Pi:K30:1)/180
	
	return cs:C1710.point.new(This:C1470.x+($r*Cos:C18($rad)); This:C1470.y+($r*Sin:C17($rad)); False:C215)