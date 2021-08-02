"
I am the abstract class for all the configuration presenter for the FamixQueries
"
Class {
	#name : #MiQueryConfigurationPresenter,
	#superclass : #MiPresenter,
	#instVars : [
		'query'
	],
	#category : #'MooseIDE-NewTools-Queries Browser configuration'
}

{ #category : #specs }
MiQueryConfigurationPresenter class >> defaultSpec [

	^ SpBoxLayout newHorizontal
]

{ #category : #layout }
MiQueryConfigurationPresenter >> buildLayout [

	self layout: self class defaultSpec
]

{ #category : #'api - actions' }
MiQueryConfigurationPresenter >> disable [

	"Disable the presenters that had been instantiated."

	self presenters
		reject: [ :subPresenter | 
			{ 
				SpNullPresenter.
				MiNoPossibleQueryPresenter } includes: subPresenter class ]
		thenDo: #disable
]

{ #category : #'api - actions' }
MiQueryConfigurationPresenter >> enable [

	"Enable the presenters that had been instantiated."

	self presenters
		reject: [ :subPresenter | 
			{ 
				SpNullPresenter.
				MiNoPossibleQueryPresenter } includes: subPresenter class ]
		thenDo: #enable
]

{ #category : #accessing }
MiQueryConfigurationPresenter >> initialize [

	super initialize.
	self buildLayout
]

{ #category : #update }
MiQueryConfigurationPresenter >> noParameterMessage: aParameterName [

	^ self instantiate: MiNoPossibleQueryPresenter on: aParameterName
]

{ #category : #transmissions }
MiQueryConfigurationPresenter >> notifyQueryChanged [

	owner updateFromConfiguration
]

{ #category : #accessing }
MiQueryConfigurationPresenter >> query [
	^ query
]

{ #category : #'api - actions' }
MiQueryConfigurationPresenter >> queryPresentersListChanged [

	"This method is trigerred when the list of queries presenters in MiQueryBuilderPresenter change. This can happen when the user adds or removes a new query from the queries list.
	The default behavior is to do nothing. This method must be overriden if a subclass wants to do something specific"

	
]

{ #category : #'accessing - model' }
MiQueryConfigurationPresenter >> setModelBeforeInitialization: aQuery [
	query := aQuery
]

{ #category : #update }
MiQueryConfigurationPresenter >> updateForQuery: aQuery [
	query := aQuery
]