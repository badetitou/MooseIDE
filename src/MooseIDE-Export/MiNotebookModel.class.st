"
I am the model of the report builder.

I store a collection of cell models.

You can instantiate me with a moose notebook file (.ston):

```
builder := MiReportBuilder instantiateWith: '/path/to/notebook.ston' on: (MooseModel root at: 1).
```

Once a notebook is loaded, you can execute the notebook and export the reslut:

```
builder exportToTextAt: '/path/to/your/notebook.md' asFileReference
```

See export protocole (instance side) for more export methods.
"
Class {
	#name : #MiNotebookModel,
	#superclass : #MiAbstractModel,
	#instVars : [
		'mooseModel',
		'textEditedSource',
		'needToUpdate',
		'micDocument',
		'cellList',
		'context',
		'generatedDocument'
	],
	#category : #'MooseIDE-Export-Notebook'
}

{ #category : #initialization }
MiNotebookModel class >> initializeWith: aFileReference on: aMooseModel [

	^ self new
		  importCellsFrom: aFileReference;
		  followEntity: aMooseModel;
		  yourself
]

{ #category : #accessing }
MiNotebookModel >> cellList [

	^ cellList
]

{ #category : #accessing }
MiNotebookModel >> cellList: anOrderedCollection [

	needToUpdate := true.
	cellList := anOrderedCollection
]

{ #category : #accessing }
MiNotebookModel >> context [

	^ context
]

{ #category : #initialization }
MiNotebookModel >> defaultBindings [

	^ { 
		  ('mooseModel' -> mooseModel).
		  ('stream' -> nil).
		  ('printer' -> nil) }
]

{ #category : #initialization }
MiNotebookModel >> defaultBindingsWithStream: aStream [

	^ { 
		  ('mooseModel' -> mooseModel).
		  ('stream' -> aStream).
		  ('printer' -> nil) }
]

{ #category : #accessing }
MiNotebookModel >> entities [
	^mooseModel 
]

{ #category : #actions }
MiNotebookModel >> executeAllCells [

	needToUpdate ifFalse: [ ^ generatedDocument ].
	generatedDocument := String streamContents: [ :s | 
		              self initializeContextWithStream: s.
		              cellList do: [ :cell | 
			              cell printContentIn: s withContext: context.
			              s nextPut: Character cr ] ].
	needToUpdate := false.
	^ generatedDocument
]

{ #category : #actions }
MiNotebookModel >> executeAllCellsAsTextCollection [

	| textCollection |
	self initializeContext.

	generatedDocument := String streamContents: [ :p | 
		              textCollection := cellList collect: [ :cell | 
			                                | str |
			                                str := String streamContents: [ :s | 
				                                       cell
					                                       printContentIn: s
					                                       withContext: context ].
			                                p nextPutAll: str.
			                                p nextPut: Character cr.
			                                str ] ].
	^ textCollection
]

{ #category : #export }
MiNotebookModel >> exportDocumentAt: aFileReference [

	"Export the cell list in a ston file."

	aFileReference ifNil: [ ^ self ].
	aFileReference ensureDelete.
	aFileReference ifNotNil: [ 
		aFileReference writeStreamDo: [ :s | STON put: cellList onStream: s ] ]
]

{ #category : #export }
MiNotebookModel >> exportToHTMLAt: aFileReference [

	"This will use the microdown HTML visitor to export the document to HTML. So your document should respect Microdown specs."
	aFileReference ifNil: [ ^ self ].
	aFileReference writeStreamDo: [ :stream | 
		stream nextPutAll: (MicHTMLVisitor asHTMLString: self generatedDocument) ]
]

{ #category : #export }
MiNotebookModel >> exportToTextAt: aFileReference [

	"Export the generated document, i.e., the resulting text of all cells execution."

	aFileReference ifNil: [ ^ self ].
	aFileReference ensureDelete.
	aFileReference ifNotNil: [ 
		aFileReference writeStreamDo: [ :s | s << generatedDocument ] ]
]

{ #category : #actions }
MiNotebookModel >> followEntity: aMooseModel [

	mooseModel := aMooseModel
]

{ #category : #accessing }
MiNotebookModel >> generatedDocument [

	^ generatedDocument
]

{ #category : #accessing }
MiNotebookModel >> generatedDocument: anObject [

	generatedDocument := anObject.
]

{ #category : #actions }
MiNotebookModel >> importCellsFrom: aFileReference [

	aFileReference ifNil: [ ^ self ].
	cellList := STON fromString: aFileReference contents
]

{ #category : #initialization }
MiNotebookModel >> initialize [

	super initialize.
	needToUpdate := true.
	cellList := OrderedCollection new
]

{ #category : #initialization }
MiNotebookModel >> initializeContext [

	context := CompilationContext new
		           bindings: (self defaultBindings);
		           yourself
]

{ #category : #initialization }
MiNotebookModel >> initializeContextWithStream: aStream [

	context := CompilationContext new
		           bindings: (self defaultBindingsWithStream: aStream);
		           yourself
]

{ #category : #accessing }
MiNotebookModel >> micDocument [

	^ micDocument
]

{ #category : #accessing }
MiNotebookModel >> mooseModel [

	^ mooseModel 
]