Class extends svg

Class constructor
	
	Super:C1705()
	
	//———————————————————————————————————————————————————————————
	// Start a circular diagram defined by its center `cx` `cy` and radius `r`
Function pie($id : Text; $cx : Real; $cy : Real; $r : Real; $options : Object) : cs:C1710.svg
	
	$options:=$options || {}
	
	// TODO:Allow title & more…
	
	This:C1470.group($id)\
		.setAttributes({type: "pie"; cx: $cx; cy: $cy; r: $r; origin: Num:C11($options.origin); cur: Num:C11($options.origin); values: []})
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Begin a pie chart fit into a square
Function pieBounded($id : Text; $x : Real; $y : Real; $width : Real; $options : Object) : cs:C1710.svg
	
	var $r : Real
	
	$r:=$width/2
	return This:C1470.pie($id; $x+$r; $y+$r; $r; $options)
	
	//———————————————————————————————————————————————————————————
	// Starting a donut chart fit into a square
Function donut($id : Text; $cx : Real; $cy : Real; $r : Real; $thickness : Real; $margin : Integer; $options : Object) : cs:C1710.svg
	
	$thickness:=$thickness=0 ? 70 : $thickness  // Default value is 30% of radius
	
	$options:=$options || {}
	
	// TODO:Allow title & more…
	
	This:C1470.group($id)\
		.setAttributes({type: "donut"; cx: $cx; cy: $cy; r: $r; origin: Num:C11($options.origin); cur: Num:C11($options.origin); thickness: $thickness; margin: $margin; values: []})
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Starting a donut chart
Function donutBounded($id : Text; $x : Real; $y : Real; $width : Real; $thickness : Real; $margin : Integer; $options : Object) : cs:C1710.svg
	
	var $r : Real
	
	$r:=$width/2
	return This:C1470.donut($id; $x+$r; $y+$r; $r; $thickness; $margin; $options)
	
	//———————————————————————————————————————————————————————————
	// Draws a portion of a pie chart/donut chart
Function wedge($id : Text; $percent : Real) : cs:C1710.svg
	
	var $cx; $cy; $r : Real
	var $chart : Text
	var $arc; $from; $origin; $to : Integer
	var $o : Object
	var $values : Collection
	
	// TODO:Allow labels
	
	// Get chart data
	$chart:=This:C1470.findById($id)
	
	If (Not:C34(This:C1470.success))
		
		TRACE:C157
		return 
		
	End if 
	
	$o:=This:C1470.getAttributes($chart)
	
	$cx:=$o.cx
	$cy:=$o.cy
	$r:=$o.r
	$from:=$o.cur+Num:C11($o.margin)
	$origin:=$o.origin
	$values:=$o.values
	
	If (Count parameters:C259>=2)
		
		$to:=$from+(360*($percent/100))
		
	Else 
		
		// Complete the ring
		$to:=$origin>=0 ? 360-$origin : 360+$origin
		$percent:=100-$values.sum()
		
	End if 
	
	$values.push($percent)
	
	$to:=$to>360 ? 360 : $to  // Limited to 360°.
	$arc:=Abs:C99($to-$from)>180 ? 1 : 0
	
	Case of 
			
			//______________________________________________________
		: ($o.type="pie")
			
			This:C1470.path()
			This:C1470.moveTo(This:C1470.point($cx; $cy))
			This:C1470.lineTo(This:C1470.point((Sin:C17($from*Degree:K30:2)*$r)+$cx; -(Cos:C18($from*Degree:K30:2)*$r)+$cy))
			This:C1470.arc(This:C1470.point((Sin:C17($to*Degree:K30:2)*$r)+$cx; -(Cos:C18($to*Degree:K30:2)*$r)+$cy); $r; 0; [$arc; 1])
			This:C1470.closePath()
			
			//______________________________________________________
		: ($o.type="donut")
			
			This:C1470.path()
			This:C1470.moveTo(This:C1470.point((Sin:C17($from*Degree:K30:2)*$r)+$cx; -(Cos:C18($from*Degree:K30:2)*$r)+$cy))
			This:C1470.arc(This:C1470.point((Sin:C17($to*Degree:K30:2)*$r)+$cx; -(Cos:C18($to*Degree:K30:2)*$r)+$cy); $r; 0; [$arc; 1])
			$r:=$r*Num:C11($o.thickness)/100
			This:C1470.lineTo(This:C1470.point((Sin:C17($to*Degree:K30:2)*$r)+$cx; -(Cos:C18($to*Degree:K30:2)*$r)+$cy))
			This:C1470.arc(This:C1470.point((Sin:C17($from*Degree:K30:2)*$r)+$cx; -(Cos:C18($from*Degree:K30:2)*$r)+$cy); $r; 0; [$arc; 0])
			This:C1470.closePath()
			
			//______________________________________________________
	End case 
	
	This:C1470.setAttribute("indx"; $values.length)
	
	// Update chart datas
	Super:C1706.setAttribute("cur"; $to; $chart)
	Super:C1706.setAttribute("values"; $values; $chart)
	
	// TODO:Display the legend (option)
	
	// TODO:Display the value (option)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Rotates a pie chart or donut chart
	// ⚠️ overight the super function
Function rotate($angle : Integer) : cs:C1710.chart
	
	var $o : Object
	
	$o:=Super:C1706.getAttributes(This:C1470.latest)
	Super:C1706.rotate($angle; Num:C11($o.cx); Num:C11($o.cy); This:C1470.latest)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Closing the chart
Function closeChart($id : Text) : cs:C1710.svg
	
	var $chart; $name : Text
	var $o : Object
	
	$chart:=Count parameters:C259>=1 ? This:C1470.findById($id) : This:C1470.parent(This:C1470.latest)
	
	DOM GET XML ELEMENT NAME:C730($chart; $name)
	
	If ($name="g")
		
		$o:=Super:C1706.getAttributes($chart)
		
		If ($o.type#Null:C1517)\
			 && (["pie"; "donut"].includes($o.type))
			
			This:C1470.latest:=This:C1470.parent($chart)
			
		End if 
	End if 
	
	return This:C1470