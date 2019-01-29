Class {
	#name : #GitBridge,
	#superclass : #Object,
	#classInstVars : [
		'repositoryCache'
	],
	#category : #GitBridge
}

{ #category : #assessing }
GitBridge class >> findIcebergRepository [
	^ IceRepository registry detect: [ :each | each includesPackageNamed: self package name ] ifNone: [ GBRepositoryNotFound signalFor: self ]
]

{ #category : #assessing }
GitBridge class >> icebergRepository [
	^ repositoryCache ifNil: [ repositoryCache := self findIcebergRepository ]
]

{ #category : #'class initialization' }
GitBridge class >> initialize [
	SessionManager default registerSystemClassNamed: self name
]

{ #category : #testing }
GitBridge class >> isAbstract [
	^ self = GitBridge
]

{ #category : #'class initialization' }
GitBridge class >> reset [
	repositoryCache := nil
]

{ #category : #assessing }
GitBridge class >> root [
	| location |
	location := self icebergRepository location.
	(location isNil or: [ location exists not ]) ifTrue: [ GBRepositoryWithoutLocalRepository signalFor: self ].
	^ location
]

{ #category : #'system startup' }
GitBridge class >> startUp [
	self reset
]

{ #category : #TODO }
GitBridge class >> todo [
	self flag: #todo.
	
	"
	- Open natively
	- Last tag
	- Current tag
	- Manage multiple repo
	- Add way to add conditions"
]
