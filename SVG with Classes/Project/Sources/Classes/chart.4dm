Class extends svg

property id : Text

Class constructor
	
	Super:C1705()
	
	This:C1470.id:=""
	
	//———————————————————————————————————————————————————————————————————————————
	// Start a circular diagram defined by its center `cx` `cy` and radius `r`
Function pie($id : Text; $cx : Real; $cy : Real; $r : Real; $options : Object) : cs:C1710.chart
	
	var $percent; $value : Real
	var $i; $number; $total : Integer
	var $hsl; $serie : Object
	var $color : cs:C1710.color
	
	$options:=$options || {}
	
	// TODO:Allow title & more…
	
	This:C1470._closeChart(This:C1470.id)
	
	This:C1470.id:=$id
	
	This:C1470.group()
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "pie"; \
		cx: $cx; \
		cy: $cy; \
		r: $r; \
		origin: Num:C11($options.origin); \
		cur: Num:C11($options.origin); \
		values: []}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	This:C1470.store.push(New object:C1471(\
		"id"; $id; \
		"dom"; This:C1470.latest))
	
	If ($options.data#Null:C1517)
		
		// Fill the chart
		$number:=$options.data.length
		$total:=$options.data.sum("value")
		
		If ($options.orderBy#Null:C1517)
			
			$options.data:=$options.data.orderBy("value "+$options.orderBy)
			
		End if 
		
		$color:=cs:C1710.color.new()
		$hsl:={hue: 0; saturation: 60; lightness: 100}
		
		For each ($serie; $options.data)
			
			$value:=Num:C11($serie.value)
			$percent:=$value/$total*100
			
			$i+=1
			
			This:C1470.wedge($id; $percent)
			
			If ($serie.color#Null:C1517)
				
				This:C1470.fill($serie.color)
				
			Else 
				
				$hsl.hue:=(360-$i)*360/$number
				This:C1470.color($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
				
			End if 
			
			If ($options.stroke#Null:C1517)
				
				This:C1470.stroke($options.stroke)
				
			End if 
			
			//$label:=String($percent; "###.0%")
			
			//$x:=$cx-$r+($r*Cos(2*Pi*$percent))
			//$y:=$cy-$r+($r*Sin(Cos(2*Pi*$percent)))
			
			//This.text(String($percent; "###.0%"); $id).position($x; $y)
			
			
			
			
		End for each 
		
		This:C1470.closePath()
		
		//For each ($serie; $options.data)
		//$value:=Num($serie.value)
		//$percent:=$value/$total*100
		//$x:=$cx-$r+($r*Cos(2*Pi*$percent))
		//$y:=$cy-$r+($r*Sin(2*Pi*$percent))
		//This.text(String($percent; "###.0%"); $id).position($x; $y)
		//break
		//End for each 
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Begin a pie chart fit into a square
Function pieBounded($id : Text; $x : Real; $y : Real; $width : Real; $options : Object) : cs:C1710.chart
	
	var $r : Real
	
	$r:=$width/2
	return This:C1470.pie($id; $x+$r; $y+$r; $r; $options)
	
	//———————————————————————————————————————————————————————————————————————————
	// Starting a donut chart fit into a square
Function donut($id : Text; $cx : Real; $cy : Real; $r : Real; $thickness : Real; $margin : Integer; $options : Object) : cs:C1710.chart
	
	$thickness:=$thickness=0 ? 70/100 : $thickness  // Default value is 30% of radius
	$thickness:=$thickness<1 ? $thickness*100 : $thickness
	
	$options:=$options || {}
	
	// TODO:Allow title & more…
	
	This:C1470._closeChart(This:C1470.id)
	
	This:C1470.id:=$id
	
	This:C1470.group()
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "donut"; \
		cx: $cx; \
		cy: $cy; \
		r: $r; \
		origin: Num:C11($options.origin); \
		cur: Num:C11($options.origin); \
		thickness: $thickness; \
		margin: $margin; \
		values: []}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	This:C1470.store.push(New object:C1471(\
		"id"; $id; \
		"dom"; This:C1470.latest))
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Starting a donut chart
Function donutBounded($id : Text; $x : Real; $y : Real; $width : Real; $thickness : Real; $margin : Integer; $options : Object) : cs:C1710.chart
	
	var $r : Real
	
	$r:=$width/2
	return This:C1470.donut($id; $x+$r; $y+$r; $r; $thickness; $margin; $options)
	
	//———————————————————————————————————————————————————————————————————————————
	// Draws a portion of a pie chart/donut chart
Function wedge($id : Text; $percent : Real) : cs:C1710.chart
	
	var $arc; $cx; $cy; $from; $origin; $r : Real
	var $to : Real
	var $chart : Text
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
	$from:=$o.cur
	$origin:=$o.origin
	$values:=$o.values
	
	If (Count parameters:C259>=2)
		
		$to:=$from+(360*($percent/100))-Num:C11($o.margin)
		
	Else 
		
		// Complete the ring
		$to:=$origin>=0 ? 360-$origin : 360+$origin
		$percent:=100-$values.sum()
		
	End if 
	
	$values.push($percent)
	
	$arc:=Num:C11(Abs:C99($to-$from)>180)
	
	This:C1470.path()
	
	Case of 
			
			//______________________________________________________
		: ($o.type="pie")
			
			This:C1470.moveTo(This:C1470.point($cx; $cy))
			This:C1470.lineTo(This:C1470._getPoint($from; $r; $cx; $cy))
			This:C1470.arc(This:C1470._getPoint($to; $r; $cx; $cy); $r; 0; [$arc; 1])
			
			//______________________________________________________
		: ($o.type="donut")
			
			If ($to>(360-$o.margin))
				
				$to:=360-$o.margin
				
			End if 
			
			This:C1470.moveTo(This:C1470._getPoint($from; $r; $cx; $cy))
			This:C1470.arc(This:C1470._getPoint($to; $r; $cx; $cy); $r; 0; [$arc; 1])
			
			$r:=$r*Num:C11($o.thickness)/100
			This:C1470.lineTo(This:C1470._getPoint($to; $r; $cx; $cy))
			This:C1470.arc(This:C1470._getPoint($from; $r; $cx; $cy); $r; 0; [$arc; 0])
			
			//______________________________________________________
	End case 
	
	This:C1470.closePath()
	
	This:C1470.setAttribute("indx"; $values.length)
	
	// Update chart datas
	Super:C1706.setAttribute("cur"; $to+Num:C11($o.margin); $chart)
	Super:C1706.setAttribute("values"; $values; $chart)
	
	// TODO:Display the legend (option)
	
	// TODO:Display the value (option)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Rotates a pie chart or donut chart
	// ⚠️ overight the super function
	//Function rotate($angle : Integer) : cs.chart
	
	//var $o : Object
	
	//$o:=Super.getAttributes(This.findById(This.id))
	//Super.rotate($angle; Num($o.cx); Num($o.cy); This.latest)
	
	//return This
	
	//———————————————————————————————————————————————————————————————————————————
	// Horizontal bar chart
Function horizontalBar($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart
	
	$options:=$options || {}
	This:C1470._closeChart(This:C1470.id)
	
	This:C1470.id:=$id
	
	This:C1470.group()
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "bar"; \
		orient: "horizontal"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: $options.data || []}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	// Move to the right to allow labels, if needed
	// TODO: The x translation must be calculated from the max label width
	This:C1470.translate($x+(30*Num:C11($options.showLabels)); $y)
	
	This:C1470.store.push({id: $id; dom: This:C1470.latest})
	
	If ($options.data=Null:C1517)
		
		// Nothing to draw
		return This:C1470
		
	End if 
	
	var $values : Collection:=$options.data
	var $n : Integer:=$values.length
	
	// Default gap & padding
	var $gap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.15
	var $pad : Real:=$options.padding#Null:C1517 ? Num:C11($options.padding) : 10
	
	// Compute max
	var $maxValue : Real:=($options.max#Null:C1517) ? Num:C11($options.max) : $values.max("value")
	$maxValue:=$maxValue+Num:C11($maxValue=0)
	
	var $step : Real:=$height/$n
	var $barHeight : Real:=Round:C94($step*(1-$gap); 2)
	
	var $color:=cs:C1710.color.new()
	
	var $i : Integer
	var $serie : Object
	
	For each ($serie; $values)
		
		$i+=1
		var $val : Real:=Num:C11($serie.value)
		
		// Position from top
		var $ypos : Real:=Round:C94(($i-1)*$step+($step-$barHeight); 2)
		
		// Width scaled
		var $w : Real:=Round:C94(($val/$maxValue)*$width; 2)
		
		// Draw rect (bars)
		This:C1470.rect($w; $barHeight).position($pad; $ypos).setID(String:C10($i; "serie_###"))
		
		If ($serie.color#Null:C1517)
			
			This:C1470.fill($serie.color)
			
		Else 
			
			// Fallback color palette
			var $hsl:={\
				hue: (360-$i)*360/$n; \
				saturation: 60; \
				lightness: 50}
			This:C1470.color($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
			
		End if 
		
		If ($options.stroke#Null:C1517)
			
			This:C1470.stroke($options.stroke)
			
		End if 
		
		// Label (left)
		If (Bool:C1537($options.showLabels))
			
			This:C1470.text($serie.label).position(-20; $ypos+($barHeight/2)).font({size: Num:C11($options.fontSize) || 12}).alignment(Align left:K42:2)
			
		End if 
		
		// Value (right end)
		If (Bool:C1537($options.showValues))
			
			This:C1470.text(String:C10($val)).position($w+$pad+4; $ypos+($barHeight/2)).font({size: Num:C11($options.fontSize) || 12}).alignment(Align left:K42:2)
			
		End if 
		
		This:C1470.setAttribute("indx"; $i)
		This:C1470.closePath()
		
	End for each 
	
	// Optional axis
	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.hAxis))
		
		This:C1470.line(0; $height+$pad; $width+($pad*2); $height+$pad).stroke(2).setID("hAxis")
		
	End if 
	
	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.vAxis))
		
		This:C1470.line(0; 0; 0; $height+$pad).stroke(2).setID("vAxis")
		
	End if 
	
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Vertical bar chart
Function verticalBar($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart
	
	var $chartObj : Text
	
	
	
	var $step : Real
	var $barWidth : Real
	
	
	var $serie : Object
	
	
	$options:=$options || {}
	This:C1470._closeChart(This:C1470.id)
	
	This:C1470.id:=$id
	This:C1470.group().translate($x; $y)
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "bar"; \
		orient: "vertical"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: []}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	This:C1470.store.push({id: $id; dom: This:C1470.latest})
	
	If ($options.data=Null:C1517)
		
		return This:C1470  // Nothing to draw
		
	End if 
	
	var $values : Collection:=$options.data
	var $n:=$values.length
	
	// default gap & padding
	var $gap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.15
	var $pad : Real:=$options.padding#Null:C1517 ? Num:C11($options.padding) : 4
	
	// Compute max
	var $maxValue : Real:=($options.max#Null:C1517) ? Num:C11($options.max) : $values.max("value")
	$maxValue:=$maxValue+Num:C11($maxValue=0)
	
	$step:=$width/$n
	$barWidth:=Round:C94($step*(1-$gap); 2)
	
	var $color:=cs:C1710.color.new()
	
	var $i : Integer
	
	For each ($serie; $values)
		
		$i+=1
		var $val : Real:=Num:C11($serie.value)
		
		// Position from left
		var $xpos : Real:=Round:C94(($i-1)*$step+($step-$barWidth)/2; 2)
		
		// Height scaled
		var $h : Real:=Round:C94(($val/$maxValue)*($height-$pad*2); 2)
		
		// Draw rect (bars)
		This:C1470.rect($barWidth; $h).position($xpos; $height-$h-$pad).setID(String:C10($i; "serie_###"))
		
		If ($serie.color#Null:C1517)
			
			This:C1470.fill($serie.color)
			
		Else 
			
			// Fallback color palette
			var $hsl:={\
				hue: (360-$i)*360/$n; \
				saturation: 60; \
				lightness: 50}
			This:C1470.color($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
			
		End if 
		
		If ($options.stroke#Null:C1517)
			
			This:C1470.stroke($options.stroke)
			
		End if 
		
		// Value (top)
		If (Bool:C1537($options.showValues))
			
			This:C1470.text(String:C10($val)).position($xpos+$barWidth/2; $height-$h-$pad-16)\
				.font({size: Num:C11($options.fontSize) || 12}).alignment(Align center:K42:3)
			
		End if 
		
		// Label (bottom)
		If (Bool:C1537($options.showLabels))
			
			This:C1470.text($serie.label).position($xpos+$barWidth/2; $height-4)\
				.font({size: Num:C11($options.fontSize) || 12}).alignment(Align center:K42:3)
			
		End if 
		
		This:C1470.setAttribute("indx"; $i)
		This:C1470.closePath()
		
	End for each 
	
	// optional axis
	If (Bool:C1537($options.axis))
		This:C1470.line(0; $height-$pad; $width; $height-$pad).stroke(1).setID($id+"_hAxis")  // x-axis
		This:C1470.line($pad; 0; $pad; $height-$pad).stroke(1).setID($id+"_vAxis")  // y-axis
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// 
Function xy($id : Text; $options : Object) : cs:C1710.chart
	
	$options:=$options || {}
	
	This:C1470._closeChart(This:C1470.id)
	
	This:C1470.id:=$id
	
	This:C1470.group()
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "line"; \
		origin: Num:C11($options.origin); \
		cur: Num:C11($options.origin); \
		values: []}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	This:C1470.store.push({\
		id: $id; \
		dom: This:C1470.latest})
	
	If ($options.data=Null:C1517)
		
		return This:C1470
		
	End if 
	
	// Fill the chart
	var $number : Integer:=$options.data.length
	
	If ($options.orderBy#Null:C1517)
		
		$options.data:=$options.data.orderBy("value "+$options.orderBy)
		
	End if 
	
	var $color:=cs:C1710.color.new()
	var $hsl:={hue: 0; saturation: 60; lightness: 100}
	
	var $Xaxis : Collection:=[]
	var $Yaxis:=[]
	
	var $serie : Object
	var $i : Integer
	For each ($serie; $options.data)
		
		This:C1470.group().translate(10; 10)
		
		$i+=1
		
		If ($serie.color#Null:C1517)
			
			This:C1470.stroke($serie.color)
			
		Else 
			
			$hsl.hue:=(360-$i)*360/$number
			This:C1470.stroke($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
			
		End if 
		
		If ($options.dash#Null:C1517)
			
			//TODO:dash
			
		End if 
		
		// Get min, max values
		var $value : Collection
		For each ($value; $serie.values)
			
			$Xaxis.push($value[0])
			$Yaxis.push($value[1])
			
		End for each 
		
		$Xaxis:=$Xaxis.distinct()
		var $Xmin : Integer:=$Xaxis.min()
		var $Xmax : Integer:=$Xaxis.max()
		
		$Yaxis:=$Yaxis.distinct()
		var $Ymin : Integer:=$Yaxis.min()
		var $Ymax : Integer:=$Yaxis.max()
		
		var $width : Integer:=$Xmax-$Xmin
		var $height : Integer:=$Ymax-$Ymin
		
/*
Because of the way the Y-axis works different in SVG 
than in the “Cartesian” coordinates system we must tranlate Y values
*/
		For each ($value; $serie.values)
			
			$value[1]:=$Ymax-$value[1]
			
		End for each 
		
		// plot
		This:C1470.group().stroke(5)
		
		This:C1470.polyline().setID(String:C10($i; "serie_###"))
		This:C1470.plot($serie.values)
		
		This:C1470.restoreRoot()
		
	End for each 
	
	This:C1470.group().setID("axis").stroke(2)
	
	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.vAxis))
		
		This:C1470.line(0; $height).translate(10; 10).setID("vAxis")
		
	End if 
	
	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.hAxis))
		
		This:C1470.line(0; $height; $width; $height).translate(10; 10).setID("hAxis")
		
	End if 
	
	return This:C1470
	
	
Function setValues($id : Text; $values : Collection) : cs:C1710.chart
	
	
	
	return This:C1470
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// Closing the chart
Function _closeChart($id : Text)
	
	var $chart : Text
	
	If (Length:C16(This:C1470.id)=0)
		
		return 
		
	End if 
	
	$chart:=This:C1470.findById($id)
	
	If (This:C1470.success)
		
		This:C1470.latest:=This:C1470.parent(This:C1470.parent($chart))
		
	End if 
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _getPoint($x : Real; $r : Real; $cx : Real; $cy : Real) : Collection
	
	var $point : Collection
	
	$point:=[]
	$point[0]:=Round:C94((Sin:C17($x*Degree:K30:2)*$r)+$cx; 5)
	$point[1]:=Round:C94(-(Cos:C18($x*Degree:K30:2)*$r)+$cy; 5)
	
	return $point