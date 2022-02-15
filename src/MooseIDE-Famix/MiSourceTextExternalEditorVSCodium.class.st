Class {
	#name : #MiSourceTextExternalEditorVSCodium,
	#superclass : #MiSourceTextFileExternalEditor,
	#category : #'MooseIDE-Famix-SourceText'
}

{ #category : #'as yet unclassified' }
MiSourceTextExternalEditorVSCodium class >> editorName [
	^'VS Codium'
]

{ #category : #'file support' }
MiSourceTextExternalEditorVSCodium >> openFile: aFileReference [
	LibC uniqueInstance runCommand: 'codium ' , aFileReference fullName 
]