Class extends svg

Class constructor
	
	Super:C1705()
	
	//———————————————————————————————————————————————————————————
	// Begin a pie group
Function pie($id : Text; $cx : Real; $cy : Real; $r : Real; $start : Integer) : cs:C1710.svg
	
	This:C1470.layer("chart"; "dev")
	
	
	This:C1470.group($id)\
		.setAttributes({type: "pie"; cx: $cx; cy: $cy; r: $r; start: $start; cur: $start; values: []; dev: True:C214})\
		.attachTo("chart")
	
	// TODO:Allow title & more…
	
	return This:C1470
	
	
	
	//———————————————————————————————————————————————————————————
	// Begin a donut group
Function donut($id : Text; $cx : Real; $cy : Real; $r : Real; $start : Integer) : cs:C1710.svg
	
	This:C1470.layer("chart"; "dev")
	
	This:C1470.group($id)\
		.setAttributes({type: "donut"; cx: $cx; cy: $cy; r: $r; start: $start; cur: $start; values: []; dev: True:C214})\
		.attachTo("chart")
	
	//This.circle($r; $cx; $cy).stroke("red").attachTo("dev")
	
	// TODO:Allow title & more…
	
	return This:C1470
	
	
	//———————————————————————————————————————————————————————————
	// Begin a pie group fit into a square
Function pieBounded($id : Text; $x : Real; $y : Real; $width : Real; $start : Integer) : cs:C1710.svg
	
	var $r : Real
	
	$r:=$width/2
	
	If (Count parameters:C259>=5)
		
		This:C1470.pie($id; $x+$r; $y+$r; $r; $start)
		
	Else 
		
		This:C1470.pie($id; $x+$r; $y+$r; $r)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Draws a pie wedge
Function wedge($id : Text; $percent : Real) : cs:C1710.svg
	
	var $cx; $cy; $r : Real
	var $chart; $type : Text
	var $cur; $start; $to : Integer
	var $o : Object
	var $flags; $values : Collection
	
	// TODO:Allow labels
	
	// Get chart datas
	$chart:=This:C1470.findById($id)
	$o:=This:C1470.getAttributes($chart)
	
	$cx:=$o.cx
	$cy:=$o.cy
	$r:=$o.r
	$cur:=$o.cur
	$start:=$o.start
	$values:=$o.values
	
	If (Count parameters:C259>=2)
		
		$to:=$cur+(360*($percent/100))
		
	Else 
		
		$to:=$start>=0 ? 360-$start : 360+$start
		$percent:=100-$values.sum()
		
	End if 
	
	$values.push($percent)
	
	$to:=$to>360 ? 360 : $to
	
	$flags:=($to-$cur)>180 ? [1; 1] : [0; 1]
	
	Case of 
			//______________________________________________________
		: ($o.type="pie")
			
			This:C1470.path()
			This:C1470.moveTo([$cx; $cy])
			
			var $xA; $yA : Real
			$xA:=(Sin:C17($cur*Degree:K30:2)*$r)+$cx
			$yA:=-(Cos:C18($cur*Degree:K30:2)*$r)+$cy
			This:C1470.lineTo([$xA; $yA])
			
			var $xB; $yB : Real
			$xB:=(Sin:C17($to*Degree:K30:2)*$r)+$cx
			$yB:=-(Cos:C18($to*Degree:K30:2)*$r)+$cy
			This:C1470.A($r; $r; 0; $flags[0]; $flags[1]; $xB; $yB)
			
			This:C1470.Z()
			
			//______________________________________________________
		: ($o.type="donut")
			
			
			//TODO: Allow as parameter
			var $r2 : Real
			$r2:=$r*0.7
			
			If ($o.dev)
				
				This:C1470.circle($r2; $cx; $cy).stroke("red").attachTo("dev")
				This:C1470.circle(2; $cx; $cy).color("red").attachTo("dev")
				This:C1470.text("[cx,cy]").position($cx+8; $cy+10).attachTo("dev").color("blue")
				
			End if 
			
			This:C1470.path().attachTo("chart")
			var $x; $y : Real
			
			// External arc
			var $xA; $yA : Real
			$xA:=(Sin:C17($cur*Degree:K30:2)*$r)+$cx
			$yA:=-(Cos:C18($cur*Degree:K30:2)*$r)+$cy
			This:C1470.moveTo([$xA; $yA])
			
			var $xB; $yB : Real
			$xB:=(Sin:C17($to*Degree:K30:2)*$r)+$cx
			$yB:=-(Cos:C18($to*Degree:K30:2)*$r)+$cy
			This:C1470.A($r; $r; 0; $flags[0]; $flags[1]; $xB; $yB)
			
			//internal
			
