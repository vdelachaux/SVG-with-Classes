// MARK:- Declarations

// - font-family"
property family : Text

// - font-size
property size : Integer

// - text-decoration
// - font-style
// - font-weight
property style/* 
(0) Normal
(1) Bold + (2) Italic + (4) Underline + (8) Line-through
*/

// - fill
property color

// - text-align (textArea)
// - text-anchor (text)
property alignment : Integer/* 
Align center
Align right
Align left/default
5 (justified)
*/

property rendering : Text/*
"auto"
"optimizeSpeed"
"optimizeLegibility"
"geometricPrecision"
"inherit"
*/

property rotation : Real
property stretch

// MARK:-
// ———————————————————————————————————————————————————————————
Function default()
	
	This:C1470.family:="'lucida grande','segoe UI',sans-serif"
	This:C1470.size:=12
	This:C1470.style:=Normal:K14:15
	This:C1470.color:="black"
	This:C1470.alignment:=Align default:K42:1
	This:C1470.rendering:="geometricPrecision"
	This:C1470.rotation:=0
	OB REMOVE:C1226(This:C1470; "stretch")