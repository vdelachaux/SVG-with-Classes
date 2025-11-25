// Calculate the pattern index
var $width; $height : Real
OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)

$width:=$width/5
$height:=$height/4

var $column : Integer:=MOUSEX\$width  // Column 0..4
var $row : Integer:=MOUSEY\$height  // Line 0..3

Form:C1466.index:=$row*5+$column+1  // Conversion to index 1..20
CALL SUBFORM CONTAINER:C1086(-1)