/*
$r2:=$r*0.7
			
var $xP; $yP : Real
$xP:=($xA+$xB)/2
$yP:=($yA+$yB)/2
			
// Equation de la droite OP
// y = ax + b
$a:=($yP-$cy)/($xP-$cx)
$b:=$yP-($m*$xP)
			
// distance  horizontale entre les points
$x:=Abs($xB-$xA)
			
// valeur de y pour les points A et B
$Ay:=($a*$xA)+$b
$By:=($a*$xB)+$b
			
// distance  verticale entre les points
$y:=Abs($Ay-$By)
			
$length:=Square root(($x^2)+($y^2))
			
$d:=$r*2
$offset:=($length*100)/$d
$offset:=$offset/100
			
//$diff:=$r-$length
			
//$offset:=($r/$diff)
//$r2:=($r*0.7)*$offset
			
//$r2:=$r*0.8
*/
			var $x2; $y2 : Real
			$x2:=(Sin:C17($to*Degree:K30:2)*$r2)+$cx
			$y2:=-(Cos:C18($to*Degree:K30:2)*$r2)+$cy
			This:C1470.lineTo([$x2; $y2])
			
			$x:=(Sin:C17($cur*Degree:K30:2)*$r2)+$cx
			$y:=-(Cos:C18($cur*Degree:K30:2)*$r2)+$cy
			
			If (True:C214)
				
				$flags:=[0; 0]
				This:C1470.A($r; $r; 0; $flags[0]; $flags[1]; $x; $y)
				
			Else 
				
				var $begin; $end : Collection
				$begin:=[$xA+75; $yA+40]
				$end:=[$xA+75; $yA+40]
				//$end:=[$x*1.5; $y]
				This:C1470.cubicBezierCurveto([$x; $y]; $begin; $end)
				
				
			End if 
			
			
			If (False:C215)
				$latest:=This:C1470.latest
				
				This:C1470.text("A").position($xA+5; $yA+15).color("red").attachTo("dev")
				This:C1470.text("B").position($xB-15; $yB+15).color("red").attachTo("dev")
				
				
				This:C1470.line($x; $y; $begin[0]; $begin[1]).stroke("blue").attachTo("dev")
				This:C1470.circle(2; $begin[0]; $begin[1]).stroke("blue").attachTo("dev")
				
				This:C1470.line($x2; $y2; $end[0]; $end[1]).stroke("red").attachTo("dev")
				This:C1470.circle(2; $end[0]; $end[1]).stroke("red").attachTo("dev")
				
				This:C1470.latest:=$latest
			End if 
			
			This:C1470.Z()
			
			//______________________________________________________
	End case 
	
	This:C1470.setAttribute("indx"; $values.length)
	
	// Update chart datas
	Super:C1706.setAttribute("cur"; $to; $chart)
	Super:C1706.setAttribute("values"; $values; $chart)
	
	// TODO:Display the legend (option)
	
	// TODO:Display the value (option)
	
	If (Bool:C1537($o.dev)) & False:C215
		
		var $latest : Text
		$latest:=This:C1470.latest
		
		// The AB chord
		This:C1470.line($xA; $yA; $xB; $yB).color("red").attachTo("dev")
		
		// The chord mediator [AB]
		var $xP; $yP : Real
		$xP:=($xA+$xB)/2
		$yP:=($yA+$yB)/2
		This:C1470.line($cx; $cy; $xP; $yP).color("blue").attachTo("dev")
		
		This:C1470.text("A").position($xA+5; $yA+15).color("red").attachTo("dev")
		This:C1470.text("B").position($xB-15; $yB+15).color("red").attachTo("dev")
		
		This:C1470.circle(2; $xP; $yP).color("blue").attachTo("dev")
		This:C1470.text("P").position($xP+5; $yP+15).color("blue").attachTo("dev")
		
		// Equation de la droite OP
		// y = ax + b
		
		//$a:=($yP-$cy)/($xP-$cx)
		//$b:=$yP-($m*$xP)
		
		var $P : Real
		$P:=($yA+$yB)/($xA+$xB)
		
/*
var $Radius : Real
//Cercle de centre I (a, b) -> (x – a)² + (y – b)² = R²
$Radius:=Square root((($xB-$cx)^2)+(($yB-$cy)^2))
ASSERT($Radius=$r)
*/
		
		// Midle of the Arc
		var $xM; $yM : Real
		//$xM:=Square root(($r^2)/(($P^2)+1))
		
		$xM:=Round:C94(Square root:C539($r^2/(1+$P^2)); 2)
		
		$yM:=Round:C94($P*$xM; 2)
		
		//This.line($cx; $cy; $xM; $yM).color("red").attachTo("dev")
		This:C1470.circle(2; $xM; $yM).color("red").attachTo("dev")
		
		//This.text(String($percent)+" %"; This.parent(This.latest)).position($xM; $yM)
		
		This:C1470.latest:=$latest
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// End a pie group
Function closePie() : cs:C1710.svg
	
	This:C1470.latest:=This:C1470.parent(This:C1470.parent(This:C1470.latest))
	
