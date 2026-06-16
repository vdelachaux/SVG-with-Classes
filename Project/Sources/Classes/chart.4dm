Class extends svg

property id:=""

Class constructor
	
	Super:C1705()
	
	//———————————————————————————————————————————————————————————————————————————
	// Start a circular diagram defined by its center `cx` `cy` and radius `r`
Function pie($id : Text; $cx : Real; $cy : Real; $r : Real; $options : Object) : cs:C1710.chart
	
	var $percent; $value : Real
	var $i; $number : Integer
	var $total : Real
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
		
		If ($number=0)
			This:C1470._pushError("pie(): options.data is empty")
			return This:C1470
		End if 
		
		$total:=$options.data.sum("value")
		
		If ($total<=0)
			This:C1470._pushError("pie(): total value must be greater than 0")
			return This:C1470
		End if 
		
		If ($options.orderBy#Null:C1517)
			
			$options.data:=$options.data.orderBy("value "+$options.orderBy)
			
		End if 
		
		$color:=cs:C1710.color.new()
		$hsl:={hue: 0; saturation: 60; lightness: 100}
		
		For each ($serie; $options.data)
			
			$value:=Num:C11($serie.value)
			If ($value<=0)
				continue
			End if 
			
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
	
	$thickness:=$thickness=0 ? 70/100 : $thickness  // Default inner radius is 70% of radius (ring thickness is 30%)
	$thickness:=$thickness<1 ? $thickness*100 : $thickness
	
	$options:=$options || {}
	var $span : Real:=Num:C11($options.span)
	$span:=$span=0 ? 360 : Abs:C99($span)
	$span:=$span>360 ? 360 : $span
	
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
		span: $span; \
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
	// Starting a semi-donut chart (top half by default)
Function semiDonut($id : Text; $cx : Real; $cy : Real; $r : Real; $thickness : Real; $margin : Integer; $options : Object) : cs:C1710.chart
	
	$options:=$options || {}
	
	If ($options.origin=Null:C1517)
		$options.origin:=-90
	End if 
	
	$options.span:=180
	
	return This:C1470.donut($id; $cx; $cy; $r; $thickness; $margin; $options)
	
	//———————————————————————————————————————————————————————————————————————————
	// Starting a donut chart
Function donutBounded($id : Text; $x : Real; $y : Real; $width : Real; $thickness : Real; $margin : Integer; $options : Object) : cs:C1710.chart
	
	var $r : Real
	
	$r:=$width/2
	return This:C1470.donut($id; $x+$r; $y+$r; $r; $thickness; $margin; $options)
	
	//———————————————————————————————————————————————————————————————————————————
	// Starting a semi-donut chart fit into a square
Function semiDonutBounded($id : Text; $x : Real; $y : Real; $width : Real; $thickness : Real; $margin : Integer; $options : Object) : cs:C1710.chart
	
	var $r : Real
	
	$r:=$width/2
	return This:C1470.semiDonut($id; $x+$r; $y+$r; $r; $thickness; $margin; $options)
	
	//———————————————————————————————————————————————————————————————————————————
	// Draw a progress ring (single-value donut)
Function progressRing($id : Text; $cx : Real; $cy : Real; $r : Real; $value : Real; $max : Real; $options : Object) : cs:C1710.chart
	
	$options:=$options || {}
	
	If ($max<=0)
		
		This:C1470._pushError("progressRing(): max must be greater than 0")
		
		return This:C1470
		
	End if 
	
	var $ratio:=$value/$max
	$ratio:=$ratio<0 ? 0 : $ratio
	$ratio:=$ratio>1 ? 1 : $ratio
	var $percent:=$ratio*100
	
	var $origin : Real:=$options.origin#Null:C1517 ? Num:C11($options.origin) : -90
	var $thickness : Real:=$options.thickness#Null:C1517 ? Num:C11($options.thickness) : 0.7
	var $margin : Integer:=$options.margin#Null:C1517 ? Num:C11($options.margin) : 0
	var $linecap : Text:=$options.linecap#Null:C1517 ? String:C10($options.linecap) : "butt"
	
	$thickness:=$thickness=0 ? 70/100 : $thickness
	$thickness:=$thickness<1 ? $thickness*100 : $thickness
	$thickness:=$thickness>100 ? 100 : $thickness
	
	var $innerR : Real:=$r*Num:C11($thickness)/100
	var $strokeW : Real:=$r-$innerR
	$strokeW:=$strokeW<=0 ? 1 : $strokeW
	var $midR : Real:=$innerR+($strokeW/2)
	var $circ : Real:=2*Pi:K30:1*$midR
	var $dash : Real:=$circ*$percent/100
	var $gap : Real:=$circ-$dash
	
	This:C1470.donut($id; $cx; $cy; $r; $thickness; $margin; {origin: $origin})
	
	// Track ring
	This:C1470.circle($midR; $cx; $cy)
	This:C1470.fill("none")
	This:C1470.stroke($options.trackColor || "#E6E6E6")
	This:C1470.strokeWidth($strokeW)
	This:C1470.linecap($linecap)
	This:C1470.setAttribute("transform"; "rotate("+String:C10($origin)+" "+String:C10($cx)+" "+String:C10($cy)+")")
	
	// Progress ring
	If ($percent>0)
		
		This:C1470.circle($midR; $cx; $cy)
		This:C1470.fill("none")
		This:C1470.stroke($options.color || "dodgerblue")
		This:C1470.strokeWidth($strokeW)
		This:C1470.linecap($linecap)
		This:C1470.setAttribute("transform"; "rotate("+String:C10($origin)+" "+String:C10($cx)+" "+String:C10($cy)+")")
		
		If ($percent<100)
			This:C1470.setAttribute("stroke-dasharray"; String:C10($dash)+" "+String:C10($gap))
		End if 
		
	End if 
	
	If ($options.showValue#Null:C1517 ? $options.showValue : True:C214)
		
		var $label : Text:=$options.label#Null:C1517 ? String:C10($options.label) : String:C10(Round:C94($percent; 1))+"%"
		This:C1470.text($label; $id).position($cx; $cy).alignment(Align center:K42:3)
		This:C1470.setAttribute("dominant-baseline"; "middle")
		
		If ($options.valueFont#Null:C1517)
			
			This:C1470.font($options.valueFont)
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Draw a circular gauge (colored zones + needle)
Function circularGauge($id : Text; $cx : Real; $cy : Real; $r : Real; $value : Real; $max : Real; $options : Object) : cs:C1710.chart
	
	$options:=$options || {}
	
	If ($max<=0)
		
		This:C1470._pushError("circularGauge(): max must be greater than 0")
		
		return This:C1470
		
	End if 
	
	var $ratio : Real:=$value/$max
	$ratio:=$ratio<0 ? 0 : $ratio
	$ratio:=$ratio>1 ? 1 : $ratio
	var $percent : Real:=$ratio*100
	
	var $origin : Real:=$options.origin#Null:C1517 ? Num:C11($options.origin) : -90
	var $span : Real:=$options.span#Null:C1517 ? Num:C11($options.span) : 180
	$span:=Abs:C99($span)
	$span:=$span=0 ? 180 : $span
	$span:=$span>360 ? 360 : $span
	
	var $thickness : Real:=$options.thickness#Null:C1517 ? Num:C11($options.thickness) : 0.72
	$thickness:=$thickness=0 ? 70/100 : $thickness
	$thickness:=$thickness<1 ? $thickness*100 : $thickness
	$thickness:=$thickness>100 ? 100 : $thickness
	
	var $margin : Integer:=$options.margin#Null:C1517 ? Num:C11($options.margin) : 1
	var $zones : Collection:=$options.zones
	var $zoneId : Text:=$id+"_zones"
	
	If (Value type:C1509($zones)#Is collection:K8:32)
		
		$zones:=[\
			{limit: $max*0.6; color: "#22a06b"}; \
			{limit: $max*0.85; color: "#ff8b00"}; \
			{limit: $max; color: "#d7263d"}\
			]
		
	End if 
	
	This:C1470.donut($zoneId; $cx; $cy; $r; $thickness; $margin; {origin: $origin; span: $span})
	
	var $prevLimit : Real:=0
	var $zone : Object
	For each ($zone; $zones)
		
		var $limit : Real:=Num:C11($zone.limit)
		$limit:=$limit<0 ? 0 : $limit
		$limit:=$limit>$max ? $max : $limit
		
		var $slice : Real:=($limit-$prevLimit)/$max*100
		
		If ($slice>0)
			
			This:C1470.wedge($zoneId; $slice).fill($zone.color || "#999")
			
			$prevLimit:=$limit
			
		End if 
		
	End for each 
	
	If ($prevLimit<$max)
		
		This:C1470.wedge($zoneId; (($max-$prevLimit)/$max)*100).fill("#d7263d")
		
	End if 
	
	var $needleAngle : Real:=$origin+($span*$ratio)
	var $needleLen : Real:=$r*($options.needleRatio#Null:C1517 ? Num:C11($options.needleRatio) : 0.82)
	var $needleW : Real:=$options.needleWidth#Null:C1517 ? Num:C11($options.needleWidth) : 3
	var $needleColor : Text:=$options.needleColor || "#1f2937"
	var $hubR : Real:=$r*0.07
	
	This:C1470.line($cx; $cy; This:C1470._getPoint($needleAngle; $needleLen; $cx; $cy)[0]; This:C1470._getPoint($needleAngle; $needleLen; $cx; $cy)[1])\
		.stroke($needleColor).strokeWidth($needleW)
	
	This:C1470.circle($hubR; $cx; $cy).fill($options.hubColor || "#f7f7f7").stroke($needleColor).strokeWidth(2)
	
	If ($options.showValue#Null:C1517 ? $options.showValue : True:C214)
		
		var $unit : Text:=String:C10($options.unit)
		var $label : Text:=$options.label#Null:C1517 ? String:C10($options.label) : String:C10(Round:C94($value; 1))+$unit
		This:C1470.text($label).position($cx; $cy+($r*0.45)).alignment(Align center:K42:3)\
			.font($options.valueFont || {size: 18; style: Bold:K14:2; color: "#1f2937"})
		
	End if 
	
	If ($options.showMinMax#Null:C1517 ? $options.showMinMax : True:C214)
		
		var $leftPoint : Collection:=This:C1470._getPoint($origin; $r*1.08; $cx; $cy)
		var $rightPoint : Collection:=This:C1470._getPoint($origin+$span; $r*1.08; $cx; $cy)
		
		This:C1470.text($options.minLabel#Null:C1517 ? String:C10($options.minLabel) : "0")\
			.position($leftPoint[0]; $leftPoint[1]+14).alignment(Align center:K42:3)\
			.font($options.scaleFont || {size: 12; color: "#4b5563"})
		
		This:C1470.text($options.maxLabel#Null:C1517 ? String:C10($options.maxLabel) : String:C10($max))\
			.position($rightPoint[0]; $rightPoint[1]+14).alignment(Align center:K42:3)\
			.font($options.scaleFont || {size: 12; color: "#4b5563"})
		
	End if 
	
	This:C1470.id:=$id
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Draws a portion of a pie chart/donut chart
Function wedge($id : Text; $percent : Real) : cs:C1710.chart
	
	var $arc; $cx; $cy; $from; $origin; $r; $span : Real
	var $to : Real
	var $chart : Text
	var $o : Object
	var $values : Collection
	
	// TODO:Allow labels
	
	// Get chart data
	$chart:=This:C1470.findById($id)
	
	If (Not:C34(This:C1470.success))
		
		This:C1470._pushError("wedge(): chart id not found: "+$id)
		return 
		
	End if 
	
	$o:=This:C1470.getAttributes($chart)
	
	$cx:=$o.cx
	$cy:=$o.cy
	$r:=$o.r
	$from:=$o.cur
	$origin:=$o.origin
	$span:=Num:C11($o.span)
	$span:=$span=0 ? 360 : $span
	$values:=$o.values
	
	If (Count parameters:C259>=2)
		
		$to:=$from+($span*($percent/100))-Num:C11($o.margin)
		
	Else 
		
		// Complete the ring
		$to:=$origin+$span
		$percent:=100-$values.sum()
		
	End if 
	
	$values.push($percent)
	
	$arc:=Num:C11(Abs:C99($to-$from)>180)
	
	This:C1470.path("")
	
	Case of 
			
			//______________________________________________________
		: ($o.type="pie")
			
			This:C1470.moveTo(cs:C1710.point.new($cx; $cy).value)
			This:C1470.lineTo(This:C1470._getPoint($from; $r; $cx; $cy))
			This:C1470.arc(This:C1470._getPoint($to; $r; $cx; $cy); $r; 0; [$arc; 1])
			
			//______________________________________________________
		: ($o.type="donut")
			
			var $maxAngle : Real:=$origin+$span-Num:C11($o.margin)
			
			If ($to>$maxAngle)
				
				$to:=$maxAngle
				
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
	
	This:C1470._closeChart(This:C1470.id)
	This:C1470.group()
	
	This:C1470.id:=$id
	
	$options:=$options || {}
	var $values : Collection:=$options.data || []
	var $n : Integer:=$values.length
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "bar"; \
		orient: "horizontal"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: $values}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	This:C1470.store.push({id: $id; dom: This:C1470.latest})
	
	If ($n=0)  // Nothing to draw
		
		return This:C1470
		
	End if 
	
	// Default gap & padding
	var $gap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.15
	var $pad : Real:=$options.padding#Null:C1517 ? Num:C11($options.padding) : 10
	
	If (Bool:C1537($options.showLabels))
		
		// Calculate the horizontal offset from the max label width
		var $hOffset; $w; $h : Real
		var $t : Text
		For each ($t; $values.extract("label"))
			
			var $p:=cs:C1710.svg.new().TextToPicture($t; {size: Num:C11($options.fontSize) || 12})
			PICTURE PROPERTIES:C457($p; $w; $h)
			$hOffset:=$w>$hOffset ? $w : $hOffset
			
		End for each 
		
		This:C1470.translate($x+($hOffset*1*Num:C11($options.showLabels))+$pad; $y)
		
	Else 
		
		This:C1470.translate($x; $y)
		
	End if 
	
	// Compute max
	var $maxValue : Real:=($options.max#Null:C1517) ? Num:C11($options.max) : $values.max("value")
	$maxValue:=$maxValue+Num:C11($maxValue=0)
	
	var $step : Real:=$height/$n
	var $barHeight : Real:=Round:C94($step*(1-$gap); 2)
	
	// Optional axis
	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.hAxis))
		
		This:C1470.line(0; $height+$pad; $width+($pad*2); $height+$pad).stroke(2).setID("hAxis")
		
	End if 
	
	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.vAxis))
		
		This:C1470.line(0; 0; 0; $height+$pad).stroke(2).setID("vAxis")
		
	End if 
	
	var $color : cs:C1710.color
	var $i : Integer
	var $serie : Object
	For each ($serie; $values)
		
		$i+=1
		var $val : Real:=Num:C11($serie.value)
		
		// Position from top
		$y:=Round:C94(($i-1)*$step+($step-$barHeight); 2)
		
		// Width scaled
		$w:=Round:C94(($val/$maxValue)*$width; 2)
		
		// Draw rect (bars)
		This:C1470.rect($w; $barHeight).position($pad; $y).setID(String:C10($i; "serie_###"))
		
		If ($serie.color#Null:C1517)
			
			This:C1470.fill($serie.color)
			
		Else 
			
			// Fallback color palette
			var $hsl:={\
				hue: (360-$i)*360/$n; \
				saturation: 60; \
				lightness: 50}
			
			$color:=$color || cs:C1710.color.new()
			This:C1470.color($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
			
		End if 
		
		If ($options.stroke#Null:C1517)
			
			This:C1470.stroke($options.stroke)
			
		End if 
		
		// Label (left)
		If (Bool:C1537($options.showLabels))
			
			This:C1470.textArea($serie.label).width($hOffset)\
				.font({size: Num:C11($options.fontSize) || 12}).alignment(Align right:K42:4)\
				.translate(-$hOffset-$pad; $y+($barHeight/2)-$pad)
			
		End if 
		
		// Value (right end)
		If (Bool:C1537($options.showValues))
			
			This:C1470.text(String:C10($val)).position($w+$pad+4; $y+($barHeight/2))\
				.font({size: Num:C11($options.fontSize) || 12}).alignment(Align left:K42:2)
			
		End if 
		
		This:C1470.setAttribute("indx"; $i)
		
	End for each 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Vertical bar chart
Function verticalBar($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart
	
	This:C1470._closeChart(This:C1470.id)
	This:C1470.group()
	
	This:C1470.id:=$id
	
	$options:=$options || {}
	var $values : Collection:=$options.data || []
	var $n:=$values.length
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "bar"; \
		orient: "vertical"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: $values; \
		options: $options}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	This:C1470.store.push({id: $id; dom: This:C1470.latest})
	
	// Defining the main font for the chart
	var $font:=This:C1470._graphFont($options.font)
	
	// Increased vertical translation if values are visible, where applicable
	var $showValues:=Bool:C1537($options.showValues) || Bool:C1537($options.showValues#Null:C1517)
	$y+=$font.size*Num:C11($showValues)
	
	// Place the main 
	This:C1470.translate($x; $y)
	
	// Zoom factor if any
	If (Num:C11($options.zoom)#0)
		
		This:C1470.scale(Num:C11($options.zoom))
		
	End if 
	
	If ($n=0)  // Nothing to draw
		
		return This:C1470
		
	End if 
	
	// The distance between the bars. 0 = the bars touch each other
	var $gap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.15
	
	// Compute max value
	var $maxValue : Real:=$options.max#Null:C1517 ? Num:C11($options.max) : $values.max("value")
	$maxValue:=$maxValue+Num:C11($maxValue=0)
	
	// MARK: Horizontal grid lines
	If ($options.horizontalGridLines#Null:C1517)
		
		var $step : Real
		var $coloring : Text
		var $dash : Integer
		
		Case of 
				
				//______________________________________________________
			: (Value type:C1509($options.horizontalGridLines)=Is boolean:K8:9)
				
				$step:=$maxValue/10  // calculate the unit
				
				//______________________________________________________
			: (Value type:C1509($options.horizontalGridLines)=Is object:K8:27)
				
				$step:=Num:C11($options.horizontalGridLines.unit)
				$coloring:=String:C10($options.horizontalGridLines.color)
				$dash:=Num:C11($options.horizontalGridLines.dash)
				
				//______________________________________________________
			Else 
				
				$step:=Num:C11($options.horizontalGridLines)
				
				//______________________________________________________
		End case 
		
		$step:=$step#0 ? $step : $maxValue/10  // Default is max/10
		$coloring:=$coloring || "gray"
		$dash:=$dash#0 ? $dash : 2
		
		var $line : Integer
		For ($line; 0; $maxValue; $step)
			
			var $h : Real:=($line/$maxValue)*$height
			This:C1470.line(0; $h; $width; $h).stroke($coloring).dasharray($dash)
			
		End for 
	End if 
	
	var $showLabels:=Bool:C1537($options.labels#Null:C1517)
	
	If ($showLabels)
		
		If (Value type:C1509($options.labels)=Is object:K8:27)\
			 && OB Instance of:C1731($options.labels; cs:C1710.font)
			
			$labelFont:=$options.labels
			
		Else 
			
			var $labelFont:=$font  // default font definition
			
		End if 
	End if 
	
	$step:=$width/$n
	var $barWidth : Real:=$step*(1-$gap)
	
	var $color : cs:C1710.color
	var $i : Integer
	var $serie : Object
	For each ($serie; $values)
		
		$i+=1
		
		var $val : Real:=Num:C11($serie.value)
		
		// Height scaled
		$h:=($val/$maxValue)*$height
		
		// Position from left
		$x:=(($i-1)*$step)+(($step-$barWidth)/2)
		$y:=$height-$h
		
		// Plot the bar
		This:C1470.rect($barWidth; $h).position($x; $y).setID(String:C10($i; "serie_###"))
		
		If ($serie.color#Null:C1517)
			
			If ($serie.stroke#Null:C1517)
				
				This:C1470.fill($serie.color).stroke($serie.stroke)
				
			Else 
				
				This:C1470.color($serie.color)
				
			End if 
			
		Else 
			
			// Use color palette
			$color:=$color || cs:C1710.color.new()
			
			If ($serie.stroke#Null:C1517)
				
				This:C1470.fill($color.setHSL(This:C1470._getColor($i; $n)).colorToCSS($color.main; "hexLong")).stroke($serie.stroke)
				
			Else 
				
				This:C1470.color($color.setHSL(This:C1470._getColor($i; $n)).colorToCSS($color.main; "hexLong"))
				
			End if 
		End if 
		
		If ($options.stroke#Null:C1517)
			
			This:C1470.stroke($options.stroke)
			
		End if 
		
		$x+=$barWidth/2
		
		// Plot value
		If ($showValues)
			
			$y+=15  // Inside the bar
			This:C1470.text(String:C10($val)).position($x; $y)\
				.font($font).alignment(Align center:K42:3)\
				.setAttribute("indx"; $i)
			
			If ($serie.color=Null:C1517)
				
				This:C1470.color($color.fontColor())  // Choose the appropriate font color
				
			End if 
		End if 
		
		// Plot label
		If ($showLabels)
			
			$y:=$height+($font.size*1.5)
			This:C1470.text($serie.label).position($x; $y)\
				.font($labelFont).alignment(Align center:K42:3)\
				.setAttribute("indx"; $i)
			
		End if 
	End for each 
	
	// Optional axis
	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.hAxis))
		
		This:C1470.line(0; $height; $width; $height).stroke(1).setID("hAxis")
		
	End if 
	
	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.vAxis))
		
		This:C1470.line(0; -5; 0; $height).stroke(1).setID("vAxis")
		
	End if 
	
	return This:C1470

	//———————————————————————————————————————————————————————————————————————————
	// Vertical stacked bar chart
Function verticalStackedBar($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart

	This:C1470._closeChart(This:C1470.id)
	This:C1470.group()

	This:C1470.id:=$id

	$options:=$options || {}
	var $values : Collection:=$options.data || []
	var $n : Integer:=$values.length

	Super:C1706.setAttributes({\
		id: $id; \
		type: "bar"; \
		orient: "verticalStacked"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: $values; \
		options: $options}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)

	This:C1470.store.push({id: $id; dom: This:C1470.latest})

	If ($n=0)
		return This:C1470
	End if 

	var $font:=This:C1470._graphFont($options.font)
	var $showValues : Boolean:=Bool:C1537($options.showValues)
	var $showLabels : Boolean:=Bool:C1537($options.showLabels)

	// Place the chart group
	This:C1470.translate($x; $y)

	// Distance between bars
	var $gap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.2

	// Compute totals and max stacked value
	var $totals : Collection:=[]
	var $serie : Object
	For each ($serie; $values)
		
		var $total : Real:=0
		var $segments : Collection:=$serie.segments
		
		If (Value type:C1509($segments)=Is collection:K8:32)
			
			var $segment : Object
			For each ($segment; $segments)
				$total+=$segment.value
			End for each 
			
		End if 
		
		$totals.push($total)
		
	End for each 

	var $maxValue : Real:=$options.max#Null:C1517 ? Num:C11($options.max) : $totals.max()
	$maxValue:=$maxValue+Num:C11($maxValue=0)

	var $step : Real:=$width/$n
	var $barWidth : Real:=$step*(1-$gap)

	var $i : Integer
	var $color : cs:C1710.color
	For each ($serie; $values)
		
		$i+=1
		
		var $segments : Collection:=$serie.segments
		If (Value type:C1509($segments)#Is collection:K8:32)
			continue
		End if 
		
		var $xPos : Real:=(($i-1)*$step)+(($step-$barWidth)/2)
		var $yCursor : Real:=$height
		var $j : Integer
		var $segment : Object
		For each ($segment; $segments)
			
			$j+=1
			var $val : Real:=Num:C11($segment.value)
			If ($val<=0)
				continue
			End if 
			
			var $h : Real:=($val/$maxValue)*$height
			$yCursor-=$h
			
			This:C1470.rect($barWidth; $h).position($xPos; $yCursor).setID(String:C10($i; "serie_###")+"_"+String:C10($j; "seg_###"))
			
			If ($segment.color#Null:C1517)
				This:C1470.fill($segment.color)
			Else 
				$color:=$color || cs:C1710.color.new()
				This:C1470.fill($color.setHSL(This:C1470._getColor($j; $segments.length+Num:C11($segments.length=0))).colorToCSS($color.main; "hexLong"))
			End if 
			
			If ($options.stroke#Null:C1517)
				This:C1470.stroke($options.stroke)
			End if 
			
		End for each 
		
		// Total value on top
		If ($showValues)
			This:C1470.text(String:C10(Round:C94($totals[$i-1]; 2))).position($xPos+($barWidth/2); $yCursor-4)\
				.font($font).alignment(Align center:K42:3)
		End if 
		
		// Bar label
		If ($showLabels)
			This:C1470.text($serie.label).position($xPos+($barWidth/2); $height+($font.size*1.5))\
				.font($font).alignment(Align center:K42:3)
		End if 
		
	End for each 

	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.hAxis))
		This:C1470.line(0; $height; $width; $height).stroke(1).setID("hAxis")
	End if 

	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.vAxis))
		This:C1470.line(0; -5; 0; $height).stroke(1).setID("vAxis")
	End if 

	return This:C1470

	//———————————————————————————————————————————————————————————————————————————
	// Horizontal stacked bar chart
Function horizontalStackedBar($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart

	This:C1470._closeChart(This:C1470.id)
	This:C1470.group()

	This:C1470.id:=$id

	$options:=$options || {}
	var $values : Collection:=$options.data || []
	var $n : Integer:=$values.length

	Super:C1706.setAttributes({\
		id: $id; \
		type: "bar"; \
		orient: "horizontalStacked"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: $values; \
		options: $options}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)

	This:C1470.store.push({id: $id; dom: This:C1470.latest})

	If ($n=0)
		return This:C1470
	End if 

	var $font:=This:C1470._graphFont($options.font)
	var $showValues : Boolean:=Bool:C1537($options.showValues)
	var $showLabels : Boolean:=Bool:C1537($options.showLabels)
	var $pad : Real:=$options.padding#Null:C1517 ? Num:C11($options.padding) : 10

	var $hOffset : Real
	If ($showLabels)
		var $t : Text
		For each ($t; $values.extract("label"))
			var $p:=cs:C1710.svg.new().TextToPicture($t; {size: $font.size})
			var $w; $h : Real
			PICTURE PROPERTIES:C457($p; $w; $h)
			$hOffset:=$w>$hOffset ? $w : $hOffset
		End for each 
	End if 

	This:C1470.translate($x+($hOffset*Num:C11($showLabels))+$pad; $y)

	var $gap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.2

	// Compute totals and max stacked value
	var $totals : Collection:=[]
	var $serie : Object
	For each ($serie; $values)
		
		var $total : Real:=0
		var $segments : Collection:=$serie.segments
		
		If (Value type:C1509($segments)=Is collection:K8:32)
			var $segment : Object
			For each ($segment; $segments)
				$total+=$segment.value
			End for each 
		End if 
		
		$totals.push($total)
		
	End for each 

	var $maxValue : Real:=$options.max#Null:C1517 ? Num:C11($options.max) : $totals.max()
	$maxValue:=$maxValue+Num:C11($maxValue=0)

	var $step : Real:=$height/$n
	var $barHeight : Real:=Round:C94($step*(1-$gap); 2)

	var $i : Integer
	var $color : cs:C1710.color
	For each ($serie; $values)
		
		$i+=1
		
		var $segments : Collection:=$serie.segments
		If (Value type:C1509($segments)#Is collection:K8:32)
			continue
		End if 
		
		var $yPos : Real:=Round:C94(($i-1)*$step+($step-$barHeight); 2)
		var $xCursor : Real:=$pad
		var $j : Integer
		var $segment : Object
		For each ($segment; $segments)
			
			$j+=1
			var $val : Real:=Num:C11($segment.value)
			If ($val<=0)
				continue
			End if 
			
			var $w : Real:=Round:C94(($val/$maxValue)*$width; 2)
			
			This:C1470.rect($w; $barHeight).position($xCursor; $yPos).setID(String:C10($i; "serie_###")+"_"+String:C10($j; "seg_###"))
			
			If ($segment.color#Null:C1517)
				This:C1470.fill($segment.color)
			Else 
				$color:=$color || cs:C1710.color.new()
				This:C1470.fill($color.setHSL(This:C1470._getColor($j; $segments.length+Num:C11($segments.length=0))).colorToCSS($color.main; "hexLong"))
			End if 
			
			If ($options.stroke#Null:C1517)
				This:C1470.stroke($options.stroke)
			End if 
			
			$xCursor+=$w
			
		End for each 
		
		If ($showValues)
			This:C1470.text(String:C10(Round:C94($totals[$i-1]; 2))).position($xCursor+4; $yPos+($barHeight/2))\
				.font($font).alignment(Align left:K42:2)
		End if 
		
		If ($showLabels)
			This:C1470.textArea($serie.label).width($hOffset)\
				.font($font).alignment(Align right:K42:4)\
				.translate(-$hOffset-$pad; $yPos+($barHeight/2)-$pad)
		End if 
		
	End for each 

	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.hAxis))
		This:C1470.line(0; $height+$pad; $width+($pad*2); $height+$pad).stroke(1).setID("hAxis")
	End if 

	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.vAxis))
		This:C1470.line(0; 0; 0; $height+$pad).stroke(1).setID("vAxis")
	End if 

	return This:C1470

	//———————————————————————————————————————————————————————————————————————————
	// Vertical grouped bar chart
Function verticalGroupedBar($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart

	This:C1470._closeChart(This:C1470.id)
	This:C1470.group()

	This:C1470.id:=$id

	$options:=$options || {}
	var $values : Collection:=$options.data || []
	var $n : Integer:=$values.length

	Super:C1706.setAttributes({\
		id: $id; \
		type: "bar"; \
		orient: "verticalGrouped"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: $values; \
		options: $options}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)

	This:C1470.store.push({id: $id; dom: This:C1470.latest})

	If ($n=0)
		return This:C1470
	End if 

	var $font:=This:C1470._graphFont($options.font)
	var $showValues : Boolean:=Bool:C1537($options.showValues)
	var $showLabels : Boolean:=Bool:C1537($options.showLabels)
	var $groupGap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.2
	var $innerGap : Real:=$options.innerGap#Null:C1517 ? Num:C11($options.innerGap) : 0.12
	var $pad : Real:=$options.padding#Null:C1517 ? Num:C11($options.padding) : 10

	This:C1470.translate($x; $y)

	// Determine max and groups count
	var $maxValue : Real:=0
	var $maxGroups : Integer:=1
	var $cat : Object
	For each ($cat; $values)
		
		var $groups : Collection:=$cat.groups
		If (Value type:C1509($groups)=Is collection:K8:32)
			$maxGroups:=$groups.length>$maxGroups ? $groups.length : $maxGroups
			var $g : Object
			For each ($g; $groups)
				var $v : Real:=Num:C11($g.value)
				$maxValue:=$v>$maxValue ? $v : $maxValue
			End for each 
		End if 
		
	End for each 

	$maxValue:=$options.max#Null:C1517 ? Num:C11($options.max) : $maxValue
	$maxValue:=$maxValue+Num:C11($maxValue=0)

	var $leftOffset : Real:=$pad/2
	var $plotWidth : Real:=$width-$pad
	var $step : Real:=$plotWidth/$n
	var $groupWidth : Real:=$step*(1-$groupGap)
	var $itemWidth : Real:=$groupWidth/($maxGroups+($innerGap*($maxGroups-1)))

	var $i : Integer
	For each ($cat; $values)
		
		var $groups : Collection:=$cat.groups
		If ((Value type:C1509($groups)#Is collection:K8:32) || ($groups.length=0))
			continue
		End if 
		
		$i+=1
		
		var $xStart : Real:=$leftOffset+(($i-1)*$step)+(($step-$groupWidth)/2)
		var $j : Integer
		$j:=0
		var $g : Object
		For each ($g; $groups)
			
			$j+=1
			var $val : Real:=Num:C11($g.value)
			If ($val<0)
				continue
			End if 
			
			var $h : Real:=($val/$maxValue)*$height
			var $xPos : Real:=$xStart+(($j-1)*$itemWidth*(1+$innerGap))
			var $yPos : Real:=$height-$h
			
			This:C1470.rect($itemWidth; $h).position($xPos; $yPos).setID(String:C10($i; "cat_###")+"_"+String:C10($j; "grp_###"))
			
			If ($g.color#Null:C1517)
				This:C1470.fill($g.color)
			Else 
				var $color:=cs:C1710.color.new()
				This:C1470.fill($color.setHSL(This:C1470._getColor($j; $maxGroups)).colorToCSS($color.main; "hexLong"))
			End if 
			
			If ($options.stroke#Null:C1517)
				This:C1470.stroke($options.stroke)
			End if 
			
			If ($showValues)
				This:C1470.text(String:C10(Round:C94($val; 2))).position($xPos+($itemWidth/2); $yPos-4)\
					.font($font).alignment(Align center:K42:3)
			End if 
			
		End for each 
		
		If ($showLabels)
			This:C1470.text($cat.label).position($xStart+($groupWidth/2); $height+($font.size*1.5))\
				.font($font).alignment(Align center:K42:3)
		End if 
		
	End for each 

	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.hAxis))
		This:C1470.line($leftOffset; $height; $leftOffset+$plotWidth; $height).stroke(1).setID("hAxis")
	End if 

	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.vAxis))
		This:C1470.line(0; -5; 0; $height).stroke(1).setID("vAxis")
	End if 

	return This:C1470

	//———————————————————————————————————————————————————————————————————————————
	// Horizontal grouped bar chart
Function horizontalGroupedBar($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart

	This:C1470._closeChart(This:C1470.id)
	This:C1470.group()

	This:C1470.id:=$id

	$options:=$options || {}
	var $values : Collection:=$options.data || []
	var $n : Integer:=$values.length

	Super:C1706.setAttributes({\
		id: $id; \
		type: "bar"; \
		orient: "horizontalGrouped"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: $values; \
		options: $options}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)

	This:C1470.store.push({id: $id; dom: This:C1470.latest})

	If ($n=0)
		return This:C1470
	End if 

	var $font:=This:C1470._graphFont($options.font)
	var $showValues : Boolean:=Bool:C1537($options.showValues)
	var $showLabels : Boolean:=Bool:C1537($options.showLabels)
	var $groupGap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.2
	var $innerGap : Real:=$options.innerGap#Null:C1517 ? Num:C11($options.innerGap) : 0.12
	var $pad : Real:=$options.padding#Null:C1517 ? Num:C11($options.padding) : 10
	var $vPad : Real:=$options.verticalPadding#Null:C1517 ? Num:C11($options.verticalPadding) : 10

	var $hOffset : Real
	If ($showLabels)
		var $txt : Text
		For each ($txt; $values.extract("label"))
			var $pic:=cs:C1710.svg.new().TextToPicture($txt; {size: $font.size})
			var $w; $h : Real
			PICTURE PROPERTIES:C457($pic; $w; $h)
			$hOffset:=$w>$hOffset ? $w : $hOffset
		End for each 
	End if 

	This:C1470.translate($x+($hOffset*Num:C11($showLabels))+$pad; $y)

	// Determine max and groups count
	var $maxValue : Real:=0
	var $maxGroups : Integer:=1
	var $cat : Object
	For each ($cat; $values)
		
		var $groups : Collection:=$cat.groups
		If (Value type:C1509($groups)=Is collection:K8:32)
			$maxGroups:=$groups.length>$maxGroups ? $groups.length : $maxGroups
			var $g : Object
			For each ($g; $groups)
				var $v : Real:=Num:C11($g.value)
				$maxValue:=$v>$maxValue ? $v : $maxValue
			End for each 
		End if 
		
	End for each 

	$maxValue:=$options.max#Null:C1517 ? Num:C11($options.max) : $maxValue
	$maxValue:=$maxValue+Num:C11($maxValue=0)

	var $topOffset : Real:=$vPad/2
	var $plotHeight : Real:=$height-$vPad
	var $step : Real:=$plotHeight/$n
	var $groupHeight : Real:=$step*(1-$groupGap)
	var $itemHeight : Real:=$groupHeight/($maxGroups+($innerGap*($maxGroups-1)))

	var $i : Integer
	For each ($cat; $values)
		
		var $groups : Collection:=$cat.groups
		If ((Value type:C1509($groups)#Is collection:K8:32) || ($groups.length=0))
			continue
		End if 
		
		$i+=1
		
		var $yStart : Real:=$topOffset+(($i-1)*$step)+(($step-$groupHeight)/2)
		var $j : Integer
		$j:=0
		var $g : Object
		For each ($g; $groups)
			
			$j+=1
			var $val : Real:=Num:C11($g.value)
			If ($val<0)
				continue
			End if 
			
			var $w : Real:=($val/$maxValue)*$width
			var $xPos : Real:=$pad
			var $yPos : Real:=$yStart+(($j-1)*$itemHeight*(1+$innerGap))
			
			This:C1470.rect($w; $itemHeight).position($xPos; $yPos).setID(String:C10($i; "cat_###")+"_"+String:C10($j; "grp_###"))
			
			If ($g.color#Null:C1517)
				This:C1470.fill($g.color)
			Else 
				var $color:=cs:C1710.color.new()
				This:C1470.fill($color.setHSL(This:C1470._getColor($j; $maxGroups)).colorToCSS($color.main; "hexLong"))
			End if 
			
			If ($options.stroke#Null:C1517)
				This:C1470.stroke($options.stroke)
			End if 
			
			If ($showValues)
				This:C1470.text(String:C10(Round:C94($val; 2))).position($xPos+$w+4; $yPos+($itemHeight/2))\
					.font($font).alignment(Align left:K42:2)
			End if 
			
		End for each 
		
		If ($showLabels)
			This:C1470.textArea($cat.label).width($hOffset)\
				.font($font).alignment(Align right:K42:4)\
				.translate(-$hOffset-$pad; $yStart+($groupHeight/2)-$pad)
		End if 
		
	End for each 

	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.hAxis))
		This:C1470.line(0; $topOffset+$plotHeight+$pad; $width+($pad*2); $topOffset+$plotHeight+$pad).stroke(1).setID("hAxis")
	End if 

	If (Bool:C1537($options.axis))\
		 || (Bool:C1537($options.vAxis))
		This:C1470.line(0; $topOffset; 0; $topOffset+$plotHeight+$pad).stroke(1).setID("vAxis")
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
		
		This:C1470.group("root").translate(10; 10)
		
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
	
	//———————————————————————————————————————————————————————————————————————————
	// Mini line chart for KPI cards
Function sparkline($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart
	
	$options:=$options || {}
	
	This:C1470._closeChart(This:C1470.id)
	This:C1470.id:=$id
	
	// Create root group
	This:C1470.group().translate($x; $y).setID($id)
	
	var $values : Collection:=$options.data || []
	
	If ($values.length=0)
		return This:C1470
	End if 
	
	// Calculate min/max for normalization
	var $min : Real:=$values.min()
	var $max : Real:=$values.max()
	var $range : Real:=$max-$min
	
	If ($range=0)
		$range:=1
	End if 
	
	// Build points collection [x, y]
	var $points : Collection:=[]
	var $i : Integer
	var $stepX : Real:=$width/($values.length-1)
	
	For ($i:=0; $i<$values.length; $i+=1)
		var $normalized : Real:=($values[$i]-$min)/$range
		// Invert Y for SVG coords
		var $pointY : Real:=$height*(1-$normalized)
		$points.push([$i*$stepX; $pointY])
	End for 
	
	// Draw fill under curve (optional)
	If (Bool:C1537($options.fill))
		This:C1470.polygon().setID($id+"_fill")
		This:C1470.plot([[$points[0][0]; $height]; ...$points; [$points[$points.length-1][0]; $height]])
		This:C1470.fillColor($options.fillColor || "rgba(100,150,255,0.2)")
		This:C1470.stroke("none")
	End if 
	
	// Draw line
	This:C1470.polyline().setID($id+"_line")
	This:C1470.plot($points)
	This:C1470.stroke($options.color || "#1f77b4")
	This:C1470.strokeWidth($options.strokeWidth || 2)
	This:C1470.fill("none")
	
	This:C1470.store.push({id: $id; dom: This:C1470.latest})
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Lollipop chart (line + circle variant)
Function verticalLollipop($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart
	
	This:C1470._closeChart(This:C1470.id)
	This:C1470.group()
	
	This:C1470.id:=$id
	
	$options:=$options || {}
	var $values : Collection:=$options.data || []
	var $n : Integer:=$values.length
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "lollipop"; \
		orient: "vertical"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: $values}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	This:C1470.store.push({id: $id; dom: This:C1470.latest})
	
	If ($n=0)  // Nothing to draw
		return This:C1470
	End if 
	
	var $gap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.2
	var $pad : Real:=$options.padding#Null:C1517 ? Num:C11($options.padding) : 10
	var $circleRadius : Real:=$options.circleRadius#Null:C1517 ? Num:C11($options.circleRadius) : 4
	
	This:C1470.translate($x; $y)
	
	// Compute max
	var $maxValue : Real:=($options.max#Null:C1517) ? Num:C11($options.max) : $values.max("value")
	$maxValue:=$maxValue+Num:C11($maxValue=0)
	
	var $step : Real:=$width/$n
	var $stickWidth : Real:=1
	
	// Axis
	If (Bool:C1537($options.axis)) || (Bool:C1537($options.hAxis))
		This:C1470.line(0; $height+$pad; $width+$pad; $height+$pad).stroke(2).setID("hAxis")
	End if 
	
	If (Bool:C1537($options.axis)) || (Bool:C1537($options.vAxis))
		This:C1470.line(0; 0; 0; $height+$pad).stroke(2).setID("vAxis")
	End if 
	
	var $color : cs:C1710.color
	var $i : Integer
	var $serie : Object
	For each ($serie; $values)
		
		$i+=1
		var $val : Real:=Num:C11($serie.value)
		
		// Position from left
		var $xpos : Real:=Round:C94(($i-1)*$step+($step/2); 2)
		
		// Height scaled (from bottom up)
		var $h : Real:=Round:C94(($val/$maxValue)*$height; 2)
		
		// Determine color
		var $color_val : Text
		If ($serie.color#Null:C1517)
			$color_val:=$serie.color
		Else 
			var $hsl:={\
				hue: (360-$i)*360/$n; \
				saturation: 60; \
				lightness: 50}
			$color:=$color || cs:C1710.color.new()
			$color_val:=$color.setHSL($hsl).colorToCSS($color.main; "hexLong")
		End if 
		
		// Draw stick (vertical line)
		This:C1470.line($xpos; $height; $xpos; $height-$h)\
			.stroke($color_val).strokeWidth($stickWidth).setID(String:C10($i; "stick_###"))
		
		// Draw circle at top
		This:C1470.circle($circleRadius; $xpos; $height-$h)\
			.fill($color_val).stroke($options.circleStroke || "none").setID(String:C10($i; "circle_###"))
		
		// Label (bottom)
		If (Bool:C1537($options.showLabels))
			This:C1470.text($serie.label).position($xpos; $height+$pad+4)\
				.font({size: Num:C11($options.fontSize) || 12}).alignment(Align center:K42:3)
		End if 
		
		// Value (top)
		If (Bool:C1537($options.showValues))
			This:C1470.text(String:C10($val)).position($xpos; $height-$h-$circleRadius-4)\
				.font({size: Num:C11($options.fontSize) || 12}).alignment(Align center:K42:3)
		End if 
		
		This:C1470.setAttribute("indx"; $i)
		
	End for each 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Horizontal lollipop chart
Function horizontalLollipop($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart
	
	This:C1470._closeChart(This:C1470.id)
	This:C1470.group()
	
	This:C1470.id:=$id
	
	$options:=$options || {}
	var $values : Collection:=$options.data || []
	var $n : Integer:=$values.length
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "lollipop"; \
		orient: "horizontal"; \
		x: $x; \
		y: $y; \
		width: $width; \
		height: $height; \
		values: $values}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	This:C1470.store.push({id: $id; dom: This:C1470.latest})
	
	If ($n=0)  // Nothing to draw
		return This:C1470
	End if 
	
	var $gap : Real:=$options.gap#Null:C1517 ? Num:C11($options.gap) : 0.2
	var $pad : Real:=$options.padding#Null:C1517 ? Num:C11($options.padding) : 10
	var $circleRadius : Real:=$options.circleRadius#Null:C1517 ? Num:C11($options.circleRadius) : 4
	
	This:C1470.translate($x; $y)
	
	// Compute max
	var $maxValue : Real:=($options.max#Null:C1517) ? Num:C11($options.max) : $values.max("value")
	$maxValue:=$maxValue+Num:C11($maxValue=0)
	
	var $step : Real:=$height/$n
	var $stickHeight : Real:=1
	
	// Axis
	If (Bool:C1537($options.axis)) || (Bool:C1537($options.hAxis))
		This:C1470.line($width+$pad; 0; $width+$pad; $height+$pad).stroke(2).setID("hAxis")
	End if 
	
	If (Bool:C1537($options.axis)) || (Bool:C1537($options.vAxis))
		This:C1470.line(0; 0; $width+$pad; 0).stroke(2).setID("vAxis")
	End if 
	
	var $color : cs:C1710.color
	var $i : Integer
	var $serie : Object
	For each ($serie; $values)
		
		$i+=1
		var $val : Real:=Num:C11($serie.value)
		
		// Position from top
		var $ypos : Real:=Round:C94(($i-1)*$step+($step/2); 2)
		
		// Width scaled (from left right)
		var $w : Real:=Round:C94(($val/$maxValue)*$width; 2)
		
		// Determine color
		var $color_val : Text
		If ($serie.color#Null:C1517)
			$color_val:=$serie.color
		Else 
			var $hsl:={\
				hue: (360-$i)*360/$n; \
				saturation: 60; \
				lightness: 50}
			$color:=$color || cs:C1710.color.new()
			$color_val:=$color.setHSL($hsl).colorToCSS($color.main; "hexLong")
		End if 
		
		// Draw stick (horizontal line)
		This:C1470.line(0; $ypos; $w; $ypos)\
			.stroke($color_val).strokeWidth($stickHeight).setID(String:C10($i; "stick_###"))
		
		// Draw circle at end
		This:C1470.circle($circleRadius; $w; $ypos)\
			.fill($color_val).stroke($options.circleStroke || "none").setID(String:C10($i; "circle_###"))
		
		// Label (left)
		If (Bool:C1537($options.showLabels))
			This:C1470.textArea($serie.label).width(80)\
				.font({size: Num:C11($options.fontSize) || 12}).alignment(Align right:K42:4)\
				.translate(-90; $ypos-8)
		End if 
		
		// Value (right end)
		If (Bool:C1537($options.showValues))
			This:C1470.text(String:C10($val)).position($w+$circleRadius+4; $ypos)\
				.font({size: Num:C11($options.fontSize) || 12}).alignment(Align left:K42:2)
		End if 
		
		This:C1470.setAttribute("indx"; $i)
		
	End for each 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	// Heatmap chart (matrix of colored cells)
Function heatmap($id : Text; $x : Real; $y : Real; $width : Real; $height : Real; $options : Object) : cs:C1710.chart
	
	This:C1470._closeChart(This:C1470.id)
	This:C1470.group()
	
	This:C1470.id:=$id
	
	$options:=$options || {}
	var $data : Collection:=$options.data || []
	
	If ($data.length=0)
		return This:C1470
	End if 
	
	// Flatten 2D data if nested arrays
	var $rows : Integer:=$data.length
	var $cols : Integer:=0
	var $flatData : Collection:=[]
	var $allValues : Collection:=[]
	
	var $i : Integer
	var $j : Integer
	var $row : Variant
	For ($i:=0; $i<$rows; $i+=1)
		$row:=$data[$i]
		
		If (Value type:C1509($row)=Is collection:K8:32)
			$cols:=$row.length>$cols ? $row.length : $cols
			For ($j:=0; $j<$row.length; $j+=1)
				$flatData.push({row: $i; col: $j; value: Num:C11($row[$j])})
				$allValues.push(Num:C11($row[$j]))
			End for 
		End if 
	End for 
	
	If ($flatData.length=0)
		return This:C1470
	End if 
	
	// Compute color scale
	var $minVal : Real:=$allValues.min()
	var $maxVal : Real:=$allValues.max()
	var $range : Real:=$maxVal-$minVal
	
	If ($range=0)
		$range:=1
	End if 
	
	// Cell dimensions
	var $cellWidth : Real:=$width/$cols
	var $cellHeight : Real:=$height/$rows
	var $pad : Real:=$options.padding#Null:C1517 ? Num:C11($options.padding) : 10
	
	This:C1470.translate($x; $y)
	
	Super:C1706.setAttributes({\
		id: $id; \
		type: "heatmap"; \
		width: $width; \
		height: $height; \
		rows: $rows; \
		cols: $cols; \
		values: $flatData}; \
		This:C1470.create(This:C1470.latest; "vdl:graph")\
		)
	
	This:C1470.store.push({id: $id; dom: This:C1470.latest})
	
	// Color palette (default: blue to red)
	var $colors : Collection:=$options.colors || [\
		"#0571B0"; \
		"#2E8BC0"; \
		"#92C5DE"; \
		"#F7F7F7"; \
		"#F4A582"; \
		"#E08214"; \
		"#B35806"\
		]
	
	var $cell : Object
	For each ($cell; $flatData)
		
		var $norm : Real:=($cell.value-$minVal)/$range
		var $colorIdx : Integer:=Round:C94($norm*($colors.length-1); 0)
		$colorIdx:=$colorIdx<0 ? 0 : $colorIdx
		$colorIdx:=$colorIdx>=$colors.length ? $colors.length-1 : $colorIdx
		
		var $px : Real:=$cell.col*$cellWidth
		var $py : Real:=$cell.row*$cellHeight
		
		This:C1470.rect($cellWidth-1; $cellHeight-1).position($px; $py)\
			.fill($colors[$colorIdx])\
			.stroke("white").strokeWidth(1)\
			.setID($id+"_r"+String:C10($cell.row)+"_c"+String:C10($cell.col))
		
		// Optional value label
		If (Bool:C1537($options.showValues))
			This:C1470.text(String:C10(Round:C94($cell.value; 1)))\
				.position($px+($cellWidth/2); $py+($cellHeight/2))\
				.setAttribute("text-anchor"; "middle").setAttribute("dominant-baseline"; "middle")\
				.font({size: 10; color: "#333"})
		End if 
		
	End for each 
	
	// Row labels (left)
	If (Bool:C1537($options.showRowLabels) && $options.rowLabels#Null:C1517)
		
		var $rowLabels : Collection:=$options.rowLabels
		For ($i:=0; $i<$rows && $i<$rowLabels.length; $i+=1)
			var $py : Real:=$i*$cellHeight+($cellHeight/2)
			This:C1470.text(String:C10($rowLabels[$i]))\
				.position(-$pad; $py)\
				.setAttribute("text-anchor"; "end").setAttribute("dominant-baseline"; "middle")\
				.font({size: 11; color: "#333"})
		End for 
	End if 
	
	// Col labels (top)
	If (Bool:C1537($options.showColLabels) && $options.colLabels#Null:C1517)
		
		var $colLabels : Collection:=$options.colLabels
		For ($j:=0; $j<$cols && $j<$colLabels.length; $j+=1)
			var $px : Real:=$j*$cellWidth+($cellWidth/2)
			This:C1470.text(String:C10($colLabels[$j]))\
				.position($px; -($pad/2))\
				.setAttribute("text-anchor"; "middle").setAttribute("dominant-baseline"; "bottom")\
				.font({size: 11; color: "#333"})
		End for 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————————————————————
	//
Function setValues($id : Text; $values : Collection) : cs:C1710.chart
	
	// TODO: Set values according to the graph type
	
	return This:C1470
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// returns an HSL color definition
Function _getColor($index : Integer; $max : Integer) : Object
	
	return {\
		hue: (360-$index)*360/$max; \
		saturation: 60; \
		lightness: 50}
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// Defining the main font for the chart
Function _graphFont($options : Object) : cs:C1710.font
	
	var $font:=cs:C1710.font.new()
	var $key : Text
	
	For each ($key; $options || {})
		
		$font[$key]:=$options[$key]
		
	End for each 
	
	$font.size:=$font.size || 12
	$font.color:=$font.color || "black"
	
	return $font
	
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