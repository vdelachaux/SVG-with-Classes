var $e:=FORM Event:C1606

Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		Form:C1466.cx:=240
		Form:C1466.cy:=240
		Form:C1466.radius:=240
		Form:C1466.colorNumber:=180
		
		var $angle : Real:=100/Form:C1466.colorNumber
		
		var $hsl:={hue: 0; saturation: 100; lightness: 100}
		
		var $color:=cs:C1710.svgx.color.new()
		
		var $chart : cs:C1710.svgx.chart:=cs:C1710.svgx.chart.new().pie("wheel"; Form:C1466.cx; Form:C1466.cy; Form:C1466.radius)
		
		var $i : Integer
		For ($i; 1; Form:C1466.colorNumber; 1)
			
			$hsl.hue:=$i*360/Form:C1466.colorNumber
			$chart.wedge("wheel"; $angle).color($color.setHSL($hsl).colorToCSS($color.main; "hexLong"))
			
		End for 
		
		OBJECT SET VALUE:C1742("wheel"; $chart.picture())
		
		//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
End case 