Function drawSegment($o : Object)
	
	var $chart : Object
	var $pathRef : Text
	var $cx; $cy : Real
	var $x2; $y2; $x3; $y3; $x4; $y4 : Real
	var $x2bis; $y2bis; $x4bis; $y4bis; $x5bis; $y5bis : Real
	
	$chart:=This:C1470._props
	
	$cx:=$chart.width/2
	$cy:=$chart.height/2
	
	$x2:=$cx+Int:C8(Sin:C17($o.midAngle*Degree:K30:2)*$chart.popoutRadius)
	$y2:=$cy-Int:C8(Cos:C18($o.midAngle*Degree:K30:2)*$chart.popoutRadius)
	
	// $_p.thickness
	$x2bis:=$cx+Int:C8(Sin:C17($o.startAngle*Degree:K30:2)*($chart.popoutRadius+$chart.innerRadius))
	$y2bis:=$cy-Int:C8(Cos:C18($o.startAngle*Degree:K30:2)*($chart.popoutRadius+$chart.innerRadius))
	
	$pathRef:=SVG_New_path(This:C1470.svg.root; $x2bis; $y2bis; $o.segColor; $o.segColor; 0)  //0.5
	
	$x3:=$cx+Int:C8(Sin:C17($o.startAngle*Degree:K30:2)*($chart.outerRadius+$chart.popoutRadius))
	$y3:=$cy-Int:C8(Cos:C18($o.startAngle*Degree:K30:2)*($chart.outerRadius+$chart.popoutRadius))
	
	$x4:=$cx+Int:C8(Sin:C17($o.endAngle*Degree:K30:2)*($chart.outerRadius+$chart.popoutRadius))
	$y4:=$cy-Int:C8(Cos:C18($o.endAngle*Degree:K30:2)*($chart.outerRadius+$chart.popoutRadius))
	SVG_PATH_LINE_TO($pathRef; $x3; $y3)
	
	If (($o.endAngle-$o.startAngle)>=180)
		$x4bis:=$cx+Int:C8(Sin:C17($o.midAngle*Degree:K30:2)*($chart.outerRadius+$chart.popoutRadius))
		$y4bis:=$cy-Int:C8(Cos:C18($o.midAngle*Degree:K30:2)*($chart.outerRadius+$chart.popoutRadius))
		SVG_PATH_ARC($pathRef; $chart.outerRadius+$chart.popoutRadius; $chart.outerRadius+$chart.popoutRadius; $x4bis; $y4bis; 0; 0)
		SVG_PATH_ARC($pathRef; $chart.outerRadius+$chart.popoutRadius; $chart.outerRadius+$chart.popoutRadius; $x4; $y4; 0; 0)
	Else 
		SVG_PATH_ARC($pathRef; $chart.outerRadius+$chart.popoutRadius; $chart.outerRadius+$chart.popoutRadius; $x4; $y4; 0; 0)
	End if 
	
	$x5:=$cx+Int:C8(Sin:C17($o.endAngle*Degree:K30:2)*($chart.popoutRadius+$chart.innerRadius))
	$y5:=$cy-Int:C8(Cos:C18($o.endAngle*Degree:K30:2)*($chart.popoutRadius+$chart.innerRadius))
	SVG_PATH_LINE_TO($pathRef; $x5; $y5)
	
	If (($o.endAngle-$o.startAngle)>=180)
		$x5bis:=$cx+Int:C8(Sin:C17($o.midAngle*Degree:K30:2)*($chart.popoutRadius+$chart.innerRadius))
		$y5bis:=$cy-Int:C8(Cos:C18($o.midAngle*Degree:K30:2)*($chart.popoutRadius+$chart.innerRadius))
		SVG_PATH_ARC($pathRef; $chart.popoutRadius+$chart.innerRadius; $chart.popoutRadius+$chart.innerRadius; $x5bis; $y5bis; 0; 2)
		SVG_PATH_ARC($pathRef; $chart.popoutRadius+$chart.innerRadius; $chart.popoutRadius+$chart.innerRadius; $x2bis; $y2bis; 0; 2)
	Else 
		SVG_PATH_ARC($pathRef; $chart.popoutRadius+$chart.innerRadius; $chart.popoutRadius+$chart.innerRadius; $x2bis; $y2bis; 0; 2)
	End if 
	
	SVG_SET_ID($pathRef; String:C10($i))
	
	SVG_SET_OPACITY(This:C1470.svg.root; $o.fillOpacity; $o.strokeOpacity)
	
	