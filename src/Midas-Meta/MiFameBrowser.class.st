Class {
	#name : #MiFameBrowser,
	#superclass : #MiAbstractBrowser,
	#instVars : [
		'fameDescription'
	],
	#category : #'Midas-Meta-FameBrowser'
}

{ #category : #specs }
MiFameBrowser class >> defaultSpec [
	^ super defaultSpec
		add: #fameDescription;
		yourself
]

{ #category : #specs }
MiFameBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Fame)
		parent: self toolbarMetaName;
		label: 'Fame browser';
		icon: (self iconNamed: #mooseFame);
		order: 4.0;
		action: [ self runMe ]
]

{ #category : #specs }
MiFameBrowser class >> runMe [
	<script>
	^ super runMe
]

{ #category : #initialization }
MiFameBrowser >> accept: anObject [
	^ anObject isKindOf: MooseEntity 
]

{ #category : #initialization }
MiFameBrowser >> followAction [
	(self accept: toSelect)
		ifFalse: [ ^ self ].
	self forEntity: toSelect
]

{ #category : #initialization }
MiFameBrowser >> forEntity: anEntity [
	fameDescription items: anEntity mooseDescription allComplexProperties.
]

{ #category : #initialization }
MiFameBrowser >> initializePresenters [
	super initializePresenters.
	self flag: 'This currently duplicated code from Midas-NewTools. We have to thing about a good way to integrate all browser inside the inspector'.
	fameDescription := self newTable.
	fameDescription
		items: (self model mooseDescription allComplexProperties sorted: #name ascending);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: [ :item | item name ]) yourself;
		addColumn: (SpStringTableColumn title: 'Type' evaluated: [ :item | item type name ]) yourself;
		addColumn: (SpStringTableColumn title: 'Opposite' evaluated: [ :item | item opposite ifNil: [ '' ] ifNotNil: [ :opposite | opposite name ] ]) yourself;
		addColumn: (SpStringTableColumn title: 'Derived?' evaluated: [ :item | item isDerived ]) yourself;
		addColumn: (SpStringTableColumn title: 'Container?' evaluated: [ :item | item isContainer ]) yourself;
		addColumn: (SpStringTableColumn title: 'IsTarget?' evaluated: [ :item | item isTarget ]) yourself;
		addColumn: (SpStringTableColumn title: 'IsSource?' evaluated: [ :item | item isSource ]) yourself;
		beResizable
]

{ #category : #initialization }
MiFameBrowser >> title [
	^ 'Fame Browser'
]