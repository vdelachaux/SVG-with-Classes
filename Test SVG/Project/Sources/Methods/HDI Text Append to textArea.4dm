//%attributes = {}
var $svg:=cs:C1710.svgx.svg.new()

// Display outlines using 'rect' element
$svg.rect(500; 200).position(10; 10).stroke("blue")

// Creating the text
$svg.textArea("It is today, ")\
.position(10; 30)\
.width(500)\
.height(200)\
.fontFamily("Arial")\
.fontSize(36)\
.alignment(Align center:K42:3)

// Adding the date and 2 CR
$svg.appendText(String:C10(Current date:C33)+"\r\r")

// Lastly, adding the current time
$svg.appendText("and it was exactly "+String:C10(Current time:C178))

$svg.preview()