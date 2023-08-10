var $column; $indx; $row; $x; $y : Integer
var $e : Object
var $c : Collection
var $svg : cs:C1710.svg

$e:=FORM Event:C1606

Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		$c:=JSON Parse:C1218(File:C1566("/RESOURCES/colors.json").getText()).indexed
		
		$svg:=cs:C1710.svg.new().stroke(1).stroke("white")
		
		For ($row; 0; 15; 1)
			
			$x:=0
			
			For ($column; 1; 16; 1)
				
				$indx:=($row*16)+$column
				$svg.rect(11; 11).position($x; $y).id(String:C10($indx)).fill($c[$indx-1])
				$x:=$x+11
				
			End for 
			
			$y:=$y+11
			
		End for 
		
		OBJECT SET VALUE:C1742("colorIndexed"; $svg.picture())
		
		//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
End case 