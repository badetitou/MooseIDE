"
Represents a generic setting item. A setting item holds a value and necessary information to display the item on one line in a MiSettingsManager:

- label for the settingItem
- presenter for showing/changing the setting value
- help on the settingItem

Class side has some factory methods
"
Class {
	#name : #MiAbstractSettingItem,
	#superclass : #Object,
	#instVars : [
		'label',
		'help',
		'presenter',
		'oldValue'
	],
	#category : #'MooseIDE-Core-Settings'
}

{ #category : #'instance creation' }
MiAbstractSettingItem class >> droplistSetting [
	^MiDroplistSettingItem new
		yourself
]

{ #category : #'instance creation' }
MiAbstractSettingItem class >> integerSetting [
	^MiTextSettingItem new
		integerValue ;
		yourself
]

{ #category : #'api - building' }
MiAbstractSettingItem >> buildLayout [

	oldValue := self getValue.
	^ SpBoxLayout newLeftToRight
		  add: (label asPresenter
				   help: help;
				   yourself);
		  add: self presenter;
		  yourself
]

{ #category : #action }
MiAbstractSettingItem >> confirmValue [

	oldValue := self getValue
]

{ #category : #accessing }
MiAbstractSettingItem >> getValue [

	self subclassResponsibility
]

{ #category : #accessing }
MiAbstractSettingItem >> help [

	^ help
]

{ #category : #accessing }
MiAbstractSettingItem >> help: anObject [

	help := anObject
]

{ #category : #accessing }
MiAbstractSettingItem >> label [

	^ label
]

{ #category : #accessing }
MiAbstractSettingItem >> label: anObject [

	label := anObject
]

{ #category : #accessing }
MiAbstractSettingItem >> owner: aPresenter [

	self presenter owner: aPresenter
]

{ #category : #accessing }
MiAbstractSettingItem >> presenter [

	^ presenter
]

{ #category : #action }
MiAbstractSettingItem >> resetValue [

	self setValue: oldValue
]

{ #category : #accessing }
MiAbstractSettingItem >> setValue: anObject [

	self subclassResponsibility
]