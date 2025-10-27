//%attributes = {}
/*
In this example, we want to perform the following operations:
 • create a rectangle with 50% blue stroke & fill
 • create a 4% blur filter and apply it to this rectangle
 • Preview the result.
*/

cs:C1710.svg.new()\
.rect(50; 50).position(50; 50).fill("blue").fillOpacity(0.5).stroke("blue").strokeOpacity(0.5).blur(4)\
.preview()