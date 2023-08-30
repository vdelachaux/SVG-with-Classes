Class constructor
	This:C1470.E:=2.718281828459
	This:C1470.LN2:=0.6931471805599
	This:C1470.PI:=3.14159265359
	This:C1470.LN10:=2.302585092994
	This:C1470.LOG10E:=0.4342944819033
	This:C1470.LOG2E:=1.442695040889
	This:C1470.PI:=3.14159265359
	This:C1470.SQRT2:=1.414213562373
	This:C1470.SQRT1_2:=0.7071067811865
	This:C1470.Degree:=0.01745329251994
	This:C1470.Radian:=57.29577951308
	This:C1470.NaN:=Log:C22(-1)
	This:C1470.POSITIVE_INFINITY:=1/0
	This:C1470.NEGATIVE_INFINITY:=-1/0
	
	
Function abs
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs
	var $0 : Real
	var $1 : Real
	
	If (Count parameters:C259=1)
		$0:=Abs:C99($1)
	Else 
		$0:=This:C1470.NaN
	End if 
	
	
Function acos
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/acos
	
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		
		If ($value>1) | ($value<-1)
			$result:=This:C1470.NaN
		Else 
			
			Case of 
				: ($value=0)  // évitons une division par zéro
					$result:=This:C1470.PI/2
					
				: ($value<0)
					// Question? Le code dans le if et le else est le meme? je ne comprend pas ce test
					// Et PI est toujours <4... ???
					If (This:C1470.PI>4)  // Correction d'un bug 4D sur la valeur de Pi dans certaines conditions.
						$result:=This:C1470.PI-This:C1470.atan(This:C1470.sqrt(1-This:C1470.pow($value; 2))/This:C1470.abs($value))
					Else 
						$result:=This:C1470.PI-This:C1470.atan(This:C1470.sqrt(1-This:C1470.pow($value; 2))/This:C1470.abs($value))
					End if 
					
				: ($value>0)
					$result:=This:C1470.atan(This:C1470.sqrt(1-This:C1470.pow($value; 2))/$value)
			End case 
			
		End if 
		
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function acosh
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/acosh
	
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=This:C1470.log($value+This:C1470.sqrt(($value*($value))-1))
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function asin
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/asin
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		If ($value>1) | ($value<-1)
			$result:=This:C1470.NaN
		Else 
			If ($value=1)
				$result:=This:C1470.PI/2
			Else 
				$result:=This:C1470.atan($value/(This:C1470.sqrt(1-This:C1470.pow($value; 2))))  // result in radian
			End if 
		End if 
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function asinh
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/asinh
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=This:C1470.log($value+This:C1470.sqrt(($value*($value))+1))
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function atan
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/atan
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$result:=Arctan:C20($1)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function atan2
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/atan2
	
	var $0; $result : Real
	var $1; $y : Real
	var $2; $x : Real
	$y:=$1
	$x:=$2
	
	If (Count parameters:C259=2)
		
		Case of 
			: ($x>0)
				$result:=This:C1470.atan($y/$x)
			: ($x<0) & ($y>=0)
				$result:=This:C1470.atan($y/$x)+This:C1470.PI
			: ($x<0) & ($y<0)
				$result:=This:C1470.atan($y/$x)-This:C1470.PI
			: ($x=0) & ($y>0)
				$result:=(This:C1470.PI/2)
			: ($x=0) & ($y<0)
				$result:=-(This:C1470.PI/2)
			: ($x=0) & ($y=0)
				$result:=0
			Else 
				$result:=This:C1470.NaN
		End case 
		
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function atanh
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/atanh
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Log:C22((1+$value)/(1-($value)))/2
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function cbrt
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/cbrt
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		
		If ($value<0)
			$result:=-(-$value^(1/3))  // ensure negative numbers remain negative:
		Else 
			$result:=$value^(1/3)
		End if 
		
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function ceil
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/ceil
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=-Int:C8(-$value)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function clz32
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/clz32
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Position:C15("1"; LongInt2BinaryString($value); 1)-1
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function cos
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/cos
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Cos:C18($value)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function cosh
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/cosh
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=(Exp:C21($value)+Exp:C21(-$value))/2
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function exp
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/exp
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Exp:C21($value)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function expm1
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/expm1
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Exp:C21($value)-1
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function floor
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/floor
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Int:C8($value)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function hypot
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/hypot
	//C_REAL($0;$result)
	//C_REAL(${1})
	var $0; $result : Real
	var ${1} : Real  // not sure if 4D is able to handle this kind of declaration... to test
	
	If (Count parameters:C259>0)
		$sum:=0
		For ($i; 1; Count parameters:C259)
			$sum:=$sum+(${$i}^2)
		End for 
		$result:=This:C1470.sqrt($sum)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function imul
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/imul
	var $0; $result : Real
	var $1; $2 : Integer
	
	If (Count parameters:C259=1)
		$result:=$1*$2
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function log
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/log
	
	var $0; $result : Real
	var $1; $value : Real
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Log:C22($value)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
Function log10
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/log
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Log:C22($value)*This:C1470.LOG10E
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function log1p
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/log1p
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=This:C1470.log(1+$value)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function log2
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/log
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$0:=Log:C22($value)*This:C1470.LOG2E
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function max
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/max
	var $0 : Real
	var $1 : Collection
	$0:=$1.max()
	
