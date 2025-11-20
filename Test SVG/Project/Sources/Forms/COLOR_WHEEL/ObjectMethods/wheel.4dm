var $cx : Integer:=Num:C11(Form:C1466.cx)
var $cy : Integer:=Num:C11(Form:C1466.cy)

// Vector from center
var $dx:=MOUSEX-$cx
var $dy:=MOUSEY-$cy

// Distance (magnitude)
var $d : Real:=Square root:C539(($dx^2)+($dy^2))

// Normalized radial position (0 = center, 1 = circle boundary)
var $R : Integer:=Num:C11(Form:C1466.radius)
var $radialPos : Real:=$R=0 ? 0 : $d/$R

// Optional clamp (force radialPos ≤ 1)
If ($radialPos>1)
	
	$radialPos:=1
	
End if 

// --- Base angle in [0, π/2] ---
If ($dx=0)
	
	If ($dy>0)
		
		var $angle0 : Real:=Pi:K30:1/2
		
	Else 
		
		$angle0:=$dy<0 ? -Pi:K30:1/2 : 0  // Dx=0 and dy=0, undefined angle
		
	End if 
	
Else 
	
	$angle0:=Arctan:C20(Abs:C99($dy/$dx))
	
End if 

// --- Quadrant correction using ternary operators with line continuation ---
var $rad : Integer:=$dx>0 ? \
($dy>=0 ? $angle0/*Q1*/: -$angle0/*Q4*/) : \
($dx<0 ? \
($dy>=0 ? Pi:K30:1-$angle0/*Q2*/: -Pi:K30:1+$angle0/*Q3*/) : \
0/*dx=0 handled above*/)

// Convert to [0, 2π) if needed
If ($rad<0)
	
	$rad+=(2*Pi:K30:1)
	
End if 

// Compute circle coordinates (point on circumference)
var $xCircle : Real:=$cx+$R*Cos:C18($rad)
var $yCircle : Real:=$cy+$R*Sin:C17($rad)

// Build result
Form:C1466.color:={\
dx: $dx; \
dy: $dy; \
d: $d; \
radialPos: $radialPos; \
thetaRad: $rad; \
thetaDeg: ($rad*180)/Pi:K30:1; \
xCircle: $xCircle; \
yCircle: $yCircle\
}

CALL SUBFORM CONTAINER:C1086(-1)