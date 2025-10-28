Class extends svg

property id : Text

Class constructor
	
	Super:C1705()
	
	This:C1470.id:=""
	
	//———————————————————————————————————————————————————————————————————————————
	// Start a circular diagram defined by its center `cx` `cy` and radius `r`
Function pie($id : Text; $cx : Real; $cy : Real; $r : Real; $options : Object) : cs:C1710.svg
	
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
		
		//fill the chart
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
Function pieBounded($id : Text; $x : Real; $y : Real; $width : Real; $options : Object) : cs:C1710.svg
	
	var $r : Real
	
	$r:=$width/2
	return This:C1470.pie($id; $x+$r; $y+$r; $r; $options)
	
	//———————————————————————————————————————————————————————————————————————————
	// Starting a donut chart fit into a square
Function donut($id : Text; $cx : Real; $cy : Real; $r : Real; $thickness : Real; $margin : Integer; $options : Object) : cs:C1710.svg
	
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
Function donutBounded($id : Text; $x : Real; $y : Real; $width : Real; $thickness : Real; $margin : Integer; $options : Object) : cs:C1710.svg
	
	var $r : Real
	
	$r:=$width/2
	return This:C1470.donut($id; $x+$r; $y+$r; $r; $thickness; $margin; $options)
	
	//———————————————————————————————————————————————————————————————————————————
	// Draws a portion of a pie chart/donut chart
Function wedge($id : Text; $percent : Real) : cs:C1710.svg
	
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