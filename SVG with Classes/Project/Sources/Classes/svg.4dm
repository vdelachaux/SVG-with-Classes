Class extends xml

/* Structural element
The structural elements are those which define the primary structure of an SVG document. S
pecifically, the following elements are structural elements: 
*/
property _structural:=[\
"defs"; \
"g"; \
"svg"; \
"symbol"; \
"use"\
]

/* Structurally external element
Elements that define its structure by reference to an external resource. 
Specifically, the following elements are structurally external elements when they have an ‘href’ attribute:
*/
property _structurallyExternal:=[\
"audio"; \
"foreignObject"; \
"iframe"; \
"image"; \
"script"; \
"use"; \
"video"\
]

/* Graphics element
One of the element types that can cause graphics to be drawn onto the target canvas. 
Specifically:
*/
property _graphic:=[\
"audio"; \
"canvas"; \
"circle"; \
"ellipse"; \
"foreignObject"; \
"iframe"; \
"image"; \
"line"; \
"path"; \
"polygon"; \
"polyline"; \
"rect"; \
"text"; \
"textArea"; \
"textPath"; \
"tspan"; \
"video"\
]

/* Graphics referencing element
A graphics element which uses a reference to a different document or element as the source of its graphical content.
Specifically:
*/
property _graphicReferencing:=[\
"audio"; \
"iframe"; \
"image"; \
"line"; \
"use"; \
"video"\
]

/* Container element
An element which can have graphics elements and other container elements as child elements.
Specifically:
*/
property _container:=[\
"a"; \
"clipPath"; \
"defs"; \
"g"; \
"marker"; \
"mask"; \
"pattern"; \
"svg"; \
"switch"; \
"symbol"]

// Elements that should not be considered as containers, and for which we need to move up one level.
property _notContainer:=[\
"circle"; \
"ellipse"; \
"image"; \
"line"; \
"path"; \
"polygon"; \
"polyline"; \
"rect"; \
"use"; \
"text"; \
"tspan"; \
"textArea"]

// Graphics element that is defined by some combination of straight lines and curves.
property _shapes:=[\
"circle"; \
"ellipse"; \
"line"; \
"path"; \
"polygon"; \
"polyline"; \
"rect"]

// Elements that provide additional descriptive information about their parent.
property _descriptive:=[\
"desc"; \
"metadata"; \
"title"]

// Note: renderable also includes a ‘symbol’ if used
property _renderable:=[\
"a"; \
"audio"; \
"canvas"; \
"circle"; \
"ellipse"; \
"foreignObject"; \
"g"; \
"iframe"; \
"image"; \
"line"; \
"path"; \
"polygon"; \
"polyline"; \
"rect"; \
"svg"; \
"switch"; \
"text"; \
"textArea"; \
"textPath"; \
"tspan"; \
"unknown"; \
"use"; \
"video"\
]

// Note: neverRendered also includes a ‘symbol’ if not used
property _neverRendered:=[\
"clipPath"; \
"defs"; \
"desc"; \
"linearGardient"; \
"marker"; \
"mask"; \
"metadata"; \
"pattern"; \
"radialGradient"; \
"script"; \
"style"; \
"title"\
]

// Valid aspect-ratio values
property _aspectRatioValues:=[\
"none"; \
"xMinYMin"; \
"xMidYMin"; \
"xMaxYMin"; \
"xMinYMid"; \
"xMidYMid"; \
"xMaxYMid"; \
"xMinYMax"; \
"xMidYMax"; \
"xMaxYMax"]

// Valid text-rendering values
property _textRenderingValue:=[\
"auto"; \
"optimizeSpeed"; \
"optimizeLegibility"; \
"geometricPrecision"; \
"inherit"]

// Reserved names
property _reservedNames:=[\
"root"; \
"latest"; \
"parent"; \
"none"; \
"defs"; \
"symbol"]

property store:=[]

property latest; _current; _filterTarget : Text
property graphic : Picture

property TAU:=Pi:K30:1*2  // Angle of a complete circle
property stackTransformation:=True:C214  // Stacks text-to-text transformations

//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
// ⚠️ Overrides the method of the inherited class
Function _reset
	
	Super:C1706._reset()
	
	This:C1470.latest:=""
	This:C1470.graphic:=Null:C1517
	This:C1470.store:=[]
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
	// Returns the cursor position
	// (the ID or reference of the current target element)
Function get cursor() : Text
	
	var $current:=This:C1470._getTarget()
	
	var $o : Object:=This:C1470.store.query("dom=:1"; $current).first()
	
	return $o#Null:C1517 ? $o.id : $current
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
	// Sets the cursor position using its ID or reference
	// (this will be the target element for subsequent function calls)