Function min
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/min
	var $0 : Real
	var $1 : Collection
	$0:=$1.min()
	
	
Function pow
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/pow
	var $0; $result : Real
	var $1; $2 : Real
	
	If (Count parameters:C259=2)
		$result:=$1^$2
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function random
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random
	var $0 : Integer
	$0:=Random:C100/MAXINT:K35:1
	
	
Function round
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/round
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		If ($value<0)
			$result:=Round:C94($value+0.01; 0)
		Else 
			$result:=Round:C94($value; 0)
		End if 
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
	
Function sign
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sign
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		Case of 
			: ($value>0)
				$result:=1
			: ($value=0)
				$result:=0
			: ($value<0)
				$result:=-1
			Else 
				$result:=This:C1470.NaN
		End case 
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function sin
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sin
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Sin:C17(($value))
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function sinh
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sinh
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$y:=This:C1470.exp($value)
		$result:=($y-(1/$y))/2
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function sqrt
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/sqrt
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Square root:C539($value)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function tan
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/tan
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$result:=Tan:C19($value)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
	
Function tanh
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/tanh
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$a:=This:C1470.exp($value)
		$b:=This:C1470.exp(-$value)
		$result:=($a-$b)/($a+$b)
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
Function toRadians
	var $0 : Real
	var $1 : Real
	If (Count parameters:C259=1)
		$0:=$1*This:C1470.PI/180
	Else 
		$result:=0
	End if 
	
Function toDegrees
	var $0 : Real
	var $1 : Real
	If (Count parameters:C259=1)
		$0:=$1*180/This:C1470.PI
	Else 
		$result:=0
	End if 
	
