<!-- Type your summary here -->
## E[x]TENSIBLE [m]ARKUP [l]ANGUAGE
This class is dedicated to the management of XML structures in Document Object Model (DOM) mode.

## Summary
This class is intended to work with the [enhanced XPath support](https://blog.4d.com/enhanced-xpath-support) available since version 18R3.

### Properties

|Properties|Type|Description|Initial value|
|---------|:----:|------|:------:|
|**.root**|Text|The DOM tree reference in memory of the document virtual structure|**Null**|
|**.autoClose**|Boolean|Indicates whether the XML tree should be automatically closed after a call to one of the functions: `.getText()`, `.getContent()` or `. save()`|**True\*** 🚨|
|**.file**|**4D**.File|The disk file of the last `.save()` or `.load()`call|**Null**|
|**.success**|Boolean|Indicates whether a function call was successfully executed|
|**.errors**|Collection|The list of errors encoutered, if so|[ ]|
|**.xml**|Text|The XML tree as text generated during the last call to the `.getText()` function.|**Null**|

\* 🚨 If `.autoClose` is set to **False** (or if you don't call a function that automatically closes the structure), once you no longer need the structure, remember to call the function `.close()` in order to free up the memory.


> 📌 With the exception of functions that return a specific result (getter function), each call returns the original `cs.xml` object, and you can include one call after another.

### Document functions

|Function|Action|
|--------|------|   
|.**newRef** ({root : `Text`} {; nameSpaceName : `Text`} {; nameSpaceName1 : `Text`; nameSpaceValue1 : `Text`} … {; nameSpaceNameN : `Text` ; nameSpaceValueN : `Text`}  ) → `cs.xml` | Create a new XML tree in memory
|.**setOption** ( selector : `Integer` ; value : `integer` ) → `cs.xml` | Modify the value of one XML option for the structure
|.**setOptions** ( selector : `Integer` ; value : `integer` … {selectorN : `Integer` ; valueN : `integer`}) → `cs.xml` | Modify the value of one or more XML options for the structure
|.**parse** ( value : `Text` {; validate : `Boolean` {; schema : `Text`}} ) → `cs.xml` <br/> .**parse** ( value : `Blob` {; validate : `Boolean` {; schema : `Text`}} ) → `cs.xml` | Parses a BLOB or Text type variable containing an XML structure 
|.**open** ( file : `4D.File` {; validate : `Boolean` {; schema : `Text`}} ) → `cs.xml` | Parses a document containing an XML structure
|.**save** () → `cs.xml` <br/> .**save** ( {file : `4D.File`} {; keepStructure : `Boolean`}) → `cs.xml` | Saves the XML structure to a document. If no file is provided and no previous `.file` is available, a save dialog is opened.
|.**close** ( ) → `cs.xml` | Close the XML tree (Release the memory)
|.**getText** ({keepStructure : `Boolean`}) → `Text` |  Returns the XML tree as text
|.**getContent** ({keepStructure : `Boolean`}) → `Blob` |  Returns the XML tree as BLOB
|.**toObject** ({withAdresses : `Boolean`}) → `Blob` |  Returns the XML structure as Object.<br/> If withAdresses is True, an attribute `@` is populated for each element with it's XML reference.
|.**toList** (counter : `Pointer` ; xpath : `Text`) → `Integer`<br>.**toList** (counter : `Pointer` ; nodeRef : `Text`) → `Integer`<br>.**toList** (counter : `Pointer` ; xpath : `Text` ; nodeRef : `Text`) → `Integer` |  Returns a hierarchical list from the XML tree.<br/>Each item of the list includes as item parameters: its `value`, its `xpath` & its `dom` reference.<br/>• To ensure the uniqueness of the references of the list elements, you must initialize a counter and pass a pointer as the 1st parameter of the function.<br/>• The `xpath` parameter can be the root name of the XML tree or an absolute path. 

### Elements functions

|Function|Action|
|--------|------|  
|.**create** ( XPath : `Text` {; attributes `Object | Collection`} ) → `cs.xml` <br/> .**create** ( target : `XML Ref`; XPath : `Text` {; attributes `Object | Collection`} ) → `cs.xml` | Creates a new element in the `target` element or the `root` if omitted 
|.**append** ( target : `XML Ref`; source : `XML Ref` ) → `cs.xml` | Appends a source element to the `target` element 
|.**appendChild** ( target : `XML Ref`; type : `Integer`; value : `Variant` ) → `XML Ref` | Appends a child node to the target (e.g. `XML DATA`, `XML comment`, processing instruction). Wrapper around DOM Append XML child node.
|.**insert** ( target : `XML Ref`; source : `XML Ref` {; index : `Integer`} ) → `cs.xml` | Inserts a source element among the children elements of the `target` element.
|.**clone** ( source : `XML Ref`; target : `XML Ref` {; index : `Integer`} ) → `cs.xml` |  Makes a copy of the `source` element in the `target` after the last child.
|.**remove** ( node : `XML Ref`) → `cs.xml` |  Removes the element referenced by `node`
|.**getName** ( node : `XML Ref`) → `Text` |  Returns the name of the element referenced by `node`
|.**setName** ( node : `XML Ref` ; name : `Text`) → `Text` |  Sets the name of the element referenced by `node`
|.**getValue** ( node : `XML Ref`) → `Variant` |  Returns the of the element referenced by `node`
|.**setValue** ( node : `XML Ref` ; value : `Variant`{; inCDATA : `Boolean`}) → `cs.xml` |  Modifies the value of the element referenced by `node`
|.**getAttribute** ( node : `XML Ref` ; attribute : `Text`) → `Variant` |  Returns the attribute value of the element referenced by `node`. **Null** if attribute doesn't exists
|.**popAttribute** ( node : `XML Ref` ; attribute : `Text`) → `Variant` |  Returns an attribute value of the element referenced by `node` & remove it
|.**getAttributes** ( node : `XML Ref` ) → `Object` |  Returns a node attributes as object
|.**getAttributesCollection** ( node : `XML Ref` ) → `Collection` |  Returns the collection of attributes of an element (key/values objects)
|.**setAttribute** ( node : `XML Ref` ; attribute : `Text` ; value :`Variant` )  → `cs.xml` | Sets a node's attribute
|.**setAttributes** ( node : `XML Ref` ; attribute : `Object`\|`Collection` )  → `cs.xml` | Sets a node's attributes from an object or a collection (key/value pairs)
|.**removeAttribute** ( node : `XML Ref` ; attribute : `Text` ; value :`Variant` )  → `cs.xml` | Removes an attribute, if exists


### Naviguation functions

|Function|Action|
|--------|------| 
|.**parent** ( node : `XML Ref` {; name : `Text`}) → `XML Ref`| Returns a reference to the parent of a node. <br/>If a name is passed, goes up in the hierarchy to find the named element
|.**firstChild** ( {node : `XML Ref`} {; name : `Text`}) → `XML Ref`| Returns a reference to the first “child”. <br/>If the node's reference isn't passed, return the first child of the root. <br/>If a name is passed, looks for the first child with that name
|.**lastChild** ( {node : `XML Ref`} {; name : `Text`}) → `XML Ref`| Returns a reference to the last “child”. <br/>If the node's reference isn't passed, return the last child of the root. <br/>If a name is passed, looks for the last child with that name
|.**childrens** ( {node : `XML Ref`} ) → `Collection`| Returns the list of the childs' references of a node or root if omitted
|.**descendants** ( {node : `XML Ref`} ) → `Collection`|  Returns descendant element references (children and deeper). Text/data child nodes are not returned.
|.**nextSibling** ( node : `XML Ref` {; name: `Text`} ) → `Collection`|  Returns a reference to the next “sibling”. <br/> If a name is passed, looks for the first sibling with that name
|.**previousSibling** ( node : `XML Ref` {; name: `Text`} ) → `Collection`|  Returns a reference to the previous “sibling”. <br/> If a name is passed, looks for the next previous sibling with that name

### Search

|Function|Action|
|--------|------| 
|.**findById** ( id : `Text`) → `XML Ref` |  Search for an element by its id
|.**findByXPath** ( XPath : `Text` {; node : `Text`}) → `XML Ref` |  Looks  for the 1st element corresponding to an XPath & returns its reference if success.
|.**find** ( XPath : `Text`) → `Collection` <br/> .**find** ( node : `Text` ; XPath : `Text`) → `Collection` | Searches for one or more elements corresponding to an XPath & returns a references collection if success.
|.**findByName** ( name : `Text`) → `Collection` <br/> .**findByName** ( target : `Text` ; name : `Text`) → `XML Ref` | Searches for elements by there name & returns a references collection if success.
|.**findByAttribute** ( name : `Text`; attribute : `Text` {; value : `Text`}) → `Collection` <br/> .**findByAttribute** ( attribute : `Text` {; value : `Text`}) → `Collection` | Searches for elements by there attribute.
|.**findOrCreate** ( target : `XML Ref`; name : `Text`) → `XML Ref`| Searches for an element by name and creates it if it is not found.

### Miscellaneous

|Function|Action|
|--------|------| 
|.**isReference** ( text : `Text`) → `Boolean` |  Returns **True** if text seams to be a XML Reference (8 coded characters in hexadecimal form)
|.**isNull** ( reference : `XML Ref`) → `Boolean` |  Returns **True** if reference is a sequence of 32 zero "0" characters
|.**isNotNull** ( reference : `XML Ref`) → `Boolean` |  Returns **True** if reference is not a sequence of 32 zero "0" characters

## 🔸 cs.xml.new()

The class constructor `cs.xml.new()` can be called without parameters to create an empty XML tree in memory.
>`cs.xml.new()

The class constructor also accepts an optional parameter, so you can create a XML tree by passing a 4D.File, a Blob variable or a Text variable.
>`cs.xml.new(4D.file)` Loads & parses the file content    
>`cs.xml.new(Blob)` Parses the blob variable content     
>`cs.xml.new(Text)` Parses the text variable content

## 🔹 .newRef()
>. newRef() → `cs.xml` 


>. newRef( rootName : `Text`) → `cs.xml` 

## 🔹 .create()
>.create( XPath : `Text` {; attributes `Object | Collection`} ) → `cs.xml` 
   
Creates a new element in the root

>.create( target : `XML Ref`; XPath : `Text` {; attributes `Object | Collection`} ) → `cs.xml`  
  
Creates a new element in the target element

`attributes` are attribute/value pairs. It can be an object or a collection. [see .setAttributes()]

## 🔹 .appendChild()
>.appendChild( target : `XML Ref`; type : `Integer`; value ) → `XML Ref`

Appends a child node to the target node.

Typical `type` values are XML constants such as `XML DATA`, `XML comment`, or processing-instruction type values.

This helper exists to avoid direct DOM command usage in subclasses when appending non-element child nodes.

## 🔹 .save()
>.save() → `cs.xml`

Saves the current XML tree.

Behavior without parameter:
- If `.file` is already defined (from `.open()` or a previous `.save()`), this file is reused.
- If `.file` is not defined, a save dialog is displayed to let the user choose a destination file.
- If the user validates the dialog, the selected file is stored in `.file` and used for saving.
- If the user cancels, `.save()` returns with `.success = False` and an error entry (`File is not defined`).

>.save(file : `4D.File` {; keepStructure : `Boolean`}) → `cs.xml`

Saves to the provided file directly, without opening a dialog.

`keepStructure` controls whether the in-memory DOM remains open when `.autoClose` is enabled.

## 🔹 .setAttributes()
>.setAttributes( target : `XML Ref`; attribute : `Text` ; value ) → `cs.xml` 

Set one attribute for the target element

>.setAttributes( target : `XML Ref`; attributes : `Object` ) → `cs.xml` 

Defines one or more attributes for the target element from a definition object.<br/>
Each property corresponding to an attribute name stores the value of the attribute.

>.setAttributes( target : `XML Ref`; attributes : `Collection` ) → `cs.xml` 

Defines one or more attributes for the target element from a collection.<br/>
Each element of the collection is an object with "key" and "value" properties.