Function set cursor($current : Text)
	
	var $o : Object:=This:C1470.store.query("id=:1"; $current).first()
	
	If ($o#Null:C1517)
		
		This:C1470.latest:=$o.dom
		
	Else 
		
		If (This:C1470.isReference($current))
			
			This:C1470.latest:=$current
			
		Else 
			
			// ERROR 
			
		End if 
	End if 
	
	//MARK:-
Class constructor($content)
	
	Super:C1705($content)
	
	If ($content=Null:C1517)
		
		This:C1470.newCanvas()  // Create an empty canvas
		
	Else 
		
		If (This:C1470.root#Null:C1517)
			
			This:C1470.store.push({name: "root"; dom: This:C1470.root})
			
		End if 
	End if 
	
	This:C1470[""]:={absolute: True:C214}
	
	This:C1470._reservedNames:=This:C1470._reservedNames.combine(This:C1470._aspectRatioValues)
	This:C1470._reservedNames:=This:C1470._reservedNames.combine(This:C1470._textRenderingValue)
	
	//MARK:-DOCUMENTS & STRUCTURE
	//———————————————————————————————————————————————————————————
	// Close the current tree if any & create a new svg default structure.
Function newCanvas($attributes : Object) : cs:C1710.svg
	
	This:C1470._reset()
	
	Super:C1706.newRef("svg"; "http://www.w3.org/2000/svg")
	
	If (This:C1470.success)
		
		This:C1470.store.push({id: "root"; dom: This:C1470.root})
		
		Super:C1706.setDeclaration("UTF-8"; True:C214)
		Super:C1706.setOption(XML indentation:K45:34; Is compiled mode:C492 ? XML no indentation:K45:36 : XML with indentation:K45:35)
		Super:C1706.setAttribute(This:C1470.root; "xmlns:xlink"; "http://www.w3.org/1999/xlink")
		Super:C1706.setAttribute(This:C1470.root; "xmlns:vdl"; "https://github.com/vdelachaux/SVG-with-Classes")
		
		If (This:C1470.success)
			
			// Default values
			Super:C1706.setAttributes(This:C1470.root; New object:C1471(\
				"viewport-fill"; "none"; \
				"fill"; "none"; \
				"stroke"; "black"; \
				"font-family"; "'lucida grande','segoe UI',sans-serif"; \
				"font-size"; 12; \
				"text-rendering"; "geometricPrecision"; \
				"shape-rendering"; "crispEdges"; \
				"preserveAspectRatio"; "none"))
			
			This:C1470.success:=Bool:C1537(OK)
			
		End if 
	End if 
	
	If (This:C1470.success)
		
		If ($attributes#Null:C1517)
			
			var $t : Text
			For each ($t; $attributes)
				
				Case of 
						
						// _______________________
					: ($t="keepReference")
						
						This:C1470.autoClose:=Bool:C1537($attributes[$t])
						
						// _______________________
					Else 
						
						Super:C1706.setAttribute(This:C1470.root; $t; $attributes[$t])
						
						// ______________________
				End case 
			End for each 
		End if 
		
	Else 
		
		This:C1470._pushError("Failed to create SVG structure.")
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Returns the picture described by the SVG structure
Function picture($exportType; $keepStructure : Boolean) : Picture
	
	var $picture : Picture
	
	Case of 
			
			// ______________________________________________________
		: (Count parameters:C259>=2)  // $exportType & $keepStructure
			
			SVG EXPORT TO PICTURE:C1017(This:C1470.root; $picture; Num:C11($exportType))
			
			If (This:C1470.autoClose)\
				 && (Not:C34($keepStructure))
				
				Super:C1706.close()
				
			End if 
			
			// ______________________________________________________
		: (Count parameters:C259>=1)  // $exportType | $keepStructure
			
			If (Value type:C1509($exportType)=Is boolean:K8:9)  // $keepStructure
				
				SVG EXPORT TO PICTURE:C1017(This:C1470.root; $picture; Copy XML data source:K45:17)
				
				If (This:C1470.autoClose)\
					 && (Not:C34($exportType))
					
					Super:C1706.close()
					
				End if 
				
			Else   // $exportType
				
				SVG EXPORT TO PICTURE:C1017(This:C1470.root; $picture; Num:C11($exportType))
				
				If ($exportType#Own XML data source:K45:18)\
					 && (This:C1470.autoClose)
					
					Super:C1706.close()
					
				End if 
			End if 
			
			// ______________________________________________________
		Else 
			
			SVG EXPORT TO PICTURE:C1017(This:C1470.root; $picture; Copy XML data source:K45:17)
			
			If (This:C1470.autoClose)
				
				Super:C1706.close()
				
			End if 
			
			// ______________________________________________________
	End case 
	
	If (Picture size:C356($picture)>0)
		
		This:C1470.graphic:=$picture
		
		return $picture
		
	Else 
		
		This:C1470._pushError("Failed to convert SVG structure as picture.")
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Writes the content of the SVG tree into a disk file
Function exportText($file : 4D:C1709.File; $keepStructure : Boolean) : cs:C1710.svg
	
	Super:C1706.save($file; $keepStructure)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Writes the contents of the SVG tree into a picture file
Function exportPicture($file : 4D:C1709.File; $keepStructure : Boolean) : cs:C1710.svg
	
	var $picture : Picture:=This:C1470.picture($keepStructure)
	
	If (This:C1470.success)
		
		WRITE PICTURE FILE:C680($file.platformPath; $picture; $file.extension)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Returns the SVG picture encoded in Base64 (useful for Data URLs).
	// ⚠️ Does not free the XML tree from memory
Function exportToBase64($withDataPrefix : Boolean) : Text
	
	var $base64 : Text
	var $picture : Picture:=This:C1470.picture(True:C214)
	
	If (This:C1470.success)
		
		var $x : Blob
		PICTURE TO BLOB:C692($picture; $x; ".svg")
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	If (This:C1470.success)
		
		BASE64 ENCODE:C895($x; $base64; *)
		
	End if 
	
	CLEAR VARIABLE:C89($x)
	
	If ($withDataPrefix)
		
		$base64:="data:image/svg+xml;base64,"+$base64
		
	End if 
	
	return $base64
	
	//———————————————————————————————————————————————————————————
Function group($id : Text; $attachTo) : cs:C1710.svg
	
	If (Count parameters:C259=1)
		
		If (This:C1470.isReference($id))\
			 || (This:C1470.store.query("id = :1"; $id).first()#Null:C1517)  // .group(attachTo)
			
			$attachTo:=$id
			$id:=""
			
		End if 
	End if 
	
	If (Length:C16($attachTo)>0)
		
		This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "g")
		
	Else 
		
		If (This:C1470.latest=Null:C1517) || (This:C1470.latest="")
			
			var $node:=This:C1470.root
			
		Else 
			
			$node:=This:C1470.latest
			var $name:=This:C1470.getName($node)
			
			While (This:C1470._notContainer.includes($name))
				
				$node:=This:C1470.parent($node)
				$name:=This:C1470.getName($node)
				
			End while 
		End if 
		
		This:C1470.latest:=Super:C1706.create($node; "g")
		
	End if 
	
	This:C1470.setID($id)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Store the last created (or passed) element as symbol
Function symbol($id : Text; $applyTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return 
		
	End if 
	
	var $defs:=This:C1470._defs()
	
	If (Not:C34(This:C1470.success))
		
		return This:C1470
		
	End if 
	
	var $node : Text:=Super:C1706.create($defs; "symbol"; {id: $id; preserveAspectRatio: "xMidYMid"})
	
	If (This:C1470.success)
		
		This:C1470.store.push({id: $id; dom: $node})
		
		var $source : Text:=This:C1470._getTarget($applyTo)
		
		If (This:C1470.isReference($source))\
			 && ($source#This:C1470.root)
			
			$node:=Super:C1706.clone($source; $node)
			This:C1470.remove($source)
			This:C1470.restoreRoot()
			
		Else 
			
			This:C1470.latest:=$node
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Define or set a marker
Function marker($id : Text; $applyTo; $options : Object) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return 
		
	End if 
	
	If (Count parameters:C259=1)\
		 || (["start"; "mid"; "end"].includes($applyTo))\
		 || (This:C1470.store.query("id = :1"; $id).first()#Null:C1517)\
		 || ($id="none")
		
		// MARK: Set a marker to an element
/*
The marker-start and marker-end properties are used to specify the marker that will be drawn 
at the first and last vertices of the given shape, respectively. 
marker-mid is used to specify the marker that will be drawn at all other vertices
		
The value "none" indicates that no marker symbol will be drawn at the given vertex or vertices.
*/
		
		Case of 
				
				//______________________________________________________
			: ($applyTo="start")
				
				Super:C1706.setAttribute(This:C1470.latest; "marker-start"; "url(#"+$id+")")
				
				//______________________________________________________
			: ($applyTo="mid")
				
				Super:C1706.setAttribute(This:C1470.latest; "marker-mid"; "url(#"+$id+")")
				
				//______________________________________________________
			: ($applyTo="end")
				
				Super:C1706.setAttribute(This:C1470.latest; "marker-end"; "url(#"+$id+")")
				
				//______________________________________________________
			Else 
				
/*
The marker property sets values for the marker-start, marker-mid and marker-end properties. 
The value of the marker is used directly for all three of the corresponding longhand properties.
*/
				
				Super:C1706.setAttribute(This:C1470.latest; "marker"; "url(#"+$id+")")
				
				//______________________________________________________
		End case 
		
		return This:C1470
		
	End if 
	
	// MARK: Store the last created (or passed) element as marker
	var $defs:=This:C1470._defs()
	
	If (Not:C34(This:C1470.success))
		
		return This:C1470
		
	End if 
	
	var $node : Text:=Super:C1706.create($defs; "marker"; {id: $id; markerUnits: "userSpaceOnUse"; orient: "auto"})
	
	If (This:C1470.success)
		
		This:C1470.store.push({id: $id; dom: $node})
		
		If ($options#Null:C1517)
			
/* {
    width:real (markerWidth),
    height:real (markerHeight),
    refX:real,
    refY:real,
    markerUnits:Text, (default = userSpaceOnUse)
    viewBox:Text,
    orient:Text (default = auto)
}
*/
			
			// The ‘markerWidth’ and ‘markerHeight’ attributes represent the size of the viewport into which the marker is to be fitted
			// If markerHeight is not provided, we assume it is a square
			var $width:=Num:C11($options.width)
			var $heigth : Real:=$options.height#Null:C1517 ? Num:C11($options.height) : $width  // Default is a square
			
			If ($heigth#0)
				
				Super:C1706.setAttribute($node; "markerHeight"; $heigth)
				Super:C1706.setAttribute($node; "markerWidth"; $width)
				
			End if 
			
			// The ‘refX’ and ‘refY’ attributes define the reference point of the marker.
			// We use the center of the marker by default.
			var $refX:=Num:C11($options.refX)
			$refX:=Num:C11($refX#0 ? $refX : Try($width/2))
			var $refY : Real:=$options.refY#Null:C1517 ? Num:C11($options.refY) : $refX
			
			Super:C1706.setAttribute($node; "refX"; $refX)
			Super:C1706.setAttribute($node; "refY"; $refY)
			
			OB REMOVE:C1226($options; "width")
			OB REMOVE:C1226($options; "height")
			OB REMOVE:C1226($options; "refX")
			OB REMOVE:C1226($options; "refY")
			
			If (Not:C34(OB Is empty:C1297($options)))
				
				Super:C1706.setAttributes($node; $options)
				
			End if 
		End if 
		
		var $source : Text:=This:C1470._getTarget($applyTo)
		
		If (This:C1470.isReference($source))
			
			$node:=Super:C1706.clone($source; $node)
			This:C1470.remove($source)
			This:C1470.restoreRoot()
			
		Else 
			
			This:C1470.latest:=$node
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	//Define or set a clipPath
Function clipPath($id : Text; $applyTo) : cs:C1710.svg
	
	$id:=Length:C16($id)>0 ? $id : Generate UUID:C1066
	
	If (This:C1470.store.query("id = :1"; $id).first()#Null:C1517)
		
		// MARK: Set a clipPath to an element
		Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "clip-path"; "url(#"+$id+")")
		
		return This:C1470
		
	End if 
	
	// MARK: Store the last created (or passed) element as a clipPath
	var $defs:=This:C1470._defs()
	
	If (Not:C34(This:C1470.success))
		
		return This:C1470
		
	End if 
	
	var $node:=Super:C1706.create($defs; "clipPath"; {id: $id; preserveAspectRatio: "xMidYMid"})
	
	If (This:C1470.success)
		
		This:C1470.store.push({id: $id; dom: $node})
		
		var $source : Text
		
		If ($applyTo#"root")
			
			$source:=This:C1470._getTarget($applyTo)
			
		End if 
		
		If (This:C1470.isReference($source))
			
			$node:=Super:C1706.clone($source; $node)
			This:C1470.remove($source)
			This:C1470.restoreRoot()
			
			If (Count parameters:C259=2)
				
				Super:C1706.setAttribute($node; "clip-path"; "url(#"+$id+")")
				
			End if 
			
		Else 
			
			If ($applyTo="root")
				
				Super:C1706.setAttribute(This:C1470.root; "clip-path"; "url(#"+$id+")")
				
			End if 
			
			This:C1470.latest:=$node
			
		End if 
	End if 
	
	This:C1470.restoreRoot()
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Define a linear gradient
Function linearGradient($id : Text; $startColor : Text; $stopColor : Text; $options : Object) : Text/*  gradient reference */
	
	$startColor:=$startColor || "white"
	$stopColor:=$stopColor || "black"
	$options:=$options || {}
	
	var $defs:=This:C1470._defs()
	
	If (Not:C34(This:C1470.success))
		
		return 
		
	End if 
	
	var $ref:=Super:C1706.create($defs; "linearGradient"; {id: $id})
	
	If (This:C1470.success)
		
		// Gradient vecteur
		var $rotation : Integer:=Num:C11($options.rotation)
		
		Case of 
				
				// …………………………………………………………………………………………
			: ($rotation=0)
				
				// Nothing to do
				
				// …………………………………………………………………………………………
			: ($rotation=-45)
				
				Super:C1706.setAttributes($ref; {x1: 1; y1: 1; x2: 0; y2: 0})
				
				// …………………………………………………………………………………………
			: ($rotation=45)
				
				Super:C1706.setAttributes($ref; {x1: 0; y1: 0; x2: 1; y2: 1})
				
				// …………………………………………………………………………………………
			: ($rotation=90)
				
				Super:C1706.setAttributes($ref; {x1: 0; y1: 0; x2: 0; y2: 1})
				
				// …………………………………………………………………………………………
			: ($rotation=-90)
				
				Super:C1706.setAttributes($ref; {x1: 0; y1: 1; x2: 0; y2: 0})
				
				// …………………………………………………………………………………………
			: ($rotation=180)
				
				Super:C1706.setAttributes($ref; {x1: 0; y1: 0; x2: 1; y2: 0})
				
				// …………………………………………………………………………………………
			: ($rotation=-180)
				
				Super:C1706.setAttributes($ref; {x1: 1; y1: 0; x2: 0; y2: 0})
				
				// …………………………………………………………………………………………
			Else 
				
				Super:C1706.setAttributes($ref; "gradientTransform"; "rotate("+String:C10($rotation)+")")
				
				// …………………………………………………………………………………………
		End case 
		
		// • spreadMethod
		var $t:=String:C10($options.spreadMethod)
		
		If (Length:C16($t)>0)\
			 && (["pad"; "reflect"; "repeat"].includes($t))
			
			Super:C1706.setAttribute($ref; "spreadMethod"; $t)
			
		End if 
		
		// • color-interpolation
		$t:=String:C10($options["color-interpolation"])
		
		If (Length:C16($t)>0)\
			 && (["auto"; "sRGB"; "linearRGB"].includes($t))
			
			Super:C1706.setAttributes($ref; "color-interpolation"; $t)
			
		End if 
		
		// .x1, .y1, .x2, .y2
		If ($options.x1#Null:C1517)\
			 || ($options.x2#Null:C1517)\
			 || ($options.y1#Null:C1517)\
			 || ($options.y2#Null:C1517)
			
			For each ($t; ["x1"; "x2"; "y1"; "y2"])
				
				var $r : Real:=Num:C11($options[$t])
				$r:=$r>=1 ? $r/100 : $r
				
				Case of 
						
						// ______________________________________________________
					: ($r=0)
						
						// Nothing to do
						
						// ______________________________________________________
					: ($r<=1)  // Percent
						
						Super:C1706.setAttribute($ref; $t; String:C10($r*100)+"%")
						
						// ______________________________________________________
					Else 
						
						Super:C1706.setAttribute($ref; $t; $r)
						
						// ______________________________________________________
				End case 
			End for each 
		End if 
		
		// Start color: .startOffset & .startOpacity
		$r:=This:C1470._num2Percent(Num:C11($options.startOffset))
		
		var $stop:=Super:C1706.create($ref; "stop")
		Super:C1706.setAttribute($stop; "offset"; String:C10(Int:C8($r))+"%")
		Super:C1706.setAttribute($stop; "stop-color"; $startColor)
		
		If ($options.startOpacity#Null:C1517)
			
			Super:C1706.setAttribute($stop; "stop-opacity"; Num:C11($options.startOpacity))
			
		End if 
		
		// Stop color: .stopOffset & .stopOpacity
		$r:=This:C1470._num2Percent(Num:C11($options.stopOffset))
		$r:=$r=0 ? 100 : $r
		
		$stop:=Super:C1706.create($ref; "stop")
		Super:C1706.setAttribute($stop; "offset"; String:C10(Int:C8($r))+"%")
		Super:C1706.setAttribute($stop; "stop-color"; $stopColor || "none")
		
		If ($options.stopOpacity#Null:C1517)
			
			Super:C1706.setAttribute($stop; "stop-opacity"; Num:C11($options.stopOpacity))
			
		End if 
	End if 
	
	This:C1470.restoreRoot()
	
	return $ref
	
	//———————————————————————————————————————————————————————————
	// Define a linear gradient
Function radialGradient($id : Text; $startColor : Text; $stopColor : Text; $options : Object) : Text/*  gradient reference */
	
	$startColor:=($startColor#"url(@" ? Lowercase:C14($startColor) : $startColor) || "white"
	$stopColor:=($stopColor#"url(@" ? Lowercase:C14($stopColor) : $stopColor) || "black"
	$options:=$options || {}
	
	var $defs:=This:C1470._defs()
	
	If (Not:C34(This:C1470.success))
		
		return 
		
	End if 
	
	var $ref:=Super:C1706.create($defs; "radialGradient"; {id: $id})
	
	If (This:C1470.success)
		
		var $o:={offset: "0%"}
		$o["stop-color"]:=$startColor
		
		If ($options.startOpacity#Null:C1517)
			
			$o["stop-opacity"]:=Num:C11($options.startOpacity)
			
		End if 
		
		Super:C1706.create($ref; "stop"; $o)
		
		$o:={offset: "100%"}
		$o["stop-color"]:=$stopColor
		
		If ($options.stopOpacity#Null:C1517)
			
			$o["stop-opacity"]:=Num:C11($options.stopOpacity)
			
		End if 
		
		Super:C1706.create($ref; "stop"; $o)
		
		CLEAR VARIABLE:C89($o)
		
		var $t : Text
		For each ($t; ["cx"; "cy"; "r"; "fx"; "fy"; "spreadMethod"])
			
			If ($options[$t]=Null:C1517)
				
				continue
				
			End if 
			
			$o:=$o || {}
			
			If ($t="r")
				
				var $r : Real:=Num:C11($options[$t])
				$r:=$r>=1 ? $r/100 : $r
				
				If ($r<=1)  // Percent
					
					$o[$t]:=String:C10($r*100)+"%"
					
				Else 
					
					$o[$t]:=String:C10($r; "###%")
					
				End if 
				
			Else 
				
				$o[$t]:=String:C10($options[$t]; "###%")
				
			End if 
		End for each 
		
		If ($o#Null:C1517)
			
			This:C1470.setAttributes($ref; $o)
			
		End if 
	End if 
	
	return $ref
	
	//———————————————————————————————————————————————————————————
	// Place an occurence of the symbol
Function use($symbol; $attachTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return 
		
	End if 
	
	If (This:C1470.isNotNull(This:C1470.findById($symbol)))
		
		This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "use")
		
		If (This:C1470.success)
			
			Super:C1706.setAttribute(This:C1470.latest; "xlink:href"; $symbol)
			
		End if 
		
	Else 
		
		This:C1470._pushError("The id \""+$symbol+"\" doesn't exist!")
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Import the svg content of a file
Function import($file : 4D:C1709.File; $applyTo) : cs:C1710.svg
	
	var $xml:=cs:C1710.xml.new($file)
	
	If (This:C1470.success)
		
		var $node:=$xml.findByXPath("/svg")
		
		If (This:C1470.success)
			
			// The import is performed in a group that automatically takes the file name as its ID.
			var $group : Text:=This:C1470.group(This:C1470._getContainer($applyTo)).setID($file.name).latest
			
			// Define the attributes of the group with those of the original document
			Super:C1706.setAttributes($group; Super:C1706.getAttributes($node))
			
			// Retrieve all elements and clone them in the current canvas
			For each ($node; $xml.childrens($node))
				
				Super:C1706.append($group; $node)
				
			End for each 
		End if 
		
		$xml.close()
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Assigns a built-in style to an element or creates a root style element 
Function style($style : Text; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getContainer($applyTo)
	
	If ($node=This:C1470.root)
		
		// Create an internal CSS style sheet
		$node:=Super:C1706.create(This:C1470.root; "style"; {type: "text/css"})
		Super:C1706.setValue($node; $style; True:C214)
		
	Else 
		
		// Assigns a built-in style to an element
		Super:C1706.setAttribute(This:C1470.latest; "style"; $style)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Attach a style sheet file
Function styleSheet($file : 4D:C1709.File) : cs:C1710.svg
	
	If (Not:C34($file.exists))
		
		This:C1470._pushError("File not found: "+$file.path)
		return 
		
	End if 
	
	var $t:="xml-stylesheet href=\"file:///"+Convert path system to POSIX:C1106($file.platformPath; *)+"\" type=\"text/css\""
	$t:=DOM Append XML child node:C1080(DOM Get XML document ref:C1088(This:C1470.root); XML processing instruction:K45:9; $t)
	This:C1470.success:=Bool:C1537(OK)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Create, if any, & set the document 'title' element
Function title($title : Text) : cs:C1710.svg
	
	return Super:C1706.setValue(This:C1470.findOrCreate(This:C1470.root; "title"); $title)
	
	//———————————————————————————————————————————————————————————
	// Create, if any, & set the document 'desc' element
Function desc($description : Text) : cs:C1710.svg
	
	return Super:C1706.setValue(This:C1470.findOrCreate(This:C1470.root; "desc"); $description)
	
	//———————————————————————————————————————————————————————————
	// Append a comment element
Function comment($comment : Text; $attachTo) : cs:C1710.svg
	
	Super:C1706.comment(Count parameters:C259>=2 ? This:C1470._getContainer($attachTo) : This:C1470.root; $comment)
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Define a pattern container
Function pattern($id : Text; $options : Object) : Text/* Pattern reference */
	
	$options:=$options || {}
	
	var $defs:=This:C1470._defs()
	
	If (Not:C34(This:C1470.success))
		
		return 
		
	End if 
	
	var $ref:=Super:C1706.create($defs; "pattern"; {\
		id: $id; \
		patternUnits: String:C10($options.patternUnits) || "userSpaceOnUse"})
	
	If (This:C1470.success)
		
		This:C1470.store.push({id: $id; dom: $ref})
		
		var $t : Text
		var $o : Object
		For each ($t; ["width"; "height"; "x"; "y"; "viewBox"; "patternTransform"])
			
			If ($options[$t]=Null:C1517)
				
				continue
				
			End if 
			
			$o:=$o || {}
			
			Case of 
					
					//______________________________________________________
				: ($t="viewBox")
					
					If (Value type:C1509($options[$t])=Is collection:K8:32)
						
						$o[$t]:=$options[$t].join(" ")
						
					Else 
						
						$o[$t]:=$options[$t]
						
					End if 
					
					//______________________________________________________
				: ($t="patternTransform")
					
					$o[$t]:=String:C10($options[$t])
					
					//______________________________________________________
				Else 
					
					$o[$t]:=String:C10(Num:C11($options[$t]); "&xml")
					
					//______________________________________________________
			End case 
		End for each 
		
		If ($o#Null:C1517)
			
			Super:C1706.setAttributes($ref; $o)
			
		End if 
	End if 
	
	return $ref
	
	//———————————————————————————————————————————————————————————
	// Define a 'solidColor' element that provides a single color with opacity.
	// It can be referenced like the other paint servers (i.e. gradients).
Function solidColor($id : Text; $color : Text; $opacity : Real) : cs:C1710.svg
	
	var $defs:=This:C1470._defs()
	
	If (Not:C34(This:C1470.success))
		
		return 
		
	End if 
	
	var $ref:=Super:C1706.create($defs; "solidColor"; {id: $id})
	Super:C1706.setAttribute($ref; "solid-color"; $color)
	
	If (Count parameters:C259>=3)
		
		Super:C1706.setAttribute($ref; "solid-opacity"; This:C1470._num2Percent($opacity)/100)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets a new filter in the SVG container and returns its reference
	// If the filter already exists, it will be replaced.
Function defineFilter($id : Text; $options : Object) : Text/* Filter reference */
	
	$options:=$options || {}
	
/*
{    
  x = Coordinate on X axis
  y = Coordinate on Y axis
  width = Width of target rectangle
  height = Height of target rectangle
  filterUnits = Coordinate system of frame "userSpaceOnUse" | "objectBoundingBox"
  primitiveUnits = Filter system of values "userSpaceOnUse" | "objectBoundingBox"
}
*/
	
	$options.id:=$id
	
	var $node:=This:C1470.findById($id)
	
	If (This:C1470.isNotNull($node))  // A new definition replaces the old one, where applicable.
		
		Super:C1706.remove($node)
		
	End if 
	
	return Super:C1706.create(This:C1470._defs(); "filter"; $options)
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// Given a real number between >=0 and <=1, return an integer between >=0 and <=100.
Function _num2Percent($value : Real) : Integer
	
	$value:=$value<0 ? 0 : $value
	$value:=$value<=1 ? $value*100 : $value
	
	return $value>100 ? 100 : $value
	
	//MARK:-DRAWING
	//———————————————————————————————————————————————————————————
	// Defines the following coordinates as absolute 
Function absolute() : cs:C1710.svg
	
	This:C1470[""].absolute:=True:C214
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Defines the following coordinates as relative
Function relative() : cs:C1710.svg
	
	This:C1470[""].absolute:=False:C215
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function rect($width; $height; $attachTo) : cs:C1710.svg
	
	var $paramNumber:=Count parameters:C259
	
	If (Not:C34(This:C1470._requiredParams($paramNumber; 1)))
		
		return 
		
	End if 
	
	var $breadth:=$width  // Square by default
	
	Case of 
			
			//…………………………………………………………………………………………
		: ($paramNumber=1)  // .rect(width)
			
			var $node:=This:C1470._getContainer()
			
			//…………………………………………………………………………………………
		: ($paramNumber=2)
			
			If (Value type:C1509($height)=Is real:K8:4)\
				 | (Value type:C1509($width)=Is longint:K8:6)  // .rect(width; height)
				
				$breadth:=Num:C11($height)
				$node:=This:C1470._getContainer()
				
			Else   // .rect(width; attachTo)
				
				$node:=This:C1470._getContainer($height)
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=3)  // .rect(width; height; attachTo)
			
			$node:=This:C1470._getContainer($attachTo)
			$breadth:=Num:C11($height)
			
			//…………………………………………………………………………………………
	End case 
	
	This:C1470.latest:=Super:C1706.create($node; "rect"; {width: $width; height: $breadth})
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function circle($r : Real; $cx; $cy; $attachTo) : cs:C1710.svg
	
	var $paramNumber:=Count parameters:C259
	
	If (Not:C34(This:C1470._requiredParams($paramNumber; 1)))
		
		return 
		
	End if 
	
	Case of 
			
			//…………………………………………………………………………………………
		: ($paramNumber=1)  // .circle(r)
			
			var $node:=This:C1470._getContainer()
			
			//…………………………………………………………………………………………
		: ($paramNumber=2)
			
			If (Value type:C1509($cx)=Is real:K8:4)\
				 | (Value type:C1509($cx)=Is longint:K8:6)  // .circle(r; cx)
				
				$node:=This:C1470._getContainer()
				
			Else   // .circle(r; attachTo)
				
				$node:=This:C1470._getContainer($cx)
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=3)
			
			If (Value type:C1509($cy)=Is real:K8:4)\
				 | (Value type:C1509($cy)=Is longint:K8:6)  // .circle(r; cx; cy)
				
				$node:=This:C1470._getContainer()
				
			Else   // .circle(r; cx; attachTo)
				
				$node:=This:C1470._getContainer($cy)
				$cy:=$cx
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=4)  // .circle(r; cx; cy; attachTo)
			
			$node:=This:C1470._getContainer($attachTo)
			
			//…………………………………………………………………………………………
	End case 
	
	This:C1470.latest:=Super:C1706.create($node; "circle"; {r: $r; cx: $cx; cy: $cy})
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function ellipse($rx : Real; $ry : Real; $cx : Real; $cy : Real; $attachTo) : cs:C1710.svg
	
	var $paramNumber:=Count parameters:C259
	
	If (Not:C34(This:C1470._requiredParams($paramNumber; 1)))
		
		return 
		
	End if 
	
	Case of 
			
			//…………………………………………………………………………………………
		: ($paramNumber=1)
			
			$ry:=$rx  // Circle 😇
			var $node:=This:C1470._getContainer()
			
			//…………………………………………………………………………………………
		: ($paramNumber=2)
			
			If (Value type:C1509($ry)=Is real:K8:4)\
				 | (Value type:C1509($ry)=Is longint:K8:6)
				
				$node:=This:C1470._getContainer()
				
			Else 
				
				$ry:=$rx  // Circle 😇
				$node:=This:C1470._getContainer($ry)
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=3)
			
			If (Value type:C1509($cx)=Is real:K8:4)\
				 | (Value type:C1509($cx)=Is longint:K8:6)
				$node:=This:C1470._getContainer()
				
			Else 
				
				$node:=This:C1470._getContainer($cy)
				
			End if 
			
			$cy:=$cx
			
			//…………………………………………………………………………………………
		: ($paramNumber=4)
			
			$cy:=$cx
			
			If (Value type:C1509($cy)=Is real:K8:4)\
				 | (Value type:C1509($cy)=Is longint:K8:6)
				
				$node:=This:C1470._getContainer()
				
			Else 
				
				$node:=This:C1470._getContainer($cy)
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=5)
			
			$node:=This:C1470._getContainer($attachTo)
			
			//…………………………………………………………………………………………
	End case 
	
	This:C1470.latest:=Super:C1706.create($node; "ellipse"; {cx: $cx; cy: $cy; rx: $rx; ry: $ry})
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function boundedEllipse($x : Real; $y : Real; $width : Real; $height : Real; $attachTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 4)))
		
		return 
		
	End if 
	
	var $rx:=$width\2
	var $ry:=$height\2
	
	This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "ellipse"; {\
		cx: $x+$rx; \
		cy: $y+$ry; \
		rx: $rx; \
		ry: $ry})
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function line($x1 : Real; $y1 : Real; $x2 : Real; $y2 : Real; $attachTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 2)))
		
		return 
		
	End if 
	
	This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "line"; {\
		x1: $x1; \
		y1: $y1; \
		x2: $x2; \
		y2: $y2})
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function image($picture; $attachTo) : cs:C1710.svg
	
	var $paramNumber:=Count parameters:C259
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return 
		
	End if 
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($picture)=Is picture:K8:10)  // Embed the image
			
			This:C1470.success:=Picture size:C356($picture)>0
			
			If (This:C1470.success)
				
				// Priority order of the codecs contained in the picture:
				// svg > png > jpg > first one
				ARRAY TEXT:C222($codecs; 0x0000)
				GET PICTURE FORMATS:C1406($picture; $codecs)
				
				var $codec:=Size of array:C274($codecs)>0 ? $codecs{1} : ""
				
				var $t : Text
				For each ($t; [\
					".svg"; \
					".png"; \
					".jpeg"])
					
					var $index:=Find in array:C230($codecs; $t)
					
					If ($index>0)
						
						$codec:=$codecs{$index}
						break
						
					End if 
				End for each 
				
				Case of 
						
						// ………………………………………………………………………………… Some cases requiring special handling
					: ($codec=\
						/* Proprietary 4D format (several types of codecs) */".4DMetaPict") || \
						/* Digital Negative */($codec=".dng") || \
						/* file.getIcon() on Windows */($codec=".4DMemoryBitmap")
						
						CONVERT PICTURE:C1002($picture; ".png")
						TRANSFORM PICTURE:C988($picture; Transparency:K61:11; 0x00FFFFFF)
						$codec:=".png"
						
						// …………………………………………………………………………………
				End case 
				
				$codec:=$codec || ".png"  // Finally, the default format is PNG
				
				// Encode the image
				var $x : Blob
				PICTURE TO BLOB:C692($picture; $x; $codec)
				This:C1470.success:=Bool:C1537(OK)
				
				If (This:C1470.success)
					
					BASE64 ENCODE:C895($x; $t; *)
					CLEAR VARIABLE:C89($x)
					
					var $height; $width : Integer
					PICTURE PROPERTIES:C457($picture; $width; $height)
					$codec:=$codec=".svg" ? "svg+xml" : Replace string:C233($codec; "."; "")
					
					This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "image"; New object:C1471(\
						"xlink:href"; "data:image/"+$codec+";base64,"+$t; \
						"x"; 0; \
						"y"; 0; \
						"width"; $width; \
						"height"; $height))
					
				End if 
				
				CLEAR VARIABLE:C89($picture)
				
			Else 
				
				This:C1470._pushError("Given picture is empty")
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($picture)=Is object:K8:27)\
			 && (OB Instance of:C1731($picture; 4D:C1709.File))  // Create a link to a file
			
			This:C1470.success:=$picture.exists
			
			If (This:C1470.success)
				
				// Unsandboxed, if any
				$picture:=File:C1566(File:C1566($picture.path; *).platformPath; fk platform path:K87:2)
				
				var $p : Picture
				READ PICTURE FILE:C678($picture.platformPath; $p)
				
				This:C1470.success:=Bool:C1537(OK)
				
				If (This:C1470.success)
					
					PICTURE PROPERTIES:C457($p; $width; $height)
					CLEAR VARIABLE:C89($p)
					
					This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "image"; New object:C1471(\
						"xlink:href"; (Is Windows:C1573 ? "file:///" : "file://")+Replace string:C233($picture.path; " "; "%20"); \
						"x"; 0; \
						"y"; 0; \
						"width"; $width; \
						"height"; $height))
					
					If (Not:C34(This:C1470.success))
						
						This:C1470._pushError("Failed to create image \""+String:C10($picture.path)+"\"")
						
					End if 
					
				Else 
					
					This:C1470._pushError("Failed to read image \""+String:C10($picture.path)+"\"")
					
				End if 
				
			Else 
				
				This:C1470._pushError("File not found \""+String:C10($picture.path)+"\"")
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($picture)=Is text:K8:3)  // Relative URLs
			
			var $url:=String:C10($picture)
			
			Case of 
					
					// ______________________________________________________
				: ($url="http@")  // A non-local URL
					
					// <NOTHING MORE TO DO>
					
					// ______________________________________________________
				: ($url="../@")  // base is the database's folder
					
					$url:=Delete string:C232($url; 1; 3)
					var $path:=Folder:C1567("/PACKAGE"; *).platformPath+Replace string:C233($url; "/"; Folder separator:K24:12)
					$url:="../../"+$url
					
					// ______________________________________________________
				: ($url="/@")  // base is the "Resources/SVG" folder
					
					// Be sure the folder SVG is present in the folder Resources
					var $folder:=Folder:C1567("/RESOURCES/SVG"; *)
					$folder.create()
					
					$url:=Delete string:C232($url; 1; 1)
					$path:=$folder.platformPath+Replace string:C233($url; "/"; Folder separator:K24:12)
					
					// ______________________________________________________
				: ($url="./@")  // base is the "Resources" folder
					
					$url:=Delete string:C232($url; 1; 2)
					$path:=Folder:C1567("/RESOURCES"; *).platformPath+Replace string:C233($url; "/"; Folder separator:K24:12)
					$url:="../"+$url
					
					// ______________________________________________________
				Else   // fallback : "Resources/SVG" folder
					
					Folder:C1567("/RESOURCES/SVG"; *).create()
					$path:=Folder:C1567("/RESOURCES/SVG"; *).platformPath+Replace string:C233($url; "/"; Folder separator:K24:12)
					
					// ______________________________________________________
			End case 
			
			
			If ($url#"http@")
				
				If (Not:C34(File:C1566($path; fk platform path:K87:2).exists))
					
					This:C1470._pushError("File not found :"+$path)
					return 
					
				End if 
				
				// Get width & height of the picture
				READ PICTURE FILE:C678($path; $picture)
				
				If (Bool:C1537(OK))
					
					PICTURE PROPERTIES:C457($picture; $width; $height)
					$picture:=$picture*0
					
				End if 
				
				
				This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "image"; New object:C1471(\
					"xlink:href"; Replace string:C233($url; " "; "%20"); \
					"x"; 0; \
					"y"; 0; \
					"width"; $width; \
					"height"; $height))
			Else 
				
				This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "image"; New object:C1471(\
					"xlink:href"; Replace string:C233($url; " "; "%20"); \
					"x"; 0; \
					"y"; 0))
				
			End if 
			
			If (Not:C34(This:C1470.success))
				
				This:C1470._pushError("Failed to create image \""+$url+"\"")
				
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("Picture must be a picture variable, a picture file or a relative URL")
			
			//______________________________________________________
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function text($text : Text; $attachTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return 
		
	End if 
	
	var $node:=This:C1470._getContainer($attachTo)
	var $o:={x: 0; y: "1em"}
	
	This:C1470.latest:=Super:C1706.create($node; "text"; $o)
	
	If (This:C1470.success)\
		 & (Length:C16($text)>0)
		
		If (Match regex:C1019("(?mi-s)<span[^>]*>"; $text; 1)) & False:C215
			
			$text:=Replace string:C233($text; "<SPAN"; "<tspan")
			$text:=Replace string:C233($text; "</SPAN>"; "</tspan>")
			$text:=Replace string:C233($text; "STYLE="; "style=")
			$text:=Replace string:C233($text; "color:"; "fill:")
			$text:=Replace string:C233($text; "<BR/>"; "\r")
			
			var $pattern:="(?m-is)<tspan[^>]*style=\"font-size:(\\d+)[^>]*>"
			
			// TODO: 🚧 Text multi-style
			
			//Repeat 
			//$Lon_x:=Position("\r"; $Txt_text)
			//If ($Lon_x>0)
			//$Txt_Buffer:=Substring($Txt_text; 1; $Lon_x-1)
			//$Txt_text:=Delete string($Txt_text; 1; Length($Txt_Buffer)+1)
			////#ACI0093774
			////$Txt_Span:=DOM Create XML element($Dom_svgReference;"tspan";"x";$Num_x)
			//If (OK=1)
			//ARRAY TEXT($tTxt_results; 0x0000)
			//$Lon_lineFontSize:=$Lon_Font_Size  //default
			//If (Rgx_ExtractText($Txt_pattern; $Txt_Buffer; ""; ->$tTxt_results; 0)=0)
			//For ($Lon_i; 1; Size of array($tTxt_results); 1)
			//If (Num($tTxt_results{$Lon_i})>$Lon_lineFontSize)
			//$Lon_lineFontSize:=Num($tTxt_results{$Lon_i})
			//End if 
			//End for 
			//End if 
			//$Num_y:=$Num_y+$Lon_lineFontSize+Choose($Lon_count>0; $Num_interlining*8; 0)
			////#ACI0093774
			////DOM SET XML ATTRIBUTE($Txt_Span;"y";$Num_y)
			////DOM SET XML ELEMENT VALUE($Txt_Span;$Txt_Buffer)
			////#ACI0096676 {
			////$Lon_error:=Rgx_SubstituteText ("(?mi-s)^<tspan ([^>]*>)";"<tspan x=\""+String($Num_x)+"\" y=\""+String($Num_y)+"\" \\1";->$Txt_Buffer)
			//If ($Txt_Buffer#"<tspan@")
			//$Txt_Buffer:="<tspan>"+$Txt_Buffer+"</tspan>"
			//End if 
			//$Lon_error:=Rgx_SubstituteText("(?mi-s)^<tspan([^>]*>)"; "<tspan x=\""+String($Num_x)+"\" y=\""+String($Num_y)+"\" \\1"; ->$Txt_Buffer)
			////}
			//$Dom_buffer:=DOM Append XML child node($Dom_svgReference; XML ELEMENT; $Txt_Buffer)
			//End if 
			//$Lon_Count:=$Lon_Count+1
			//Else 
			//If ($Lon_Count=0)
			//DOM SET XML ELEMENT VALUE($Dom_svgReference; $Txt_text)
			//Else 
			//ARRAY TEXT($tTxt_results; 0x0000)
			//$Lon_lineFontSize:=$Lon_Font_Size  //default
			//If (Rgx_ExtractText($Txt_pattern; $Txt_text; ""; ->$tTxt_results; 0)=0)
			//For ($Lon_i; 1; Size of array($tTxt_results); 1)
			//If (Num($tTxt_results{$Lon_i})>$Lon_lineFontSize)
			//$Lon_lineFontSize:=Num($tTxt_results{$Lon_i})
			//End if 
			//End for 
			//End if 
			//$Num_y:=$Num_y+$Lon_lineFontSize+Choose($Lon_count>0; $Num_interlining*8; 0)
			////#ACI0093774
			////$Txt_Span:=DOM Create XML element($Dom_svgReference;"tspan";"x";$Num_x;"y";$Num_y)
			////If (OK=1)
			////DOM SET XML ELEMENT VALUE($Txt_Span;$Txt_text)
			////End if
			////#ACI0096676 {
			////$Lon_error:=Rgx_SubstituteText ("(?mi-s)^<tspan ([^>]*>)";"<tspan x=\""+String($Num_x)+"\" y=\""+String($Num_y)+"\" \\1";->$Txt_text)
			//If ($Txt_Buffer#"<tspan@")
			//$Txt_Buffer:="<tspan>"+$Txt_Buffer+"</tspan>"
			//End if 
			//$Lon_error:=Rgx_SubstituteText("(?mi-s)^<tspan([^>]*>)"; "<tspan x=\""+String($Num_x)+"\" y=\""+String($Num_y)+"\" \\1"; ->$Txt_Buffer)
			////}
			//$Dom_buffer:=DOM Append XML child node($Dom_svgReference; XML ELEMENT; $Txt_text)
			//End if 
			//End if 
			//Until ($Lon_x=0) | (OK=0)
			
		Else 
			
			$text:=Replace string:C233($text; "\r\n"; "\n")
			$text:=Replace string:C233($text; "\n"; "\r")
			
			var $c:=Split string:C1554($text; "\r")
			
			If ($c.length=1)
				
				This:C1470.setValue($text)
				
			Else 
				
				var $line : Text
				For each ($line; $c) While (This:C1470.success)
					
					If ($line#$c[0])
						
						// Keep x, remove y
						OB REMOVE:C1226($o; "y")
						
						// Set dy
						$o.dy:="1em"
						
					End if 
					
					$node:=Super:C1706.create(This:C1470.latest; "tspan"; $o)
					Super:C1706.setValue($node; $line)
					
				End for each 
			End if 
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function dx($value; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "dx"; $value)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function dy($value; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "dy"; $value)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function tspan($text : Text; $attachTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($attachTo)
	
	If (This:C1470.getName($node)#"text")
		
		$node:=This:C1470.parent($node; "text")
		
	End if 
	
	If (This:C1470.success)
		
		This:C1470.latest:=Super:C1706.create($node; "tspan")
		Super:C1706.setValue(This:C1470.latest; $text)
		
	Else 
		
		This:C1470._pushError("“tspan” requires a parent “text” element to be displayed.")
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function textArea($text : Text; $attachTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return 
		
	End if 
	
	var $o:={\
		x: 0; \
		y: 0; \
		width: "auto"; \
		height: "auto"}
	
	var $node:=This:C1470._getContainer($attachTo)
	
	This:C1470.latest:=Super:C1706.create($node; "textArea"; $o)
	
	If (This:C1470.success)\
		 & (Length:C16($text)>0)
		
		$text:=Replace string:C233($text; "\r\n"; "\n")
		$text:=Replace string:C233($text; "\n"; "\r")
		
		var $i : Integer
		var $line : Text
		For each ($line; Split string:C1554($text; "\r")) While (This:C1470.success)
			
			If ($i=0)
				
				This:C1470.setValue($line)
				
			Else 
				
				$node:=DOM Create XML element:C865(This:C1470.latest; "tbreak")
				This:C1470.success:=Bool:C1537(OK)
				
				If (This:C1470.success)\
					 & (Length:C16($line)>0)
					
					$node:=DOM Append XML child node:C1080(This:C1470.latest; XML DATA:K45:12; $line)
					This:C1470.success:=Bool:C1537(OK)
					
				End if 
			End if 
			
			$i+=1
			
		End for each 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Append text to a text Area
	// TODO: Documentation
Function appendText($text : Text; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getContainer($applyTo)
	
	If (This:C1470.getName($node)#"textarea")
		
		This:C1470._pushError(".appendText() can only be applied to a text area")
		return 
		
	End if 
	
	If (Length:C16($text)>0)
		
		$text:=Replace string:C233($text; "\r\n"; "\n")
		$text:=Replace string:C233($text; "\n"; "\r")
		
		var $i : Integer
		var $line : Text
		For each ($line; Split string:C1554($text; "\r")) While (This:C1470.success)
			
			If ($i>0)
				
				$node:=DOM Create XML element:C865(This:C1470.latest; "tbreak")
				This:C1470.success:=Bool:C1537(OK)
				
			End if 
			
			If (This:C1470.success)\
				 & (Length:C16($line)>0)
				
				$node:=DOM Append XML child node:C1080(This:C1470.latest; XML DATA:K45:12; $line)
				This:C1470.success:=Bool:C1537(OK)
				
			End if 
			
			$i+=1
			
		End for each 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Creates a set of connected straight line segments,
	// generally resulting in an open shape usually without fill
Function polyline($points : Variant; $attachTo) : cs:C1710.svg
	
	This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "polyline"; {fill: "none"})
	
	If (This:C1470.success)\
		 && (Count parameters:C259>=1)
		
		This:C1470.plot($points; This:C1470.latest)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Defines a closed shape consisting of connected lines.
Function polygon($points : Variant; $attachTo) : cs:C1710.svg
	
	This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "polygon")
	
	If (This:C1470.success)\
		 && (Count parameters:C259>=1)
		
		This:C1470.plot($points; This:C1470.latest)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Populate the "points" property of a polyline, polygon
Function points($points : Variant; $applyTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return 
		
	End if 
	
	var $node:=This:C1470._getTarget($applyTo)
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
		: (Not:C34(["polyline"; "polygon"].includes($name)))
			
			This:C1470._pushError("The element \""+$name+"\" is not compatible withe \"points\" property")
			return 
			
			//______________________________________________________
		: (Value type:C1509($points)=Is collection:K8:32)
			
			var $i : Integer
			For ($i; 0; $points.length-1; 1)
				
				$points[$i]:=$points[$i].join(",")
				
			End for 
			
			var $data : Text:=$points.join(" ")
			
			//______________________________________________________
		: (Value type:C1509($points)=Is text:K8:3)
			
			$data:=$points
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("Points must be passed as string or collection")
			return 
			
			//______________________________________________________
	End case 
	
	Super:C1706.setAttribute($node; "points"; $data)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Defines a new path element.
Function path($data : Text; $attachTo) : cs:C1710.svg
	
	// TODO: Accept other data formats (Collection, …)
	
	If (Count parameters:C259=1)\
		 && (This:C1470._isReference($data))  // .path(attachTo)
		
		$data:=""
		
	End if 
	
	This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); "path")
	This:C1470.setAttribute("d"; $data; This:C1470.latest)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Populate the "d" property of a path
Function d($data : Text; $applyTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return This:C1470
		
	End if 
	
	var $node:=This:C1470._getTarget($applyTo)
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	If ($name#"path")
		
		This:C1470._pushError("The element \""+$name+"\" is not compatible with \"points\" property")
		
		return 
		
	End if 
	
	Super:C1706.setAttribute($node; "d"; $data)
	
	return This:C1470
	
	//mark:-
	//———————————————————————————————————————————————————————————
	// Start a new sub-path at the given point [x,y] coordinate
Function moveTo($point : Collection; $applyTo) : cs:C1710.svg
	
	If (This:C1470[""].absolute)
		
		return This:C1470.M($point; $applyTo)
		
	Else 
		
		return This:C1470.m($point; $applyTo)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Absolute moveTo
Function M($points : Variant; $applyTo) : cs:C1710.svg
	
	return This:C1470._moveTo(Copy parameters:C1790; True:C214)
	
	//———————————————————————————————————————————————————————————
	// Relative moveTo
Function m($points : Variant; $applyTo) : cs:C1710.svg
	
	return This:C1470._moveTo(Copy parameters:C1790)
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _moveTo($parameters : Collection; $absolute : Boolean) : cs:C1710.svg
	
	var $node:=$parameters.length=2 ? This:C1470._getContainer($parameters[1]) : This:C1470._getContainer()
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return This:C1470
		
	End if 
	
	var $points : Variant:=$parameters[0]
	
	Case of 
			//______________________________________________________
		: (Value type:C1509($points)=Is collection:K8:32)
			
			var $data:=String:C10($points[0]; "&xml")+","+String:C10($points[1]; "&xml")
			
			//______________________________________________________
		: (Value type:C1509($points)=Is text:K8:3)
			
			$data:=$points
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("Points must be passed as string or collection")
			return This:C1470
			
			//______________________________________________________
	End case 
	
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
			//…………………………………………………………………………………………………
		: ($name="polyline")\
			 | ($name="polygon")
			
			Super:C1706.setAttribute($node; "points"; $data)
			
			//…………………………………………………………………………………………………
		: ($name="path")
			
			Super:C1706.setAttribute($node; "d"; Super:C1706.getAttribute($node; "d")+($absolute ? " M" : " m")+$data)
			
			//…………………………………………………………………………………………………
		Else 
			
			This:C1470._pushError("The element \""+$name+"\" is not compatible with \""+($absolute ? " M" : " m")+"\" property")
			
			//…………………………………………………………………………………………………
	End case 
	
	return This:C1470
	
	//mark:-
	//———————————————————————————————————————————————————————————
	// Draw a line from the current point to the given point [x,y] coordinate which becomes the new current point
	// A number of coordinates pairs may be specified to draw a polyline
Function lineTo($point : Collection; $applyTo) : cs:C1710.svg
	
	If (This:C1470[""].absolute)
		
		return This:C1470.L($point; $applyTo)
		
	Else 
		
		return This:C1470.l($point; $applyTo)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Absolute lineTo
Function L($points; $applyTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return 
		
	End if 
	
	Case of 
			//______________________________________________________
		: (Value type:C1509($points)=Is collection:K8:32)
			
			If ($points.length%2=0)
				
				var $c:=[]
				var $i : Integer
				For ($i; 0; $points.length-1; 2)
					
					$c.push(String:C10($points[$i]; "&xml")+" "+String:C10($points[$i+1]; "&xml"))
					
				End for 
				
				var $data : Text:=$c.join(" ")
				
			Else 
				
				This:C1470._pushError("The length of the point collection must be a multiple of 2")
				return This:C1470
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($points)=Is text:K8:3)
			
			$data:=$points
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("Points must be passed as string or collection")
			return This:C1470
			
			//______________________________________________________
	End case 
	
	var $node:=This:C1470._getTarget($applyTo)
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
			//…………………………………………………………………………………………………
		: ($name="polyline")\
			 | ($name="polygon")
			
			Super:C1706.setAttribute($node; "points"; String:C10(This:C1470.getAttribute($node; "points"))+" "+$data)
			
			//…………………………………………………………………………………………………
		: ($name="path")
			
			Super:C1706.setAttribute($node; "d"; Super:C1706.getAttribute($node; "d")+" L"+$data)
			
			//…………………………………………………………………………………………………
		Else 
			
			This:C1470._pushError("The element \""+$name+"\" is not compatible with \"points\" property")
			
			//…………………………………………………………………………………………………
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Relative lineTo
Function l($points; $applyTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return 
		
	End if 
	
	Case of 
			//______________________________________________________
		: (Value type:C1509($points)=Is collection:K8:32)
			
			If ($points.length%2=0)
				
				var $c:=[]
				var $i : Integer
				For ($i; 0; $points.length-1; 2)
					
					$c.push(String:C10($points[$i]; "&xml")+" "+String:C10($points[$i+1]; "&xml"))
					
				End for 
				
				var $data : Text:=$c.join(" ")
				
			Else 
				
				This:C1470._pushError("The length of the point collection must be a multiple of 2")
				return This:C1470
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($points)=Is text:K8:3)
			
			$data:=$points
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("Points must be passed as string or collection")
			return This:C1470
			
			//______________________________________________________
	End case 
	
	var $node:=This:C1470._getTarget($applyTo)
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
			//…………………………………………………………………………………………………
		: ($name="polyline")\
			 | ($name="polygon")
			
			Super:C1706.setAttribute($node; "points"; String:C10(This:C1470.getAttribute($node; "points"))+" "+$data)
			
			//…………………………………………………………………………………………………
		: ($name="path")
			
			Super:C1706.setAttribute($node; "d"; Super:C1706.getAttribute($node; "d")+" l"+$data)
			
			//…………………………………………………………………………………………………
		Else 
			
			This:C1470._pushError("The element \""+$name+"\" is not compatible with \"points\" property")
			
			//…………………………………………………………………………………………………
	End case 
	
	return This:C1470
	
	//mark:-
	//———————————————————————————————————————————————————————————
	// Draws an horizontal line from the current point (cpx, cpy) to (x, cpy)
Function horizontalLineto($x : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470[""].absolute)
		
		return This:C1470.H($x; $applyTo)
		
	Else 
		
		return This:C1470.h($x; $applyTo)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Absolute horizontal lineTo
Function H($x : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._lineTo(False:C215; Copy parameters:C1790; True:C214)
	
	//———————————————————————————————————————————————————————————
	// Relative horizontal lineTo
Function h($x : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._lineTo(False:C215; Copy parameters:C1790)
	
	//mark:-
	//———————————————————————————————————————————————————————————
	// Draws a vertical line from the current point (cpx, cpy) to (cpx, y)
Function verticalLineto($y : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470[""].absolute)
		
		return This:C1470.V($y; $applyTo)
		
	Else 
		
		return This:C1470.v($y; $applyTo)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Absolute vertical lineTo
Function V($x : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._lineTo(True:C214; Copy parameters:C1790; True:C214)
	
	//———————————————————————————————————————————————————————————
	// Relative vertical lineTo
Function v($x : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._lineTo(True:C214; Copy parameters:C1790)
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _lineTo($vertical : Boolean; $parameters : Collection; $absolute : Boolean) : cs:C1710.svg
	
	var $node:=$parameters.length=2 ? This:C1470._getContainer($parameters[1]) : This:C1470._getContainer()
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	If ($name#"path")
		
		This:C1470._pushError("The element \""+$name+"\" is not compatible with \""+($absolute ? "V" : "v")+"\" property")
		return This:C1470
		
	End if 
	
	var $c:=This:C1470._data($node)
	
	If (This:C1470.success)
		
		$c.push(($vertical ? ($absolute ? "V" : "v") : ($absolute ? "H" : "h"))+String:C10($parameters[0]; "&xml"))
		
		Super:C1706.setAttribute($node; "d"; $c.join(" "))
		
	End if 
	
	return This:C1470
	
	//mark:-
	//———————————————————————————————————————————————————————————
	// Draws an elliptical arc from the current point to [x, y]
	// The size and orientation of the ellipse are defined by one radius or two radii [rx, ry] and an x-axis-rotation
	// The center of the ellipse is calculated automatically to satisfy the constraints imposed by the other parameters.
	// flags [large-arc-flag and sweep-flag] contribute to the automatic calculations and help determine how the arc is drawn.
Function arc($to : Collection; $radii; $axis : Real; $flags : Collection; $applyTo) : cs:C1710.svg
	
	If (Value type:C1509($radii)=Is real:K8:4) | (Value type:C1509($radii)=Is longint:K8:6)
		
		$radii:=[$radii; $radii]
		
	End if 
	
	If (This:C1470[""].absolute)
		
		return This:C1470.A($radii[0]; $radii[1]; $axis; $flags[0]; $flags[1]; $to[0]; $to[1]; $applyTo)
		
	Else 
		
		return This:C1470.a($radii[0]; $radii[1]; $axis; $flags[0]; $flags[1]; $to[0]; $to[1]; $applyTo)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Absolute elliptical arc
Function A($rx : Real; $ry : Real; $rotation : Real; $largeArcFlag : Integer; $sweepFlag : Integer; $x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._ellipticalArc(Copy parameters:C1790; True:C214)
	
	//———————————————————————————————————————————————————————————
	// Relative elliptical arc
Function a($rx : Real; $ry : Real; $rotation : Real; $largeArcFlag : Integer; $sweepFlag : Integer; $x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._ellipticalArc(Copy parameters:C1790)
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _ellipticalArc($parameters : Collection; $absolute : Boolean) : cs:C1710.svg
	
	var $node:=$parameters.length=8 ? This:C1470._getContainer($parameters[7]) : This:C1470._getContainer()
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	If ($name#"path")
		
		This:C1470._pushError("The element \""+$name+"\" is not compatible with \""+($absolute ? "A" : "a")+"\" property")
		return This:C1470
		
	End if 
	
	var $c : Collection:=This:C1470._data($node)
	
	If (This:C1470.success)
		
		$c.push(($absolute ? "A" : "a")+String:C10($parameters[0]; "&xml")+","+String:C10($parameters[1]; "&xml"))
		$c.push(String:C10($parameters[2]; "&xml"))
		$c.push(String:C10($parameters[3])+","+String:C10($parameters[4]))
		$c.push(String:C10($parameters[5]; "&xml")+","+String:C10($parameters[6]; "&xml"))
		
		Super:C1706.setAttribute($node; "d"; $c.join(" "))
		
	End if 
	
	return This:C1470
	
	//mark:-
	//———————————————————————————————————————————————————————————
	// Draws a cubic Bézier curve from the current point to [x,y] using beginCtrlPoint [x1,y1] as the control point at the beginning of the curve
	// and endCtrlPoint [x2,y2] as the control point at the end of the curve
Function cubicBezierCurveto($to : Collection; $beginCtrlPoint : Collection; $endCtrlPoint : Collection; $applyTo) : cs:C1710.svg
	
	If (This:C1470[""].absolute)
		
		return This:C1470.C($beginCtrlPoint[0]; $beginCtrlPoint[1]; $endCtrlPoint[0]; $endCtrlPoint[1]; $to[0]; $to[1]; $applyTo)
		
	Else 
		
		return This:C1470.c($beginCtrlPoint[0]; $beginCtrlPoint[1]; $endCtrlPoint[0]; $endCtrlPoint[1]; $to[0]; $to[1]; $applyTo)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Absolute curvTo
Function C($x1 : Real; $y1 : Real; $x2 : Real; $y2 : Real; $x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._curveTo(Copy parameters:C1790; True:C214)
	
	//———————————————————————————————————————————————————————————
	// Relative curvTo
Function c($x1 : Real; $y1 : Real; $x2 : Real; $y2 : Real; $x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._curveTo(Copy parameters:C1790)
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _curveTo($parameters : Collection; $absolute : Boolean) : cs:C1710.svg
	
	var $node:=$parameters.length=7 ? This:C1470._getContainer($parameters[6]) : This:C1470._getContainer()
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	If ($name#"path")
		
		This:C1470._pushError("The element \""+$name+"\" is not compatible with \""+($absolute ? "C" : "c")+"\" property")
		return This:C1470
		
	End if 
	
	var $c:=This:C1470._data($node)
	
	If (This:C1470.success)
		
		$c.push(($absolute ? "C" : "c")+String:C10($parameters[0]; "&xml")+","+String:C10($parameters[1]; "&xml"))
		$c.push(String:C10($parameters[2]; "&xml")+","+String:C10($parameters[3]; "&xml"))
		$c.push(String:C10($parameters[4]; "&xml")+","+String:C10($parameters[5]; "&xml"))
		
		Super:C1706.setAttribute($node; "d"; $c.join(" "))
		
	End if 
	
	return This:C1470
	
	// MARK:-
	//———————————————————————————————————————————————————————————
	// Draws a cubic Bézier curve from the current point to [x,y]
Function smoothCubicBezierCurveto($to : Collection; $endCtrlPoint : Collection; $applyTo) : cs:C1710.svg
	
	If (This:C1470[""].absolute)
		
		return This:C1470.S($endCtrlPoint[0]; $endCtrlPoint[1]; $to[0]; $to[1]; $applyTo)
		
	Else 
		
		return This:C1470.c($endCtrlPoint[0]; $endCtrlPoint[1]; $to[0]; $to[1]; $applyTo)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Absolute shorthand/smooth curvTo
Function S($x2 : Real; $y2 : Real; $x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._smoothCurveTo(Copy parameters:C1790; True:C214)
	
	//———————————————————————————————————————————————————————————
	// Relative shorthand/smooth curvTo
Function s($x2 : Real; $y2 : Real; $x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._smoothCurveTo(Copy parameters:C1790)
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _smoothCurveTo($parameters : Collection; $absolute : Boolean) : cs:C1710.svg
	
	var $node:=$parameters.length=5 ? This:C1470._getContainer($parameters[4]) : This:C1470._getContainer()
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	If ($name#"path")
		
		This:C1470._pushError("The element \""+$name+"\" is not compatible with \""+($absolute ? "S" : "s")+"\" property")
		return This:C1470
		
	End if 
	
	var $c:=This:C1470._data($node)
	
	If (This:C1470.success)
		
		$c.push(($absolute ? "S" : "s")+String:C10($parameters[0]; "&xml")+","+String:C10($parameters[1]; "&xml"))
		$c.push(String:C10($parameters[2]; "&xml")+","+String:C10($parameters[3]; "&xml"))
		
		Super:C1706.setAttribute($node; "d"; $c.join(" "))
		
	End if 
	
	return This:C1470
	
	// MARK:-
	//———————————————————————————————————————————————————————————
	// Draws a quadratic Bézier curve from the current point to [x,y] using controlPoint [x1,y1] as the control point
Function quadraticBezierCurveto($to : Collection; $controlPoint : Collection; $applyTo) : cs:C1710.svg
	
	If (This:C1470[""].absolute)
		
		return This:C1470.Q($controlPoint[0]; $controlPoint[1]; $to[0]; $to[1]; $applyTo)
		
	Else 
		
		return This:C1470.q($controlPoint[0]; $controlPoint[1]; $to[0]; $to[1]; $applyTo)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Absolute quadratic Bézier curveto
Function Q($x1 : Real; $y1 : Real; $x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._quadraticCurveto(Copy parameters:C1790; True:C214)
	
	//———————————————————————————————————————————————————————————
	// Relative quadratic Bézier curveto
Function q($x1 : Real; $y1 : Real; $x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._quadraticCurveto(Copy parameters:C1790)
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _quadraticCurveto($parameters : Collection; $absolute : Boolean) : cs:C1710.svg
	
	var $node:=$parameters.length=5 ? This:C1470._getContainer($parameters[4]) : This:C1470._getContainer()
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	If ($name#"path")
		
		This:C1470._pushError("The element \""+$name+"\" is not compatible with \""+($absolute ? "Q" : "q")+"\" property")
		return This:C1470
		
	End if 
	
	var $c:=This:C1470._data($node)
	
	If (This:C1470.success)
		
		$c.push(($absolute ? "Q" : "q")+String:C10($parameters[0]; "&xml")+","+String:C10($parameters[1]; "&xml"))
		$c.push(String:C10($parameters[2]; "&xml")+","+String:C10($parameters[3]; "&xml"))
		
		Super:C1706.setAttribute($node; "d"; $c.join(" "))
		
	End if 
	
	return This:C1470
	
	// MARK:-
	//———————————————————————————————————————————————————————————
	// Draws a quadratic Bézier curve from the current point to [x,y]
Function smoothQuadraticBezierCurveto($to : Collection; $applyTo) : cs:C1710.svg
	
	If (This:C1470[""].absolute)
		
		return This:C1470.T($to[0]; $to[1]; $applyTo)
		
	Else 
		
		return This:C1470.t($to[0]; $to[1]; $applyTo)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Absolute shorthand/smooth quadratic Bézier curveto
Function T($x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._smoothQuadraticCurveto(Copy parameters:C1790; True:C214)
	
	//———————————————————————————————————————————————————————————
	// Relative shorthand/smooth quadratic Bézier curveto
Function t($x : Real; $y : Real; $applyTo) : cs:C1710.svg
	
	return This:C1470._smoothQuadraticCurveto(Copy parameters:C1790)
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _smoothQuadraticCurveto($parameters : Collection; $absolute : Boolean) : cs:C1710.svg
	
	var $node:=$parameters.length=3 ? This:C1470._getContainer($parameters[2]) : This:C1470._getContainer()
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	If ($name#"path")
		
		This:C1470._pushError("The element \""+$name+"\" is not compatible with \""+($absolute ? "T" : "t")+"\" property")
		return This:C1470
		
	End if 
	
	var $c:=This:C1470._data($node)
	
	If (This:C1470.success)
		
		$c.push(($absolute ? "T" : "t")+String:C10($parameters[0]; "&xml")+","+String:C10($parameters[1]; "&xml"))
		
		Super:C1706.setAttribute($node; "d"; $c.join(" "))
		
	End if 
	
	return This:C1470
	
	// MARK:-
	//———————————————————————————————————————————————————————————
	// Close the current subpath by drawing a straight line from the current point to current subpath's initial point
Function closePath($applyTo) : cs:C1710.svg
	
	return This:C1470.Z($applyTo)
	
	//———————————————————————————————————————————————————————————
	// Close path
Function Z($applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	If ($name="path")
		
		Super:C1706.setAttribute($node; "d"; Super:C1706.getAttribute($node; "d")+"Z")
		
	Else 
		
		This:C1470._pushError("The element \""+$name+"\" is not compatible with \"points\" property")
		
	End if 
	
	return This:C1470
	
	// MARK:- HIGH-LEVEL 
	//———————————————————————————————————————————————————————————
Function Square($side : Real; $attachTo) : cs:C1710.svg
	
	This:C1470.rect($side; $side; This:C1470._getContainer($attachTo))
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Draws a regular polygon with number of sides fit into a circle
Function RegularPolygon($diameter : Real; $sides : Integer; $cx : Real; $cy : Real) : cs:C1710.svg
	
	var $angle : Real
	
	var $r:=$diameter/2
	$cx:=Count parameters:C259>=3 ? $cx : $r+1
	$cy:=Count parameters:C259>=4 ? $cy : $cx
	
	var $c:=[]
	var $i : Integer
	For ($i; 1; $sides; 1)
		
		$angle:=(This:C1470.TAU/$sides)*$i
		$c.push([Round:C94($cx+($r*Cos:C18($angle)); 2); Round:C94($cy+($r*Sin:C17($angle)); 2)])
		
	End for 
	
	This:C1470.polygon($c)
	
	If (($sides%2)#0)
		
		This:C1470.rotate(-(360/$sides)/4; $cx; $cy; This:C1470.latest)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
/*
Draws a N pointed star fit into a circle (outerR; cx; cy)
If you want a more “pointed” star, decrease the ratio (Default is 0.5).
For a more “round” star, increase the ratio.
*/
Function Star($nBranches : Integer; $outerR : Real; $cx : Real; $cy : Real; $ratio : Real) : cs:C1710.svg
	
	$ratio:=$ratio#0 ? $ratio : 0.5
	var $innerR:=$outerR*$ratio
	
	var $nPoints:=2*$nBranches
	var $points:=[].resize($nPoints)
	
	// ---- Construction of the n points (n/2 exterior + n/2 interior) ----
	var $i : Integer
	For ($i; 0; $nPoints-1)
		
		var $angle:=This:C1470.TAU+($i*(This:C1470.TAU/$nPoints))-(Pi:K30:1/2)
		var $r : Real:=$i%2=0 ? $outerR : $innerR
		$points[$i]:=[Round:C94($cx+($r*Cos:C18($angle)); 2); Round:C94($cy+($r*Sin:C17($angle)); 2)]
		
	End for 
	
	return This:C1470.polygon($points)
	
	//———————————————————————————————————————————————————————————
	// Draws a five pointed star fit into a circle
Function FivePointStar($diameter : Real; $cx : Real; $cy : Real) : cs:C1710.svg
	
	This:C1470.Star(5; $diameter/2; $cx; $cy)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Draw an equilateral triangle inscribed in a circle defined by cx, cy, and r.
Function Triangle($cx : Real; $cy : Real; $r : Real; $rotation : Real) : cs:C1710.svg
	
	// Calculate the 3 vertices
	var $points:=[].resize(3)
	var $i : Integer
	For ($i; 0; 2)
		
		var $angle:=($rotation*This:C1470.TAU)+($i*(This:C1470.TAU/3))
		$points[$i]:=[$cx+($r*Cos:C18($angle)); $cy+($r*Sin:C17($angle))]
		
	End for 
	
	return This:C1470.polygon($points)
	
	// MARK:- ATTRIBUTES
	//———————————————————————————————————————————————————————————
	// ⚠️ Overrides the method of the inherited class
Function setAttribute($name : Text; $value : Variant; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); $name; $value)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// ⚠️ Overrides the method of the inherited class
Function setAttributes($attributes : Variant; $value : Variant; $applyTo) : cs:C1710.svg
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259=0)
			
			This:C1470._pushError("Missing parameter")
			
			//______________________________________________________
		: (Value type:C1509($attributes)=Is object:K8:27)
			
			Super:C1706.setAttributes(This:C1470._getTarget($value); OB Entries:C1720($attributes))
			
			//______________________________________________________
		: (Value type:C1509($attributes)=Is collection:K8:32)
			
			Super:C1706.setAttributes(This:C1470._getTarget($value); $attributes)
			
			//______________________________________________________
		: (Value type:C1509($attributes)=Is text:K8:3)
			
			If (Count parameters:C259=3)
				
				Super:C1706.setAttribute(This:C1470._getTarget($applyTo); $attributes; $value)
				
			Else 
				
				If (This:C1470.isReference($attributes))
					
					Super:C1706.setAttributes($attributes; $value)
					
				Else 
					
					Super:C1706.setAttributes(This:C1470._getTarget(); $attributes; $value)
					
				End if 
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470.success:=False:C215
			
			//______________________________________________________
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function viewbox($left; $top : Real; $width : Real; $height : Real; $applyTo) : cs:C1710.svg
	
	var $node:=Count parameters:C259>=5 ? This:C1470._getTarget($applyTo) : This:C1470._getTarget("root")
	
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	var $c:=["svg"; "symbol"; "marker"; "pattern"; "view"]
	
	If ($c.includes($name))
		
		If (Value type:C1509($left)=Is text:K8:3)
			
			$viewbox:=$left
			
		Else 
			
			var $viewbox:=String:C10(Num:C11($left); "&xml")+" "+String:C10($top; "&xml")+" "+String:C10($width; "&xml")+" "+String:C10($height; "&xml")
			
		End if 
		
		Super:C1706.setAttribute($node; "viewbox"; $viewbox)
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+": The element must be \""+$c.join("\", ")+"\"")
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function setID($id : Text; $applyTo) : cs:C1710.svg
	
	If (Length:C16($id)=0)
		
		return 
		
	End if 
	
	var $node:=DOM Find XML element by ID:C1010(This:C1470.root; $id)
	
	If (OK=0)
		
		If (This:C1470._reservedNames.indexOf($id)=-1)
			
			$node:=This:C1470._getTarget($applyTo)
			
			Super:C1706.setAttribute($node; "id"; $id)
			This:C1470.push($id)
			
		Else 
			
			This:C1470._pushError("\""+$id+"\" is a reserved name and can't be used as id!")
			
		End if 
		
	Else 
		
		This:C1470._pushError("The id \""+$id+"\" already exist!")
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets the x value
Function x($x : Real; $applyTo) : cs:C1710.svg
	
	If (Not:C34(This:C1470._requiredParams(Count parameters:C259; 1)))
		
		return This:C1470
		
	End if 
	
	var $node:=This:C1470._getTarget($applyTo)
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
			//______________________________________________________
		: ($name="text")
			
			Super:C1706.setAttribute($node; "x"; $x)
			
			// Apply to enclosed spans, if any
			var $spans:=This:C1470.find($node; "./tspan")
			
			If ($spans.length>0)
				
				For each ($node; $spans)
					
					Super:C1706.setAttribute($node; "x"; $x)
					
				End for each 
			End if 
			
			//______________________________________________________
		: ($name="rect")\
			 | ($name="image")\
			 | ($name="textArea")
			
			Super:C1706.setAttribute($node; "x"; $x)
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("cannot be fixed for the element \""+$name+"\"")
			
			//______________________________________________________
	End case 
	
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets the y value
Function y($y : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "y"; $y)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets the radius of a circle
Function r($r : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		var $node:=This:C1470._getTarget($applyTo)
		var $name : Text
		DOM GET XML ELEMENT NAME:C730($node; $name)
		
		If ($name="circle")
			
			Super:C1706.setAttribute($node; "r"; $r)
			
		Else 
			
			This:C1470._pushError("cannot be fixed for the element \""+$name+"\"")
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets the rx of a rect or an ellipse
Function rx($rx : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		var $node:=This:C1470._getTarget($applyTo)
		var $name : Text
		DOM GET XML ELEMENT NAME:C730($node; $name)
		
		If ($name="rect")\
			 | ($name="ellipse")
			
			Super:C1706.setAttribute($node; "rx"; $rx)
			
		Else 
			
			This:C1470._pushError("cannot be fixed for the element \""+$name+"\"")
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets the ry of an ellipse
Function ry($ry : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		var $node:=This:C1470._getTarget($applyTo)
		var $name : Text
		DOM GET XML ELEMENT NAME:C730($node; $name)
		
		If ($name="rect")\
			 | ($name="ellipse")
			
			Super:C1706.setAttribute($node; "ry"; $ry)
			
		Else 
			
			This:C1470._pushError("cannot be fixed for the element \""+$name+"\"")
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets the cx of a circle or ellipse
Function cx($cx : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		var $node:=This:C1470._getTarget($applyTo)
		var $name : Text
		DOM GET XML ELEMENT NAME:C730($node; $name)
		
		If ($name="circle")\
			 | ($name="ellipse")
			
			Super:C1706.setAttribute($node; "cx"; $cx)
			
		Else 
			
			This:C1470._pushError("cannot be fixed for the element \""+$name+"\"")
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets the cy of a circle or ellipse
Function cy($cy : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		var $node:=This:C1470._getTarget($applyTo)
		var $name : Text
		DOM GET XML ELEMENT NAME:C730($node; $name)
		
		If ($name="circle")\
			 | ($name="ellipse")
			
			Super:C1706.setAttribute($node; "cy"; $cy)
			
		Else 
			
			This:C1470._pushError("cannot be fixed for the element \""+$name+"\"")
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function width($width : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		// FIXME:Target specific treatment (line,…)
		
		var $node:=This:C1470._getTarget($applyTo)
		var $name:=This:C1470.getName($node)
		
		Case of 
				
				//______________________________________________________
			: ($name="marker")
				
				Super:C1706.setAttribute($node; "markerWidth"; $width)
				var $height:=Num:C11(Super:C1706.getAttribute($node; "markerHeight"))
				
				If ($height=0)
					
					Super:C1706.setAttribute($node; "markerHeight"; $width)
					
				End if 
				
				var $refX:=Num:C11(Super:C1706.getAttribute($node; "refX"))
				
				If ($refX=0)
					
					$refX:=Try($width/2)
					var $refY:=Num:C11(Super:C1706.getAttribute($node; "refY"))
					$refY:=$refY#0 ? $refY : $refX
					
					Super:C1706.setAttribute($node; "refX"; $refX)
					Super:C1706.setAttribute($node; "refY"; $refY)
					
				End if 
				
				//______________________________________________________
			Else 
				
				Super:C1706.setAttribute($node; "width"; $width)
				
				//______________________________________________________
		End case 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function height($height : Real; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		// FIXME:Target specific treatment (line,…)
		
		var $node:=This:C1470._getTarget($applyTo)
		var $name:=This:C1470.getName($node)
		
		Case of 
				
				//______________________________________________________
			: ($name="marker")
				
				Super:C1706.setAttribute($node; "markerHeight"; $height)
				
				var $width:=Num:C11(Super:C1706.getAttribute($node; "markerWidth"))
				
				If ($width=0)
					
					Super:C1706.setAttribute($node; "markerWidth"; $height)
					
				End if 
				
				var $refX:=Num:C11(Super:C1706.getAttribute($node; "refX"))
				
				If ($refX=0)
					
					$refX:=Try($height/2)
					var $refY:=Num:C11(Super:C1706.getAttribute($node; "refY"))
					$refY:=$refY#0 ? $refY : $refX
					
					Super:C1706.setAttribute($node; "refX"; $refX)
					Super:C1706.setAttribute($node; "refY"; $refY)
					
				End if 
				
				//______________________________________________________
			Else 
				
				Super:C1706.setAttribute($node; "height"; $height)
				
				//______________________________________________________
		End case 
	End if 
	
	return This:C1470
	
	// MARK:- TRANSLATE, ROTATE, & SCALE
	//———————————————————————————————————————————————————————————
Function translate($tx : Real; $ty; $applyTo) : cs:C1710.svg
	
	var $paramNumber:=Count parameters:C259
	
	If (Not:C34(This:C1470._requiredParams($paramNumber; 1)))
		
		return This:C1470
		
	End if 
	
	var $node:=This:C1470._getTarget($applyTo)
	
	If ($paramNumber>=2)
		
		If (Value type:C1509($ty)=Is real:K8:4)\
			 | (Value type:C1509($ty)=Is longint:K8:6)
			
			var $transform:="translate("+String:C10($tx; "&xml")+","+String:C10($ty; "&xml")+")"
			
		Else 
			
			$transform:="translate("+String:C10($tx; "&xml")+")"
			
		End if 
		
	Else 
		
		$transform:="translate("+String:C10($tx; "&xml")+")"
		
	End if 
	
	This:C1470.transform($node; $transform)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function rotate($deg : Integer; $cx : Variant; $cy : Real; $applyTo) : cs:C1710.svg
	
	var $paramNumber:=Count parameters:C259
	
	If (Not:C34(This:C1470._requiredParams($paramNumber; 1)))
		
		return This:C1470
		
	End if 
	
	Case of 
			
			//…………………………………………………………………………………………
		: ($paramNumber=1)  // Angle
			
			This:C1470.transform(This:C1470._getTarget(); This:C1470._rotate($deg))
			
			//…………………………………………………………………………………………
		: ($paramNumber=2)  // Angle + cx | ref
			
			If (Value type:C1509($cx)=Is real:K8:4)\
				 | (Value type:C1509($cx)=Is longint:K8:6)
				
				This:C1470.transform(This:C1470._getTarget(); This:C1470._rotate($deg; $cx))
				
			Else 
				
				This:C1470.transform(This:C1470._getTarget($cx); This:C1470._rotate($deg))
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=3)  // Angle + cx + cy | ref
			
			If (Value type:C1509($cy)=Is real:K8:4)\
				 | (Value type:C1509($cy)=Is longint:K8:6)
				
				This:C1470.transform(This:C1470._getTarget(); This:C1470._rotate($deg; $cx; $cy))
				
			Else 
				
				This:C1470.transform(This:C1470._getTarget($cy); This:C1470._rotate($deg; $cx))
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=4)  // Angle + cx + cy + ref
			
			This:C1470.transform(This:C1470._getTarget($applyTo); This:C1470._rotate($deg; $cx; $cy))
			
			//…………………………………………………………………………………………
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function rotateTAU($fraction : Real; $cx : Variant; $cy : Real; $applyTo) : cs:C1710.svg
	
	var $paramNumber:=Count parameters:C259
	
	If (Not:C34(This:C1470._requiredParams($paramNumber; 1)))
		
		return This:C1470
		
	End if 
	
	var $deg:=$fraction*360
	
	Case of 
			
			//…………………………………………………………………………………………
		: ($paramNumber=1)  // Fraction
			
			This:C1470.transform(This:C1470._getTarget(); This:C1470._rotate($deg))
			
			//…………………………………………………………………………………………
		: ($paramNumber=2)  // Fraction + cx | ref
			
			If (Value type:C1509($cx)=Is real:K8:4)\
				 | (Value type:C1509($cx)=Is longint:K8:6)
				
				This:C1470.transform(This:C1470._getTarget(); This:C1470._rotate($deg; $cx))
				
			Else 
				
				This:C1470.transform(This:C1470._getTarget($cx); This:C1470._rotate($deg))
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=3)  // Fraction + cx + cy | ref
			
			If (Value type:C1509($cy)=Is real:K8:4)\
				 | (Value type:C1509($cy)=Is longint:K8:6)
				
				This:C1470.transform(This:C1470._getTarget(); This:C1470._rotate($deg; $cx; $cy))
				
			Else 
				
				This:C1470.transform(This:C1470._getTarget($cy); This:C1470._rotate($deg; $cx))
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=4)  // Fraction + cx + cy + ref
			
			This:C1470.transform(This:C1470._getTarget($applyTo); This:C1470._rotate($deg; $cx; $cy))
			
			//…………………………………………………………………………………………
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function rotateRad($rad : Real; $cx : Variant; $cy : Real; $applyTo) : cs:C1710.svg
	
	var $paramNumber:=Count parameters:C259
	
	If (Not:C34(This:C1470._requiredParams($paramNumber; 1)))
		
		return This:C1470
		
	End if 
	
	// Conversion radians → degrees
	var $deg:=$rad*(180/Pi:K30:1)
	
	Case of 
			
			//…………………………………………………………………………………………
		: ($paramNumber=1)  // Angle
			
			This:C1470.transform(This:C1470._getTarget(); This:C1470._rotate($deg))
			
			//…………………………………………………………………………………………
		: ($paramNumber=2)  // Angle + cx | ref
			
			If (Value type:C1509($cx)=Is real:K8:4)\
				 | (Value type:C1509($cx)=Is longint:K8:6)
				
				This:C1470.transform(This:C1470._getTarget(); This:C1470._rotate($deg; $cx))
				
			Else 
				
				This:C1470.transform(This:C1470._getTarget($cx); This:C1470._rotate($deg))
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=3)  // Angle + cx + cy | ref
			
			If (Value type:C1509($cy)=Is real:K8:4)\
				 | (Value type:C1509($cy)=Is longint:K8:6)
				
				This:C1470.transform(This:C1470._getTarget(); This:C1470._rotate($deg; $cx; $cy))
				
			Else 
				
				This:C1470.transform(This:C1470._getTarget($cy); This:C1470._rotate($deg; $cx))
				
			End if 
			
			//…………………………………………………………………………………………
		: ($paramNumber=4)  // Angle + cx + cy + ref
			
			This:C1470.transform(This:C1470._getTarget($applyTo); This:C1470._rotate($deg; $cx; $cy))
			
			//…………………………………………………………………………………………
	End case 
	
	return This:C1470
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _rotate($deg : Real; $cx : Real; $cy : Real; $applyTo : Text) : Text
	
	var $paramNumber:=Count parameters:C259
	
	Case of 
			
			//…………………………………………………………………………………………
		: ($paramNumber=1)  // Angle
			
			var $node:=This:C1470._getTarget()
			return "rotate("+String:C10($deg)+")"
			
			//…………………………………………………………………………………………
		: ($paramNumber=2)  // Angle + cx
			
			$node:=This:C1470._getTarget()
			return "rotate("+String:C10($deg)+" "+String:C10($cx; "&xml")+" "+String:C10($cx; "&xml")+")"
			
			//…………………………………………………………………………………………
		: ($paramNumber=3)  // Angle + cx + cy
			
			return "rotate("+String:C10($deg)+" "+String:C10($cx; "&xml")+" "+String:C10($cy; "&xml")+")"
			
			//…………………………………………………………………………………………
	End case 
	
	//———————————————————————————————————————————————————————————
Function scale($sx : Real; $sy; $applyTo) : cs:C1710.svg
	
	var $paramNumber:=Count parameters:C259
	
	If (Not:C34(This:C1470._requiredParams($paramNumber; 1)))
		
		return This:C1470
		
	End if 
	
	var $node:=This:C1470._getTarget($applyTo)
	
	If ($paramNumber>=2)
		
		If (Value type:C1509($sy)=Is real:K8:4)\
			 | (Value type:C1509($sy)=Is longint:K8:6)
			
			var $transform:="scale("+String:C10($sx; "&xml")+" "+String:C10($sy; "&xml")+")"
			
		Else 
			
			$transform:="scale("+String:C10($sx; "&xml")+")"
			
		End if 
		
	Else 
		
		$transform:="scale("+String:C10($sx; "&xml")+")"
		
	End if 
	
	This:C1470.transform($node; $transform)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function transform($node : Text; $transform : Text; $stack : Boolean)
	
	$stack:=Count parameters:C259>=3 ? $stack : This:C1470.stackTransformation
	
	var $t : Text:=This:C1470.getAttribute($node; "transform")
	
	If (Length:C16($t)=0)
		
		This:C1470.errors.remove(This:C1470.errors.length-1)  // Ignore the last error
		
	Else 
		
		var $c:=Split string:C1554($t; " ")
		
		If ($stack)
			
			$c.push($transform)
			
		Else 
			
			var $target : Text:=Split string:C1554($transform; "("; sk ignore empty strings:K86:1+sk trim spaces:K86:2)[0]+"(@"
			var $indx:=$c.indexOf($target)
			
			If ($indx#-1) & Not:C34($stack)
				
				$c[$indx]:=$transform
				
			Else 
				
				$c.push($transform)
				
			End if 
		End if 
		
		$transform:=$c.join(" ")
		
	End if 
	
	Super:C1706.setAttribute($node; "transform"; $transform)
	
	// MARK:- FILL & STROKE
	//———————————————————————————————————————————————————————————
Function fillColor($color : Text; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	
	If ($node=This:C1470.root)
		
		Super:C1706.setAttribute($node; "viewport-fill"; $color)
		
	Else 
		
		Super:C1706.setAttribute($node; "fill"; $color)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function fillOpacity($opacity : Real; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	$opacity:=This:C1470._num2Percent($opacity)/100
	
	If ($node=This:C1470.root)
		
		Super:C1706.setAttribute($node; "viewport-fill-opacity"; $opacity)
		
	Else 
		
		Super:C1706.setAttribute($node; "fill-opacity"; $opacity)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets one or more fill attributes
Function fill($value; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	var $fill : Text:=$node=This:C1470.root ? "viewport-fill" : "fill"
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is text:K8:3)  // Set color
			
			Case of 
					
					// ______________________________________________________
				: (["nonzero"; "evenodd"].includes($value))  // fill-rule
					
					var $name:=This:C1470.getName($node)
					
					If (This:C1470._shapes.includes($name))\
						 || (["g"; "svg"; "use"].includes($name))
						
						Super:C1706.setAttribute($node; "fill-rule"; $value)
						
					Else 
						
						This:C1470._pushError("You cannot set the \"fill-rule\" attribute for a "+$name+" element!")
						
					End if 
					
					// ______________________________________________________
				: (This:C1470.store.query("id = :1"; $value).first()#Null:C1517)  // Sets with a pattern
					
					Super:C1706.setAttribute($node; $fill; "url(#"+$value+")")
					
					// ______________________________________________________
				Else 
					
					Super:C1706.setAttribute($node; $fill; $value)
					
					// ______________________________________________________
			End case 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is boolean:K8:9)  // Set visibility
			
			If ($value)
				
				If (String:C10(This:C1470.getAttribute($node; $fill))="none")
					
					This:C1470.removeAttribute($node; $fill)
					
				End if 
				
			Else 
				
				Super:C1706.setAttribute($node; $fill; "none")
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is object:K8:27)  // Multiple attributes
			
			If ($value.color#Null:C1517)
				
				Super:C1706.setAttribute($node; $fill; $value.color)
				
			End if 
			
			If ($value.opacity#Null:C1517)
				
				Super:C1706.setAttribute($node; $fill+"-opacity"; $value)
				
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("Bad parameter type")
			
			//______________________________________________________
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets fill or stroke attribute with a gradient
Function gradient($id : Text; $stroke; $applyTo) : cs:C1710.svg
	
	If (Value type:C1509($stroke)=Is text:K8:3)
		
		$applyTo:=$stroke
		$stroke:=False:C215
		
	End if 
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); $stroke ? "stroke" : "fill"; "url(#"+$id+")")
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function strokeColor($color : Text; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "stroke"; $color)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function strokeWidth($width : Real; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "stroke-width"; $width)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function strokeOpacity($opacity : Real; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "stroke-opacity"; This:C1470._num2Percent($opacity)/100)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function dasharray($dash : Real;  ...  : Integer) : cs:C1710.svg
	
	var $offset : Real
	
	If ($dash=0)
		
		var $value:="none"
		
	Else 
		
		If (Dec:C9($dash)#0)
			
			var $buffer:=String:C10($dash)
			var $separator : Text
			GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $separator)
			$buffer:=Delete string:C232($buffer; 1; Position:C15($separator; $buffer))
			$offset:=Num:C11($buffer)
			
		End if 
		
		$value:=String:C10(Int:C8($dash))
		
		If (Count parameters:C259=1)
			
			$value:=$value+","+$value
			
		Else 
			
			var $i : Integer
			For ($i; 2; Count parameters:C259; 1)
				
				$value:=$value+","+String:C10(${$i})
				
			End for 
		End if 
	End if 
	
	If ($offset#0)
		
		Super:C1706.setAttribute(This:C1470._getTarget(); "stroke-dashoffset"; String:C10($offset))
		
	End if 
	
	Super:C1706.setAttribute(This:C1470._getTarget(); "stroke-dasharray"; $value)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets the vector-effect attribute to the current (or passed) element
Function nonScalingStroke($mode; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	var $type:=Value type:C1509($mode)
	
	Case of 
			
			//______________________________________________________
		: ($type=Is boolean:K8:9)
			
			If ($mode)
				
				Super:C1706.setAttribute($node; "vector-effect"; "non-scaling-stroke")
				
			Else 
				
				Super:C1706.setAttribute($node; "vector-effect"; "none")
				
			End if 
			
			//______________________________________________________
		: ($type=Is text:K8:3)
			
			If (Length:C16($mode)=0)
				
				Super:C1706.removeAttribute($node; "vector-effect")
				
			Else 
				
				Super:C1706.setAttribute($node; "vector-effect"; $mode)
				
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("Bad parameter type")
			
			//______________________________________________________
	End case 
	
	//———————————————————————————————————————————————————————————
	// Sets one or more stroke attributes
Function stroke($value; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is real:K8:4)\
			 | (Value type:C1509($value)=Is longint:K8:6)  // Set width
			
			Super:C1706.setAttribute($node; "stroke-width"; $value)
			
			//______________________________________________________
		: (Value type:C1509($value)=Is text:K8:3)  // Set color
			
			Case of 
					
					// ______________________________________________________
				: (["butt"; "round"; "square"].includes($value))  // Stroke-linecap
					
					var $name:=This:C1470.getName($node)
					
					If (This:C1470._shapes.includes($name))\
						 || (["g"; "line"; "svg"; "use"].includes($name))
						
						return This:C1470.linecap($value; $applyTo)
						
					Else 
						
						This:C1470._pushError("You cannot set the \"Stroke-linecap\" attribute for a "+$name+" element!")
						
					End if 
					
					// ______________________________________________________
				: (["miter"; "round"; "bevel"; "arcs"].includes($value))  // Stroke-linejoin
					
/* ⚠️ 
					
"round" value will be treated above as a value for "stroke-linecap" 
It is therefore preferable to use the function.linejoin() to set this value for "stroke-linejoin"
					
*/
					
					$name:=This:C1470.getName($node)
					
					If (This:C1470._shapes.includes($name))\
						 || (["g"; "line"; "svg"; "use"].includes($name))
						
						return This:C1470.linejoin($value; $applyTo)
						
					Else 
						
						This:C1470._pushError("You cannot set the \"fill-rule\" attribute for a "+$name+" element!")
						
					End if 
					
					// ______________________________________________________
				: (This:C1470.store.query("id = :1"; $value).first()#Null:C1517)  // Sets with a pattern
					
					Super:C1706.setAttribute($node; "stroke"; "url(#"+$value+")")
					
					// ______________________________________________________
				Else 
					
					Super:C1706.setAttribute($node; "stroke"; $value)
					
					// ______________________________________________________
			End case 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is boolean:K8:9)  // Set visibility
			
			If ($value)
				
				If (String:C10(This:C1470.getAttribute($node; "stroke"))="none")
					
					This:C1470.removeAttribute($node; "stroke")
					
				End if 
				
				If (Num:C11(This:C1470.getAttribute($node; "stroke-width"))=0)
					
					This:C1470.removeAttribute($node; "stroke-width")
					
				End if 
				
			Else 
				
				Super:C1706.setAttribute($node; "stroke"; "none")
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is object:K8:27)  // Multiple attributes
			
			If ($value.color#Null:C1517)
				
				Super:C1706.setAttribute($node; "stroke"; $value.color)
				
			End if 
			
			If ($value.width#Null:C1517)
				
				Super:C1706.setAttribute($node; "stroke-width"; $value.width)
				
			End if 
			
			If ($value.opacity#Null:C1517)
				
				Super:C1706.setAttribute($node; "stroke-opacity"; $value.opacity)
				
			End if 
			
			If ($value.linecap#Null:C1517)
				
				Super:C1706.setAttribute($node; "stroke-linecap"; $value.linecap)
				
			End if 
			
			If ($value.linejoin#Null:C1517)
				
				Super:C1706.setAttribute($node; "stroke-linejoin"; $value.linejoin)
				
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("Bad parameter type")
			
			//______________________________________________________
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets linecap attributes
Function linecap($value; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	
	If (["butt"; "round"; "square"].includes($value))
		
		Super:C1706.setAttribute($node; "stroke-linecap"; $value)
		
	Else 
		
		This:C1470._pushError($value+"is not a valid value for the \"linejoin\" attribute")
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets linejoin attributes
Function linejoin($value; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	
	If (["miter"; "round"; "bevel"; "arcs"].includes($value))
		
		Super:C1706.setAttribute($node; "stroke-linejoin"; $value)
		
	Else 
		
		This:C1470._pushError($value+"is not a valid value for the \"linejoin\" attribute")
		
	End if 
	
	return This:C1470
	
	// MARK:- FONT
	//———————————————————————————————————————————————————————————
Function fontFamily($fonts : Text; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "font-family"; $fonts)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function fontSize($size : Integer; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "font-size"; $size)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function fontStyle($style; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	
	If (Value type:C1509($style)=Is text:K8:3)
		
		This:C1470.style($style; $applyTo)
		
	Else 
		
		If ($style=Normal:K14:15)
			
			Super:C1706.setAttributes($node; New object:C1471(\
				"text-decoration"; "none"; \
				"font-style"; "normal"; \
				"font-weight"; "normal"))
			
		Else 
			
			// Mark:font-weight
			If ($style ?? 0)
				
				Super:C1706.setAttribute($node; "font-weight"; "bold")
				
			End if 
			
			// Mark:font-style
			If ($style ?? 1)
				
				Super:C1706.setAttribute($node; "font-style"; "italic")
				
			End if 
			
			// Mark:text-decoration
			var $c:=[]
			
			If ($style ?? 2)  // Underline
				
				$c.push("underline")
				
			End if 
			
			If ($style ?? 3)  // Line-through
				
				$c.push("line-through")
				
			End if 
			
			If ($c.length>0)
				
				Super:C1706.setAttribute($node; "text-decoration"; $c.join(" "))
				
			End if 
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function alignment($alignment : Integer; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
			//…………………………………………………………………………………………
		: ($alignment=Align center:K42:3)
			
			If ($name="textArea")
				
				Super:C1706.setAttribute($node; "text-align"; "center")
				
			Else 
				
				Super:C1706.setAttribute($node; "text-anchor"; "middle")
				
			End if 
			
			//…………………………………………………………………………………………
		: ($alignment=Align right:K42:4)
			
			Super:C1706.setAttribute($node; Choose:C955($name="textArea"; "text-align"; "text-anchor"); "end")
			
			//…………………………………………………………………………………………
		: ($alignment=Align left:K42:2)\
			 | ($alignment=Align default:K42:1)
			
			Super:C1706.setAttribute($node; Choose:C955($name="textArea"; "text-align"; "text-anchor"); "start")
			
			//…………………………………………………………………………………………
		: ($alignment=5)\
			 & ($name="textArea")
			
			Super:C1706.setAttribute($node; "text-align"; "justify")
			
			//…………………………………………………………………………………………
		Else 
			
			Super:C1706.setAttribute($node; Choose:C955($name="textArea"; "text-align"; "text-anchor"); "inherit")
			
			//…………………………………………………………………………………………
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function textRendering($rendering : Text; $applyTo) : cs:C1710.svg
	
	If (This:C1470._textRenderingValue.indexOf($rendering)#-1)
		
		Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "text-rendering"; $rendering)
		
	Else 
		
		This:C1470._pushError("Unknown value ("+$rendering+") for text-rendering.")
		
	End if 
	
	return This:C1470
	
	// MARK:-
	//———————————————————————————————————————————————————————————
Function visible($visible : Boolean; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "visibility"; $visible ? "visible" : "hidden")
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Assigns a class name, or a set of class names, to an element
Function class($class : Text; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "class"; $class)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
Function preserveAspectRatio($value : Text; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (This:C1470._aspectRatioValues.indexOf($value)#-1)
			
			Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "preserveAspectRatio"; $value)
			
		Else 
			
			Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "preserveAspectRatio"; "xMidYMid")  // Set to default
			
		End if 
	End if 
	
	// MARK:- FILTERS
	//———————————————————————————————————————————————————————————
	// Apply a filter to the current (or passed) element
Function filter($id : Text; $applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "filter"; "url(#"+$id+")")
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets a Gaussian blur for a filter
Function feGaussianBlur($filter : Text; $stdDeviation : Integer; $in : Text; $result : Text)
	
	If (This:C1470.isNull($filter))\
		 || (This:C1470.getName($filter)#"filter")
		
		This:C1470._pushError($filter+" is not a filter reference!")
		return 
		
	End if 
	
	var $attributes:={\
		stdDeviation: Count parameters:C259=1 ? 2 : $stdDeviation; \
		in: $in || "sourceGraphic"; \
		result: $result || "BLUR"}
	
	Super:C1706.create($filter; "feGaussianBlur"; $attributes)
	
	This:C1470._filterTarget:=$attributes.result
	
	//———————————————————————————————————————————————————————————
	// Sets an offset for a filter
Function feOffset($filter : Text; $dx : Integer; $dy : Integer; $in : Text; $result : Text)
	
	If (This:C1470.isNull($filter))\
		 || (This:C1470.getName($filter)#"filter")
		
		This:C1470._pushError($filter+" is not a filter reference!")
		return 
		
	End if 
	
	var $attributes:={}
	
	If (Count parameters:C259=1)
		
		$attributes.dx:=2
		$attributes.dy:=2
		
	Else 
		
		$attributes.dx:=$dx
		$attributes.dy:=$dy
		
	End if 
	
	$attributes.in:=$in || This:C1470._filterTarget || "sourceGraphic"
	$attributes.result:=$result || "OFFSET"
	
	Super:C1706.create($filter; "feOffset"; $attributes)
	
	This:C1470._filterTarget:=$attributes.result
	
	//———————————————————————————————————————————————————————————
	// Sets a blend filter for a filter
Function feBlend($filter : Text; $in : Text; $in2 : Text; $mode : Text; $result : Text)
	
	If (This:C1470.isNull($filter))\
		 || (This:C1470.getName($filter)#"filter")
		
		This:C1470._pushError($filter+" is not a filter reference!")
		return 
		
	End if 
	
	var $attributes:={\
		in: $in || "SourceGraphic"; \
		in2: $in2 || This:C1470._filterTarget; \
		mode: $mode || "normal"; \
		result: $result || "BLEND"}
	
	ASSERT:C1129(["normal"; "multiply"; "screen"; "darken"; "lighten"].includes($attributes.mode))
	
	Super:C1706.create($filter; "feBlend"; $attributes)
	
	This:C1470._filterTarget:=$attributes.result
	
	//———————————————————————————————————————————————————————————
	// Sets a color matrix transformation for a filter
Function feColorMatrix($filter : Text; $type : Text; $value; $in : Text; $result : Text)
	
	If (This:C1470.isNull($filter))\
		 || (This:C1470.getName($filter)#"filter")
		
		This:C1470._pushError($filter+" is not a filter reference!")
		return 
		
	End if 
	
	var $attributes:={\
		type: $type || "saturate"; \
		in: $in || "SourceGraphic"}
	
	ASSERT:C1129(["saturate"; "hueRotate"; "luminanceToAlpha"; "matrix"].includes($attributes.type))
	
	Case of 
			
			//______________________________________________________
		: ($attributes.type="matrix")  // A list of 20 matrix values, separated by whitespace and/or a comma
			
			If (Count parameters:C259>=2)
				
				If (Value type:C1509($value)=Is collection:K8:32)
					
					// Ensure matrix contains 20 values
					$value.resize(20; 0)
					$attributes.values:=$value.join(" ")
					
				Else 
					
					If (Value type:C1509($value)#Is text:K8:3)
						
						This:C1470._pushError("For the type \"matrix\", value parameter must be a Collection or a Text")
						return 
						
					End if 
					
					var $c:=Split string:C1554($value; " ,")
					
					If ($c.length=1)
						
						$c:=Split string:C1554($value; " ")
						
						If ($c.length=1)
							
							$c:=Split string:C1554($value; ",")
							
						End if 
					End if 
					
					If ($c.length<20)
						
						$c.resize(20; 0)
						
					End if 
					
					$attributes.values:=$c.join(" ")
					
				End if 
				
			Else 
				
				$attributes.values:=[].resize(20; 0).join(" ")  // identity matrix 
				
			End if 
			
			$attributes.values:=Replace string:C233($attributes.values; "0."; ".")
			
			//______________________________________________________
		: ($attributes.type="saturate")  // A single real number value (0 to 1)
			
			//FIXME: Check 0-1 or 0-100% then convert to 0-1
			If (Value type:C1509($value)=Is text:K8:3)
				
				$attributes.values:=$value
				
			Else 
				
				$attributes.values:=String:C10(Count parameters:C259>=2 ? Num:C11($value) : 1; "&xml")
				
			End if 
			
			//______________________________________________________
		: ($attributes.type="hueRotate")  // A single real number value (to indicate degrees of rotation)
			
			$attributes.values:=Count parameters:C259>=2 ? Num:C11($value) : 0
			
			//______________________________________________________
		: ($attributes.type="luminanceToAlpha")
			
			// The values parameter is not used with this type
			
			//______________________________________________________
		Else 
			
			// FIXME: Error
			//______________________________________________________
	End case 
	
	Super:C1706.create($filter; "feColorMatrix"; $attributes)
	
	This:C1470._filterTarget:=$attributes.result
	
	//———————————————————————————————————————————————————————————
	// Convert colors to grayscale
Function convertToGrayScale($grey; $applyTo) : cs:C1710.svg
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259=2)
			
			var $node:=This:C1470._getTarget($applyTo)
			
			//______________________________________________________
		: (Count parameters:C259=1)
			
			If (Value type:C1509($grey)=Is text:K8:3)
				
				$node:=This:C1470._getTarget($grey)
				$grey:=8858
				
			Else 
				
				$node:=This:C1470._getTarget()
				
			End if 
			
			//______________________________________________________
		Else 
			
			$node:=This:C1470._getTarget()
			$grey:=8858
			
			//______________________________________________________
	End case 
	
	var $element:=This:C1470.getName($node)
	
	If ($element#"image") && (Not:C34(This:C1470._container.includes($element)))
		
		This:C1470._pushError("can't be applied to "+$element)
		
		return 
		
	End if 
	
	If ($grey=8858)
		
		// Use visual perception of the luminance
		// 30% red, 59% green and 11% blue
		var $matrix:=".299 .587 .114 0 0 "
		$matrix+=".299 .587 .114 0 0 "
		$matrix+=".299 .587 .114 0 0 "
		$matrix+="0 0 0 1 0"
		
	Else 
		
		$matrix:="{%} {%} {%} 0 0 "
		$matrix+="{%} {%} {%} 0 0 "
		$matrix+="{%} {%} {%} 0 0 "
		$matrix+="0 0 0 1 0"
		
		// Allow the value to be passed as a real number between 0 & 1
		// or as an integer between 0 & 100
		$grey:=$grey>1 ? $grey/100 : $grey
		$matrix:=Replace string:C233($matrix; "{%}"; String:C10($grey; "&xml"))
		
	End if 
	
	var $id:="grey_"+String:C10($grey; "&xml")
	
	// Define the filter
	If (This:C1470.isNull(This:C1470.findById($id)))  // No need to redo an existing definition
		
		var $filter:=This:C1470.defineFilter($id; {\
			filterUnits: "objectBoundingBox"; \
			x: "0%"; \
			y: "0%"; \
			width: "100%"; \
			height: "100%"})
		
		This:C1470.feColorMatrix($filter; "matrix"; $matrix)
		
	End if 
	
	// Apply the filter
	This:C1470.filter($id; $node)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Set a drop shadow for the current element
Function dropShadow($stdDeviation : Integer; $dx : Integer; $dy : Integer) : cs:C1710.svg
	
	var $c:=Copy parameters:C1790
	$stdDeviation:=$c.length>=1 ? $stdDeviation : 2
	$dx:=$c.length>=2 ? $dx : 2
	$dy:=$c.length>=3 ? $dy : 2
	
	If ($stdDeviation=2)\
		 && ($dx=2)\
		 && ($dy=2)
		
		// Use default definition
		var $id:="dropShadow"
		
	Else 
		
		$id:="dropShadow"
		$id+="_"+String:C10($stdDeviation)
		$id+="_"+String:C10($dx)
		$id+="_"+String:C10($dy)
		
	End if 
	
	If (This:C1470.isNull(This:C1470.findById($id)))  // No need to redo an existing definition
		
		// Define the filter
		var $filter:=This:C1470.defineFilter($id)
		This:C1470.feGaussianBlur($filter; $stdDeviation; "SourceAlpha")
		This:C1470.feOffset($filter; $dx; $dy)
		This:C1470.feBlend($filter)
		
	End if 
	
	// Apply the filter
	This:C1470.filter($id)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets a blend filter to the current element
Function blend($alpha : Boolean) : cs:C1710.svg
	
	var $in : Text:=$alpha ? "sourceAlpha" : ""
	var $id:="blend_"+($in || "SourceGraphic")
	
	var $filter:=This:C1470.defineFilter($id)
	This:C1470.feGaussianBlur($filter; 2; $in)
	This:C1470.feOffset($filter; 5; 5)
	This:C1470.feBlend($filter)
	
	// Apply the filter
	This:C1470.filter($id)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets a Gaussian blur filter to the current element
Function blur($stdDeviation : Integer) : cs:C1710.svg
	
	$stdDeviation:=Count parameters:C259>0 ? $stdDeviation : 2
	var $id:="blur_"+String:C10($stdDeviation)
	
	If (This:C1470.isNull(This:C1470.findById($id)))  // No need to redo an existing definition
		
		// Define the filter
		var $filter:=This:C1470.defineFilter($id)
		This:C1470.feGaussianBlur($filter; $stdDeviation)
		
	End if 
	
	// Apply the filter
	This:C1470.filter($id)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Applies a color matrix transformation to each pixel of the current element
Function colorMatrix($type : Text; $value) : cs:C1710.svg
	
	var $id : Text:="colorMatrix_"+$type
	var $filter:=This:C1470.defineFilter($id)
	This:C1470.feColorMatrix($filter; $type; $value)
	
	// Apply the filter
	This:C1470.filter($id)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets an offset filter to the current reference
Function offset($dx : Integer; $dy : Integer) : cs:C1710.svg
	
	$dy:=Count parameters:C259<2 ? $dx : $dy  // By default, the same offset is used on Y as on X
	
	var $id:="offset_"+String:C10($dx)+"_"+String:C10($dy)
	
	If (This:C1470.isNull(This:C1470.findById($id)))  // No need to redo an existing element
		
		// Define the filter
		var $filter:=This:C1470.defineFilter($id)
		This:C1470.feOffset($filter; $dx; $dy)
		
	End if 
	
	// Apply the filter
	This:C1470.filter($id)
	
	return This:C1470
	
	//MARK:-SHORTCUTS & UTILITIES
	//———————————————————————————————————————————————————————————
	// Lets you create any element type
Function addElement($name : Text; $attributes; $attachTo) : cs:C1710.svg
	
	This:C1470.latest:=Super:C1706.create(This:C1470._getContainer($attachTo); $name)
	Super:C1706.setAttributes(This:C1470.latest; $attributes)
	This:C1470.push()
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Attaches an element to a container, the root becomes the last element.
Function addTo($tgt : Text; $applyTo : Text) : cs:C1710.svg
	
	$tgt:=This:C1470._getTarget($tgt)
	
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($tgt; $name)
	
	If (This:C1470._container.includes($name))
		
		var $src:=This:C1470._getTarget($applyTo)
		
		// As the ID must be unique, keeps id and removes it
		var $id:=String:C10(This:C1470.popAttribute($src; "id"))
		
		This:C1470.latest:=Super:C1706.append($tgt; $src)
		
		// Restore ID, if any
		This:C1470.setID($id)
		
		Super:C1706.remove($src)
		This:C1470.restoreRoot()  // The root becomes the last element.
		
	Else 
		
		This:C1470._pushError("\""+$name+"\" used as target is not a container")
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Moves the latest element to a parent container.
Function attachTo($parent : Variant) : cs:C1710.svg
	
	var $src:=This:C1470.latest
	
	// As the ID must be unique, keeps id and removes it
	var $id:=String:C10(This:C1470.popAttribute($src; "id"))
	
	This:C1470.latest:=Super:C1706.clone($src; This:C1470._getContainer($parent))
	
	This:C1470.remove($src)
	
	/// Restore ID, if any
	This:C1470.setID($id)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// ⚠️ Overrides the method of the inherited class
Function clone($src : Text; $attachTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		var $target:=This:C1470._getTarget($src)
		
		If (This:C1470.getAttributes($target).id#Null:C1517)
			
			This:C1470.errors.push("As the id must be unique, it has been removed.")
			
		End if 
		
		This:C1470.latest:=Super:C1706.clone($target; This:C1470._getContainer($attachTo))
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Create one or more layer at the root of the SVG structure
Function layer($name : Text;  ...  : Text) : cs:C1710.svg
	
	var $i : Integer
	For ($i; 1; Count parameters:C259; 1)
		
		This:C1470.latest:=Super:C1706.create(This:C1470.root; "g")
		Super:C1706.setAttribute(This:C1470.latest; "id"; ${$i})
		This:C1470.push(${$i})
		
	End for 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	//  Define an element for the next operations
Function with($name : Text) : Boolean
	
	var $o : Object:=This:C1470.store.query("id=:1"; $name).first()
	
	If ($o#Null:C1517)
		
		This:C1470.latest:=$o.dom
		return True:C214
		
	Else 
		
		This:C1470._pushError("Element not found: "+$name)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Keep the dom reference for future use
Function push($id : Text) : cs:C1710.svg
	
	If (Count parameters:C259>=1)
		
		If (This:C1470.store.query("id=:1"; $id).first()=Null:C1517)
			
			This:C1470.store.push({id: $id; dom: This:C1470.latest})
			
		Else 
			
			This:C1470._pushError("The element \""+$id+"\" already exists")
			
		End if 
		
	Else 
		
		// Use the ID, if available, or assign a UUID.
		$id:=String:C10(This:C1470.getAttribute(This:C1470.latest; "id")) || Generate UUID:C1066
		
		var $o : Object:=This:C1470.store.query("id = :1"; $id).first()
		
		If ($o=Null:C1517)
			
			// Create
			This:C1470.store.push({id: $id; dom: This:C1470.latest})
			
		Else 
			
			// Update
			$o.dom:=This:C1470.latest
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Retrieve a stored dom reference
Function fetch($name : Text) : Text
	
	If (Count parameters:C259>=1)
		
		$o:=This:C1470.store.query("id = :1"; $name).first()
		
	Else 
		
		// Auto
		var $o:={dom: This:C1470.latest}
		
	End if 
	
	If ($o#Null:C1517)
		
		return $o.dom
		
	Else 
		
		This:C1470._pushError("The element \""+$name+"\" doesn't exists")
		
	End if 
	
	
Function closeCurrent() : cs:C1710.svg
	
	var $name:=This:C1470.getName(This:C1470.latest)
	
	If (["g"; "path"; "text"; "textArea"; "tspan"].includes($name))
		
		var $node:=This:C1470.parent(This:C1470.latest)
		$name:=This:C1470.getName($node)
		
		While (This:C1470._notContainer.includes($name))
			
			$node:=This:C1470.parent($node)
			$name:=This:C1470.getName($node)
			
		End while 
		
		This:C1470.latest:=$node
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// ⚠️ Overrides the method of the inherited class
	//Function close($keepOpened : Boolean) : cs.svg
	
	//var $name:=This.getName(This.latest)
	
	//// FIXME: List other structures to manage
	//If (Count parameters=0)\
		&& (["g"; "path"; "text"; "textArea"; "tspan"].includes($name))
	
	//var $node:=This.parent(This.latest)
	//$name:=This.getName($node)
	
	//While (This._notContainer.includes($name))
	
	//$node:=This.parent($node)
	//$name:=This.getName($node)
	
	//End while 
	
	//This.latest:=$node
	
	//Else 
	
	//If (This.autoClose)
	
	//If (Count parameters>=1)
	
	//If (Not($keepOpened))
	
	//return Super.close()
	
	//Else 
	
	//// ⚠️ XML tree is not closed
	
	//End if 
	
	//Else 
	
	//return Super.close()
	
	//End if 
	
	//Else 
	
	//// ⚠️ XML tree is not closed
	
	//End if 
	//End if 
	
	//return This
	
	//———————————————————————————————————————————————————————————
	// Close the parent container
Function closeParent() : cs:C1710.svg
	
	var $node:=This:C1470.latest
	var $name:=This:C1470.getName($node)
	
	If ($name="root")
		
		$node:=This:C1470.root
		
	Else 
		
		While (Not:C34(This:C1470._container.includes($name)))
			
			$node:=This:C1470.parent(This:C1470.parent($node))
			$name:=This:C1470.getName($node)
			
		End while 
	End if 
	
	This:C1470.latest:=$node
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Restore the root as the latest container
Function restoreRoot()
	
	This:C1470.latest:=This:C1470.root
	
	//———————————————————————————————————————————————————————————
	// Move up one (default)  or x level(s) in the XML tree.
Function goUp($level : Integer) : cs:C1710.svg
	
	$level-=1
	
	While ($level>0)
		
		This:C1470.latest:=This:C1470.parent(This:C1470.latest)
		$level-=1
		
	End while 
	
	This:C1470.latest:=This:C1470.parent(This:C1470.latest)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets shape color (stroke and fill)
Function color($color : Text; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	
	Super:C1706.setAttribute($node; "fill"; $color)
	Super:C1706.setAttribute($node; "stroke"; $color)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets opacity of stroke and fill.
Function opacity($opacity : Real; $applyTo) : cs:C1710.svg
	
	var $force : Boolean
	
	If (Value type:C1509($applyTo)=Is boolean:K8:9)
		
		$force:=$applyTo
		var $node:=This:C1470._getTarget()
		
	Else 
		
		$node:=This:C1470._getTarget($applyTo)
		
	End if 
	
	$opacity:=This:C1470._num2Percent($opacity)/100
	
	If (This:C1470.getName($node)="g") && Not:C34($force)
		
		Super:C1706.setAttribute($node; "opacity"; $opacity)
		
	Else 
		
		// Apply opacity to fill and stroke
		This:C1470.fillOpacity($opacity; $node)
		This:C1470.strokeOpacity($opacity; $node)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Define font properties
Function font($definition : cs:C1710.font; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	
	If ($definition.family#Null:C1517)
		
		Super:C1706.setAttribute($node; "font-family"; $definition.family)
		
	End if 
	
	If ($definition.size#Null:C1517)
		
		Super:C1706.setAttribute($node; "font-size"; $definition.size)
		
		If (Num:C11(Super:C1706.getAttribute($node; "y"))<Num:C11($definition.size))
			
			Super:C1706.setAttribute($node; "y"; $definition.size)
			
		End if 
	End if 
	
	If ($definition.color#Null:C1517)
		
		This:C1470.fill($definition.color; $node)
		
	End if 
	
	If ($definition.style#Null:C1517)
		
		This:C1470.fontStyle($definition.style; $node)
		
	End if 
	
	If ($definition.alignment#Null:C1517)
		
		This:C1470.alignment($definition.alignment; $node)
		
	End if 
	
	If ($definition.rendering#Null:C1517)
		
		This:C1470.textRendering($definition.rendering; $node)
		
	End if 
	
	If ($definition.stretch#Null:C1517)
		
		Try
			
			If (Value type:C1509($definition.stretch)=Is collection:K8:32)
				
				This:C1470.scale(Num:C11($definition.stretch[0]); Num:C11($definition.stretch[1]); $node)
				
			Else 
				
				This:C1470.scale(Num:C11($definition.stretch); 1; $node)
				
			End if 
		End try
	End if 
	
	If ($definition.rotation#Null:C1517)\
		 && (Num:C11($definition.rotation)#0)
		
		This:C1470.rotate(Num:C11($definition.rotation); Num:C11(Super:C1706.getAttribute($node; "x")); Num:C11(Super:C1706.getAttribute($node; "y")))
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Set the position of an object
Function position($x : Real; $y : Variant; $unit : Text) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget()
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
			//______________________________________________________
		: ($name="svg")\
			 | ($name="g")
			
			This:C1470._pushError("You can't set position for the element"+$name+"!")
			
			//______________________________________________________
		: ($name="circle")\
			 | ($name="ellipse")
			
			Case of 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=3)
					
					If (Value type:C1509($y)=Is real:K8:4)\
						 | (Value type:C1509($y)=Is longint:K8:6)
						
						Super:C1706.setAttributes($node; {\
							cx: String:C10($x; "&xml")+$unit; \
							cy: String:C10($y; "&xml")+$unit})
						
					Else 
						
						Super:C1706.setAttributes($node; {\
							cx: String:C10($x; "&xml")+$unit; \
							cy: String:C10(Num:C11($y); "&xml")+$unit})
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=2)
					
					If (Value type:C1509($y)=Is real:K8:4)\
						 | (Value type:C1509($y)=Is longint:K8:6)
						
						Super:C1706.setAttributes($node; {\
							cx: $x; \
							cy: $y})
						
					Else 
						
						Super:C1706.setAttributes($node; {\
							cx: String:C10($x; "&xml")+String:C10($y); \
							cy: String:C10($x; "&xml")+String:C10($y)})
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=1)
					
					Super:C1706.setAttributes($node; {\
						cx: $x; \
						cy: $x})
					
					//…………………………………………………………………………………………………
				Else 
					
					This:C1470._pushError("Missing parameter")
					
					//…………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
		: ($name="line")
			
			Case of 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=3)
					
					If (Value type:C1509($y)=Is real:K8:4)\
						 | (Value type:C1509($y)=Is longint:K8:6)
						
						Super:C1706.setAttributes($node; {\
							x1: String:C10($x; "&xml")+$unit; \
							y1: String:C10($y; "&xml")+$unit})
						
					Else 
						
						Super:C1706.setAttributes($node; {\
							x1: String:C10($x; "&xml")+$unit; \
							y1: String:C10(Num:C11($y); "&xml")+$unit})
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=2)
					
					If (Value type:C1509($y)=Is real:K8:4)\
						 | (Value type:C1509($y)=Is longint:K8:6)
						
						Super:C1706.setAttributes($node; {\
							x1: $x; \
							y1: $y})
						
					Else 
						
						Super:C1706.setAttributes($node; {\
							x1: String:C10($x; "&xml")+String:C10($y); \
							y1: String:C10($x; "&xml")+String:C10($y)})
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=1)
					
					Super:C1706.setAttributes($node; {\
						x1: $x; \
						y1: $x})
					
					//…………………………………………………………………………………………………
				Else 
					
					This:C1470._pushError("Missing parameter")
					
					//…………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
		Else 
			
			Case of 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=3)
					
					Super:C1706.setAttributes($node; {\
						x: String:C10($x; "&xml")+$unit; \
						y: String:C10(Num:C11($y); "&xml")+$unit})
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=2)
					
					If (Value type:C1509($y)=Is text:K8:3)
						
						Super:C1706.setAttributes($node; {\
							x: String:C10($x; "&xml")+String:C10($y); \
							y: String:C10($x; "&xml")+String:C10($y)})
						
					Else 
						
						Super:C1706.setAttributes($node; {\
							x: $x; \
							y: Num:C11($y)})
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=1)
					
					Super:C1706.setAttributes($node; {\
						x: $x; \
						y: $x})
					
					//…………………………………………………………………………………………………
				Else 
					
					This:C1470._pushError("Missing parameter")
					
					//…………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Set the dimensions of an object
Function size($width : Real; $height : Real; $unit : Text) : cs:C1710.svg
	
	// Alow to pass only one value
	$height:=Count parameters:C259>=2 ? $height : $width
	
	var $node:=This:C1470._getTarget()
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
			//______________________________________________________
		: ($name="g")\
			 | ($name="use")
			
			This:C1470._pushError("You can't set dimensions for the element"+$name+"!")
			
			//______________________________________________________
		: ($name="textArea")
			
			Case of 
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259=0)
					
					Super:C1706.setAttributes($node; {\
						width: "auto"; \
						height: "auto"})
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=3)
					
					Super:C1706.setAttributes($node; {\
						width: $width=0 ? "auto" : String:C10($width; "&xml")+String:C10($unit); \
						height: $height=0 ? "auto" : String:C10($height; "&xml")+String:C10($unit)})
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=2)
					
					Super:C1706.setAttributes($node; {\
						width: $width=0 ? "auto" : String:C10($width; "&xml"); \
						height: $height=0 ? "auto" : String:C10($height; "&xml")})
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=1)
					
					Super:C1706.setAttribute($node; "width"; $width=0 ? "auto" : String:C10($width; "&xml"))
					
					//……………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
		: ($name="line")
			
			Case of 
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=3)
					
					Super:C1706.setAttribute($node; "y2"; String:C10(Num:C11(Super:C1706.getAttribute($node; "y1"))+$width; "&xml")+String:C10($unit))
					Super:C1706.setAttribute($node; "x2"; String:C10(Num:C11(Super:C1706.getAttribute($node; "x1"))+$height; "&xml")+String:C10($unit))
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=2)  // Length & offset
					
					Super:C1706.setAttribute($node; "y2"; String:C10(Num:C11(Super:C1706.getAttribute($node; "y1"))+$width; "&xml"))
					Super:C1706.setAttribute($node; "x2"; String:C10(Num:C11(Super:C1706.getAttribute($node; "x1"))+$height; "&xml"))
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=1)  // Length
					
					Super:C1706.setAttribute($node; "y2"; String:C10(Num:C11(Super:C1706.getAttribute($node; "y1"))+$width; "&xml"))
					
					//……………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
		: ($name="circle")\
			 | ($name="ellipse")
			
			Super:C1706.setAttributes($node; {\
				rx: String:C10($width; "&xml")+String:C10($unit); \
				ry: String:C10($height; "&xml")+String:C10($unit)})
			
			//______________________________________________________
		Else 
			
			Case of 
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=3)
					
					Super:C1706.setAttributes($node; {\
						width: String:C10($width; "&xml")+String:C10($unit); \
						height: String:C10($height; "&xml")+String:C10($unit)})
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=2)
					
					Super:C1706.setAttributes($node; {\
						width: String:C10($width; "&xml"); \
						height: String:C10($height; "&xml")})
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=1)
					
					Super:C1706.setAttribute($node; "width"; String:C10($width; "&xml"))
					
					//……………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Horizontal shift
Function moveHorizontally($x : Real; $applyTo) : cs:C1710.svg
	
	This:C1470.translate($x; 0; This:C1470._getTarget($applyTo))
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Vertical shift
Function moveVertically($y : Real; $applyTo) : cs:C1710.svg
	
	This:C1470.translate(0; $y; This:C1470._getTarget($applyTo))
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Populate the "points" property of a polyline, polygon
	// or the "data" proprety of a path
Function plot($points : Variant; $applyTo) : cs:C1710.svg
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		var $node:=This:C1470._getTarget($applyTo)
		var $name : Text
		DOM GET XML ELEMENT NAME:C730($node; $name)
		
		Case of 
				
				//…………………………………………………………………………………………………
			: ($name="polyline")\
				 | ($name="polygon")
				
				This:C1470.points($points; $node)
				
				//…………………………………………………………………………………………………
			: ($name="path")
				
				This:C1470.d($points; $node)
				
				//…………………………………………………………………………………………………
			Else 
				
				This:C1470._pushError("The element \""+$name+"\" is not compatible withe \"plot\" property")
				
				//…………………………………………………………………………………………………
		End case 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Fix the radius of a circle or a rounded rectangle
Function radius($radius : Integer; $applyTo) : cs:C1710.svg
	
	
	var $node:=This:C1470._getTarget($applyTo)
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
			//______________________________________________________
		: ($name="rect")\
			 | ($name="g")
			
			Super:C1706.setAttribute($node; "rx"; $radius)
			
			//______________________________________________________
		: ($name="circle")
			
			Super:C1706.setAttribute($node; "r"; $radius)
			
			//______________________________________________________
		Else 
			
			This:C1470._pushError("Cant set radius for an object "+$name)
			
			//______________________________________________________
	End case 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Make visible
Function show($applyTo) : cs:C1710.svg
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "visibility"; "visible")
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Make invisible
Function hide($applyTo) : cs:C1710.svg
	
	
	Super:C1706.setAttribute(This:C1470._getTarget($applyTo); "visibility"; "hidden")
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Add a class name to an element
Function addClass($class : Text; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	var $t:=String:C10(This:C1470.getAttribute($node; "class"))
	
	If (Length:C16($t)>0)
		
		If (Split string:C1554($t; " ").indexOf($class)=-1)
			
			$t+=" "+$class
			
		End if 
		
	Else 
		
		$t:=$class
		
	End if 
	
	Super:C1706.setAttribute($node; "class"; $t)
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Remove a class name from an element
Function removeClass($class : Text; $applyTo) : cs:C1710.svg
	
	var $node:=This:C1470._getTarget($applyTo)
	var $t:=String:C10(This:C1470.getAttribute($node; "class"))
	
	If (Length:C16($t)>0)
		
		var $c:=Split string:C1554($t; " ")
		var $indx : Integer:=$c.indexOf($class)
		
		If ($indx#-1)
			
			$c.remove($indx)
			Super:C1706.setAttribute($node; "class"; $c.join(" "))
			
		End if 
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Tests if the node belongs to a class
Function isOfClass($class : Text; $applyTo) : Boolean
	
	return (Position:C15($class; String:C10(This:C1470.getAttribute(This:C1470._getTarget($applyTo); "class")))#0)
	
	//———————————————————————————————————————————————————————————
	// ⚠️ Overrides the method of the inherited class
Function setValue($value : Text; $applyTo; $CDATA : Boolean) : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		If (Count parameters:C259>=3)
			
			var $isCDATA:=$CDATA
			var $node:=This:C1470._getTarget(String:C10($applyTo))
			
		Else 
			
			If (Value type:C1509($applyTo)=Is text:K8:3)
				
				$node:=This:C1470._getTarget($applyTo)
				
			Else 
				
				$node:=This:C1470._getTarget()
				$isCDATA:=Bool:C1537($applyTo)
				
			End if 
		End if 
		
	Else 
		
		$node:=This:C1470._getTarget()
		
	End if 
	
	If ($isCDATA)
		
		Super:C1706.setValue($node; $value; True:C214)
		
	Else 
		
		Super:C1706.setValue($node; $value)
		
	End if 
	
	return This:C1470
	
	//———————————————————————————————————————————————————————————
	// Display the SVG image & tree into the 4D SVG Viewer if available
	// into the clipboard if not
Function preview($keepStructure : Boolean)
	
	ARRAY TEXT:C222($_names; 0x0000)
	COMPONENT LIST:C1001($_names)
	
	If (Find in array:C230($_names; "4D SVG")#-1)
		
		Formula from string:C1601("SVGTool_SHOW_IN_VIEWER").call(Null:C1517; This:C1470.root)
		
		If (Count parameters:C259>=1)
			
			If (This:C1470.autoClose)\
				 && (Not:C34($keepStructure))
				
				Super:C1706.close()
				
			End if 
			
		Else 
			
			If (This:C1470.autoClose)
				
				Super:C1706.close()
				
			End if 
		End if 
		
	Else 
		
		SET PICTURE TO PASTEBOARD:C521(This:C1470.picture($keepStructure))
		INVOKE ACTION:C1439(ak show clipboard:K76:58)
		
	End if 
	
	//———————————————————————————————————————————————————————————
	// Provides the text of a <text>, <tspan> or <textArea> with line breaks.
Function getContainerText($applyTo : Text) : Text
	
	var $text : Text
	
	var $node:=This:C1470._getTarget($applyTo)
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	If ($name="text")\
		 || ($name="textArea")\
		 || ($name="tspan")
		
		var $isTextArea : Boolean:=$name="textArea"
		ARRAY TEXT:C222($_nodes; 0)
		ARRAY LONGINT:C221($_types; 0)
		DOM GET XML CHILD NODES:C1081($node; $_types; $_nodes)
		
		var $i : Integer
		For ($i; 1; Size of array:C274($_types); 1)
			
			Case of 
					
					//______________________________________________________
				: ($_types{$i}=XML DATA:K45:12)
					
					$_nodes{$i}:=Replace string:C233($_nodes{$i}; "\r"; "")
					$_nodes{$i}:=Replace string:C233($_nodes{$i}; "\n"; "")
					
					$text+=$_nodes{$i}
					
					//______________________________________________________
				: ($_types{$i}=XML ELEMENT:K45:20)
					
					DOM GET XML ELEMENT NAME:C730($_nodes{$i}; $name)
					
					Case of 
							
							//………………………………………………………………………………………………………
						: ($name="tbreak")
							
							$text+="\r"
							
							//………………………………………………………………………………………………………
						: ($name="tspan")
							
							var $t : Text
							DOM GET XML ELEMENT VALUE:C731($_nodes{$i}; $t)
							
							If (Not:C34($isTextArea))
								
								// The line breaks are managed with <tbreak> elements
								
								If (Length:C16($text)>0)
									
									$text+="\r"
									
								End if 
							End if 
							
							$text+=$t
							
							//………………………………………………………………………………………………………
					End case 
					
					//______________________________________________________
			End case 
		End for 
		
		return $text
		
	End if 
	
	//———————————————————————————————————————————————————————————
Function setText($text : Text; $applyTo)
	
	var $node:=This:C1470._getTarget($applyTo)
	DOM SET XML ELEMENT VALUE:C868($node; "")
	
	$node:=DOM Append XML child node:C1080($node; XML DATA:K45:12; $text)
	
	//———————————————————————————————————————————————————————————
	// Returns text width
Function getTextWidth($string : Text; $fontAttributes : Object) : Integer
	
	var $svg:=cs:C1710.svg.new().textArea($string)
	
	If (Count parameters:C259>=2)
		
		$svg.font($fontAttributes)
		
		//Else : Keep the default font that should be: Times New Roman 12 pts.
		
	End if 
	
	var $picture:=$svg.picture()
	var $height; $width : Integer
	PICTURE PROPERTIES:C457($picture; $width; $height)
	
	return $width
	
	//———————————————————————————————————————————————————————————
	// 🚧 Returns text height #WIP
Function getTextHeight($string : Text; $fontAttributes : Object)->$height : Integer
	
	var $picture : Picture
	var $width : Integer
	var $o : Object
	var $line : Text
	
	// 1] Calculate the height of the last line
	$line:=$string
	
	// Keep only the last line
	ARRAY LONGINT:C221($len; 0x0000)
	ARRAY LONGINT:C221($pos; 0x0000)
	If (Match regex:C1019("(?i-ms).*$"; $string; 1; $pos; $len))
		
		$line:=Substring:C12($string; $pos{0}; $len{0})
		
	End if 
	
	$o:=cs:C1710.svg.new().text($line)
	
	If (Count parameters:C259>=2)
		
		$o.font($fontAttributes)
		
	End if 
	
	If (Count parameters:C259>=2)
		
		$o.font($fontAttributes)
		
		//Else : Keep the default font that should be: Times New Roman 12 pts.
		
	End if 
	
	$picture:=$o.picture()
	PICTURE PROPERTIES:C457($picture; $width; $height)
	
	// 2] Measure the width and height of the text itself.
	$o.fillOpacity(0)
	
	$o.textArea()
	
	If (Count parameters:C259>=2)
		
		$o.font($fontAttributes)
		
	End if 
	
	//———————————————————————————————————————————————————————————
Function TextToPicture($text : Text; $attributes : Object) : Picture
	
	This:C1470.text($text)
	
	If ($attributes#Null:C1517)
		
		This:C1470.font($attributes)
		
	End if 
	
	return This:C1470.picture()
	
	//———————————————————————————————————————————————————————————
	// Making a point from x & y
Function point($x : Real; $y : Real) : Collection
	
	return cs:C1710.point.new($x; $y).value
	
	//———————————————————————————————————————————————————————————
	// Transforms the polar coordinates into cartesian coordinate
Function polarToCartesian($point : Collection; $r : Real; $degree : Integer) : Collection
	
	var $radian : Real:=$degree*Pi:K30:1/180
	$point[0]+=Round:C94($r*Cos:C18($radian); 5)
	$point[1]+=Round:C94($r*Sin:C17($radian); 5)
	
	return $point
	
	//MARK:-PRIVATES
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// Get an available container
Function _getContainer($param) : Text
	
	var $container
	
	// Keep a backup of the current item reference.
	// We might need it, if the created element is assigned to a symbol
	This:C1470._current:=This:C1470.latest
	
	$container:=This:C1470._getTarget($param)
	
	If ($container=This:C1470.root)
		
		return $container
		
	End if 
	
	var $name : Text
	DOM GET XML ELEMENT NAME:C730($container; $name)
	
	If (This:C1470._container.includes($name))
		
		return $container
		
	End if 
	
	$name:=Split string:C1554(Call chain:C1662[1].name; ".")[1]
	
	If ($name="appendText")
		
		return $container  // TextArea
		
	End if 
	
	If (This:C1470._notContainer.includes($name))
		
		return This:C1470.parent($container)
		
	End if 
	
	DOM GET XML ELEMENT NAME:C730($container; $name)
	
	If ($name#"path")
		
		return This:C1470.parent($container)
		
	End if 
	
	return $container
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// Checks whether a text value is a reference and, if so, makes it the last reference and returns True
Function _isReference($value) : Boolean
	
	var $node:=This:C1470._getContainer($value)
	
	If (This:C1470.isReference($node))
		
		This:C1470.latest:=$node
		return True:C214
		
	End if 
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// Returns the target of the function call
Function _getTarget($param) : Text
	
	Case of 
			
			// ______________________________________________________
		: (Count parameters:C259=0)
			
			// Auto
			
			// _______________________________
		: (Value type:C1509($param)#Is text:K8:3)
			
			// #ERROR
			
			// _______________________________
		: ($param="root")
			
			return This:C1470.root
			
			// _______________________________
		: ($param="latest")
			
			// <NOTHING MORE TO DO>
			
			// _______________________________
		: ($param="parent")
			
			If (This:C1470.latest=Null:C1517)\
				 || (This:C1470.latest="")
				
				return This:C1470.root
				
			Else 
				
				// Get the parent
				return This:C1470.parent(This:C1470.latest)
				
			End if 
			
			// _______________________________
		: ($param="symbol")
			
			return This:C1470.parent(This:C1470.latest || This:C1470.root; "symbol")
			
			// _______________________________
		: ($param="none")\
			 || ($param="defs")
			
			return   // An empty address
			
			// _______________________________
		: (This:C1470._reservedNames.includes($param))
			
			// Should not, because all reserved names are managed at a higher level 😇
			
			// _______________________________
		: (This:C1470.isReference($param))
			
			return $param  // The given reference
			
			// _______________________________
		Else 
			
			// Find a memorized targets
			var $o : Object:=This:C1470.store.query("id=:1"; $param).first()
			
			If ($o#Null:C1517)
				
				return $o.dom
				
			End if 
			
			// _______________________________
	End case 
	
	return (This:C1470.latest#Null:C1517) && (This:C1470.latest#"") ? This:C1470.latest : This:C1470.root
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
	// Looks for element "defs", create if not exists
Function _defs()->$reference
	
	var $c:=This:C1470.findByName("defs")
	
	If (This:C1470.success)
		
		$reference:=$c[0]
		
	Else 
		
		// Create & put in first position
		var $root:=DOM Create XML Ref:C861("root")
		This:C1470.success:=Bool:C1537(OK)
		
		If (This:C1470.success)
			
			var $node:=Super:C1706.create($root; "defs")
			
			If (This:C1470.success)
				
				$reference:=Super:C1706.insert(This:C1470.root; $node)
				
			End if 
			
			DOM CLOSE XML:C722($root)
			
		End if 
	End if 
	
	If (Not:C34(This:C1470.success))
		
		This:C1470._pushError("Failed to locate/create the \"defs\" element")
		
	End if 
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _data($node : Text) : Collection
	
	var $data : Text:=This:C1470.getAttribute($node; "d")
	
	If (This:C1470.success)
		
		return Split string:C1554($data; " "; sk ignore empty strings:K86:1)
		
	Else 
		
		var $name : Text
		DOM GET XML ELEMENT NAME:C730($node; $name)
		This:C1470._pushError("The element \""+$name+"\" has no \"d\" property")
		
	End if 
	