Function trunc
	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/trunc
	var $0; $result : Real
	var $1; $value : Real
	
	If (Count parameters:C259=1)
		$value:=$1
		$str:=String:C10($value)
		GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $vDecSep)
		$result:=Num:C11(Substring:C12($str; 1; Position:C15($vDecSep; $str)-1))
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	
Function roundDecimal
	// roundDecimal ( $valueToRound ; $precision ; $roundType ) -> return $valueRounded
	//
	// $valueToRound : (real) value to be rounded
	// $precision : (real) precision of the rounding
	// $roundType : (text) type of rounding
	// $valueRounded : (real) (return) value rounded
	//
	// Return a rounded value based on the given options
	
	If (False:C215)
		// ----------------------------------------------------
		// User name (OS): gabriel inzirillo
		// Date and time: 23.01.19, 11:26:55
		// ----------------------------------------------------
		// Method: AJ_Tools_RoundDecimal
		// Description
		// This method can be used to round a value.
		// $precision : The precision of the value that we want to round. Ex. 0.1, 0.5, 2, 0.01
		// $roundType : The list of existing round type must use one of those constants:
		//   ROUND_UP : Round UP away from 0 (<-0->)
		//   ROUND_DOWN : Round DOWN toward 0 (->0<-)
		//   ROUND_CEILING : Round UP (<-0<-)
		//   ROUND_FLOOR : Round DOWN (->0->)
		//   ROUND_HALF_UP : Round UP toward the nearest neighbor, round UP (<-0->) if equal distances to neighbors
		//   ROUND_HALF_DOWN : Round DOWN toward the nearest neighbor, round DOWN (->0<-) if equal distances to neighbors
		//   ROUND_HALF_CEILING : Round UP toward the nearest neighbor, round CEILING (<-0<-) if equal distances to neighbors
		//   ROUND_HALF_FLOOR : Round DOWN toward the nearest neighbor, round FLOOR (->0->) if equal distances to neighbors
		//   ROUND_HALF_EVEN : Round to the nearest neighbor, round to the EVEN neighbor if equal distances to neighbors
		//
		// Examples : 
		//   AJ_Tools_RoundDecimal(1.222;0.1;"ROUND_UP") -> 1.3
		//   AJ_Tools_RoundDecimal(-1.222;0.1;"ROUND_UP") -> -1.3
		// 
		//   AJ_Tools_RoundDecimal(1.222;0.1;"ROUND_DOWN") -> 1.2
		//   AJ_Tools_RoundDecimal(-1.222;0.1;"ROUND_DOWN") -> -1.2
		// 
		//   AJ_Tools_RoundDecimal(1.222;0.1;"ROUND_CEILING") -> 1.3
		//   AJ_Tools_RoundDecimal(-1.222;0.1;"ROUND_CEILING") -> -1.2
		// 
		//   AJ_Tools_RoundDecimal(1.222;0.1;"ROUND_FLOOR") -> 1.2
		//   AJ_Tools_RoundDecimal(-1.222;0.1;"ROUND_FLOOR") -> -1.3
		// 
		//   AJ_Tools_RoundDecimal(1.25;0.1;"ROUND_HALF_UP") -> 1.3
		//   AJ_Tools_RoundDecimal(-1.25;0.1;"ROUND_HALF_UP") -> -1.3
		// 
		//   AJ_Tools_RoundDecimal(1.25;0.1;"ROUND_HALF_DOWN") -> 1.2
		//   AJ_Tools_RoundDecimal(-1.25;0.1;"ROUND_HALF_DOWN") -> -1.2
		// 
		//   AJ_Tools_RoundDecimal(1.25;0.1;"ROUND_HALF_CEILING") -> 1.3
		//   AJ_Tools_RoundDecimal(-1.25;0.1;"ROUND_HALF_CEILING") -> -1.2
		// 
		//   AJ_Tools_RoundDecimal(1.25;0.1;"ROUND_HALF_FLOOR") -> 1.2
		//   AJ_Tools_RoundDecimal(-1.25;0.1;"ROUND_HALF_FLOOR") -> -1.3
		// 
		//   AJ_Tools_RoundDecimal(1.25;0.1;"ROUND_HALF_EVEN") -> 1.2
		//   AJ_Tools_RoundDecimal(-1.25;0.1;"ROUND_HALF_EVEN") -> -1.2
		// 
		//   AJ_Tools_RoundDecimal(1.15;0.1;"ROUND_HALF_EVEN") -> 1.2
		//   AJ_Tools_RoundDecimal(-1.15;0.1;"ROUND_HALF_EVEN") -> -1.2
		// 
		// ----------------------------------------------------
		// Copyrights (C) AJAR SA - 2019
	End if 
	
	var $1; $valueToRound : Real
	var $2; $precision : Real
	var $3; $roundType : Text
	var $0; $valueRounded : Real
	var $roundedDif; $multiple : Real
	
	If (Count parameters:C259#3)
		$valueRounded:=This:C1470.NaN
	Else 
		$valueToRound:=$1
		$precision:=$2
		$roundType:=$3
		
		If ($precision#0)
			// $multiple is the multiple that will help to do the rounding using the 4D Round command
			// We will use it to divide the initial value to then do a rounding to 1 and then multiple again the result to come back on our feet.
			// Ex. (1.222;0.1;AJ_ROUND_DOWN) -> $multiple = 1/0.1 = 10 -> Round(1.222*10;0)/10 = Round(12.22)/10 = 12/10 = 1.2
			$multiple:=1/$precision
		End if 
		
		$valueRounded:=Round:C94($valueToRound*$multiple; 0)/$multiple
		$roundedDif:=Abs:C99(($valueRounded-$valueToRound)*$multiple)  // Difference between the rounded value and the notRounded value to see if it is in the half (=0.5)
		
		// Cast the good rounding type
		// Can depend of the sign of the number (positive or negative)
		// Can depend on the rounded difference for the ROUND_HALF_@ cases
		// ROUND_UP (<-0->) 
		// ROUND_DOWN (->0<-)
		Case of 
			: ($roundType="ROUND_UP") & ($valueToRound>0)
				// ROUND_CEILING for positive numbers
				$roundType:="ROUND_CEILING"
			: ($roundType="ROUND_UP") & ($valueToRound<0)
				// ROUND_FLOOR for negative numbers
				$roundType:="ROUND_FLOOR"
				
			: ($roundType="ROUND_DOWN") & ($valueToRound>0)
				// ROUND_FLOOR for positive numbers
				$roundType:="ROUND_FLOOR"
			: ($roundType="ROUND_DOWN") & ($valueToRound<0)
				// ROUND_CEILING for negative numbers
				$roundType:="ROUND_CEILING"
				
			: ($roundType="ROUND_HALF_DOWN") & ($roundedDif=0.5) & ($valueToRound>0)
				// ROUND_HALF_DOWN when rounded difference is 0.5 and value is positive is a ROUND_FLOOR
				$roundType:="ROUND_FLOOR"
				
			: ($roundType="ROUND_HALF_DOWN") & ($roundedDif=0.5) & ($valueToRound<0)
				// ROUND_HALF_DOWN when rounded difference is 0.5 and value is negative is a ROUND_CEILING
				$roundType:="ROUND_CEILING"
				
			: ($roundType="ROUND_HALF_CEILING") & ($roundedDif=0.5)
				// ROUND_HALF_CEILING when rounded difference is 0.5 is a ROUND_CEILING
				$roundType:="ROUND_CEILING"
				
			: ($roundType="ROUND_HALF_FLOOR") & ($roundedDif=0.5)
				// ROUND_HALF_FLOOR when rounded difference is 0.5 is a ROUND_FLOOR
				$roundType:="ROUND_FLOOR"
				
			: ($roundType="ROUND_HALF_EVEN") & ((Int:C8(Abs:C99($valueToRound*$multiple))%2)=0) & ($valueToRound>0)
				// ROUND_HALF_EVEN when nearest neighbor is even and value is positive is a ROUND_FLOOR
				$roundType:="ROUND_FLOOR"
			: ($roundType="ROUND_HALF_EVEN") & ((Int:C8(Abs:C99($valueToRound*$multiple))%2)=0) & ($valueToRound<0)
				// ROUND_HALF_EVEN when nearest neighbor is even and value is negative is a ROUND_CEILING
				$roundType:="ROUND_CEILING"
			: ($roundType="ROUND_HALF_EVEN") & ((Int:C8(Abs:C99($valueToRound*$multiple))%2)=1) & ($valueToRound>0)
				// ROUND_HALF_EVEN when nearest neighbor is odd and value is positive is a ROUND_CEILING
				$roundType:="ROUND_CEILING"
			: ($roundType="ROUND_HALF_EVEN") & ((Int:C8(Abs:C99($valueToRound*$multiple))%2)=1) & ($valueToRound<0)
				// ROUND_HALF_EVEN when nearest neighbor is odd and value is negative is a ROUND_FLOOR
				$roundType:="ROUND_FLOOR"
		End case 
		
		Case of 
			: ($roundType="ROUND_CEILING")
				If ($valueRounded<$valueToRound)
					$valueRounded:=$valueRounded+$precision
				End if 
				
			: ($roundType="ROUND_FLOOR")
				If ($valueRounded>$valueToRound)
					$valueRounded:=$valueRounded-$precision
				End if 
				
			: ($roundType="ROUND_HALF_UP")
				// Default 4D rounding is ROUND_HALF_UP
				// Don't need to do anything
			: ($roundType="ROUND_HALF_DOWN")
				// Special case are trap on the first caseof
			: ($roundType="ROUND_HALF_CEILING")
				// Special case are trap on the first caseof
			: ($roundType="ROUND_HALF_FLOOR")
				// Special case are trap on the first caseof
			: ($roundType="ROUND_HALF_UP")
				// Special case are trap on the first caseof
			: ($roundType="ROUND_HALF_EVEN")
				// Special case are trap on the first caseof
			Else 
				$valueRounded:=$valueToRound
		End case 
		
	End if 
	
	$0:=$valueRounded
	
	
Function spherodistance
	// Olivier Deschanels request and code
	// calculates the distance between two points on earth
	// (or any other sphere, if a fifth parameter is given to define the radius)
	
	// the parameters are the geographical positions of the points
	// in DECIMAL DEGREES and the optional radius in any unit (result will depend on th
	// the default value is 6371 kilometers and the result in kilometers too
	
	// calcule la distance, en km, entre deux points terrestres dont les coordonnées
	// XY sont données en paramètres, exprimés en degrés décimaux
	// ex : g_calculateDistance(14,5;45,33;-12,15;18)
	
	//  cos(angle) = sin(latitude1)sin(latitude2)…
	//  …+cos(latitude1)cos(latitude2)cos(Longitude1-longitude2)
	
	//SAMPLE : 
	//4D_CalculateDistance (-50,81;10,35;40,98;-80,53{;6371})
	
	var $1; $2; $3; $4; $5; $0 : Real
	var $lat1rad; $Lon1rad; $lat2rad; $lon2rad; $dlon; $Radius; $result : Real
	var $Distance; $x; $Lat1; $Lat2; $Long1; $Long2 : Real
	
	If (Count parameters:C259=4) | (Count parameters:C259=5)
		$lon1:=$1
		$lat1:=$2
		$lon2:=$3
		$lat2:=$4
		
		// Harvesine Formula
		If (Count parameters:C259=5)
			$Radius:=$5
		Else 
			$Radius:=6371  //6371 = earth radius
		End if 
		$lat1rad:=This:C1470.toRadians($lat1)
		$lat2rad:=This:C1470.toRadians($lat2)
		$dlat:=This:C1470.toRadians($lat2-$lat1)
		$dlon:=This:C1470.toRadians($lon2-$lon1)
		$a:=(This:C1470.pow(This:C1470.sin($dlat/2); 2))+(This:C1470.cos($lat1rad)*This:C1470.cos($lat2rad)*This:C1470.pow(This:C1470.sin($dlon/2); 2))
		$c:=2*This:C1470.atan2(This:C1470.sqrt($a); This:C1470.sqrt(1-$a))
		$result:=$Radius*$c
	Else 
		$result:=This:C1470.NaN
	End if 
	
	$0:=$result
	