//%attributes = {}
var $svg:=cs:C1710.svg.new()

$svg.definePattern("fill"; {\
width: 100; \
height: 100; \
x: 0; \
y: 0; \
viewBox: [0; 0; 10; 10]})

If ($svg.with("fill"))
	
	$svg.path()\
		.moveTo([0; 0])\
		.lineTo([7; 0])\
		.lineTo([3.5; 7])\
		.closePath()\
		.fill("lightgreen")\
		.stroke("olivedrab")\
		.closePattern()
	
End if 

// Using pattern for filling
$svg.ellipse(350; 150).cx(400).cy(200).stroke(5).stroke("olive").pattern("fill")


$svg.definePattern("fillAndStroke"; {\
width: 80; \
height: 80; \
x: 0; \
y: 0; \
viewBox: [0; 0; 20; 20]})

If ($svg.with("fillAndStroke"))
	
	$svg.rect(20).stroke("white").fill("sandybrown").closePattern()
	
End if 

// Using pattern for filling and outline
$svg.ellipse(350; 150).cx(400).cy(200).pattern("fillAndStroke").pattern("fillAndStroke"; True:C214).translate(100; 200)

$svg.preview()
