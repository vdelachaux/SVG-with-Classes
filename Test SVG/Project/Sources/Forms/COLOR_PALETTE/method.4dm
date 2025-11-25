var $c : Collection:=JSON Parse:C1218(File:C1566("/RESOURCES/colors.json").getText()).indexed

var $svg:=cs:C1710.svgx.svg.new().stroke(1).stroke("white")

var $column; $indx; $row; $x; $y : Integer

For ($row; 0; 15; 1)
	
	$x:=0
	
	For ($column; 1; 16; 1)
		
		$indx:=($row*16)+$column
		$svg.rect(11; 11).position($x; $y).setID(String:C10($indx)).fill($c[$indx-1])
		$x+=11
		
	End for 
	
	$y+=11
	
End for 

OBJECT SET VALUE:C1742("colorIndexed"; $svg.picture())