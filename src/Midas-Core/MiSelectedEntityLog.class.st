Class {
	#name : #MiSelectedEntityLog,
	#superclass : #MiLog,
	#instVars : [
		'entity'
	],
	#category : #'Midas-Core-Logger'
}

{ #category : #accessing }
MiSelectedEntityLog class >> entity: aSelectedEntity [
	^ self new entity: aSelectedEntity
]

{ #category : #activation }
MiSelectedEntityLog >> activate [
	self application refreshBrowsersWith: self entity
]

{ #category : #accessing }
MiSelectedEntityLog >> entity [
	^ entity
]

{ #category : #accessing }
MiSelectedEntityLog >> entity: anObject [
	entity := anObject.
	self activate
]

{ #category : #printing }
MiSelectedEntityLog >> printOn: aStream [
	aStream
		nextPutAll: entity class name
]