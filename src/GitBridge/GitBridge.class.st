Class {
	#name : #GitBridge,
	#superclass : #Object,
	#classInstVars : [
		'repositoryCache'
	],
	#category : #GitBridge
}

{ #category : #assessing }
GitBridge class >> closestVersion [
	^ self
		do: [ self tagsOfClosestTaggedAncestor ifEmpty: [ self currentBranchName ] ifNotEmpty: [ :tags | "If there is more than one, take randomly." tags anyOne name ] ]
		onRepositoryProblem: [ 'No repository' ]
]

{ #category : #assessing }
GitBridge class >> currentBranchName [
	^ self icebergRepository branchName
]

{ #category : #execution }
GitBridge class >> do: aBlock onRepositoryProblem: anotherBlock [
	^ [ aBlock value ]
		on: GBError
		do: anotherBlock
]

{ #category : #assessing }
GitBridge class >> findIcebergRepository [
	^ IceRepository registry detect: [ :each | each includesPackageNamed: self package name ] ifNone: [ GBRepositoryNotFound signalFor: self ]
]

{ #category : #assessing }
GitBridge class >> gitTags [
	^ self icebergRepository tags
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

{ #category : #actions }
GitBridge class >> openInNativeFileSystem [
	self root openInNativeBrowser
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

{ #category : #assessing }
GitBridge class >> sourceDirectory [
	^ self icebergRepository subdirectoryReference
]

{ #category : #'system startup' }
GitBridge class >> startUp [
	self reset
]

{ #category : #assessing }
GitBridge class >> tagsOfClosestTaggedAncestor [
	self icebergRepository workingCopy referenceCommit commitsDo: [ :commit | commit tags ifNotEmpty: [ :collection | ^ collection ] ].
	
	^ #()
]

{ #category : #assessing }
GitBridge class >> tagsOfCurrentCommit [
	^ self icebergRepository workingCopy referenceCommit tags
]

{ #category : #TODO }
GitBridge class >> todo [
	self flag: #todo.
	
	"
	- Open natively
	- Last tag
	- Current tag
	- Manage multiple repo
	- Add way to add conditions
	- Tests"
]

{ #category : #assessing }
GitBridge class >> version [
	^ self
		do: [ self tagsOfCurrentCommit ifEmpty: [ self currentBranchName ] ifNotEmpty: [ :tags | "If there is more than one, take randomly." tags anyOne name ] ]
		onRepositoryProblem: [ 'No repository' ]
]

{ #category : #assessing }
GitBridge class >> versionOrBranchNameWithLastTag [
	"If there is more than one tag, take randomly."

	^ self
		do: [ self tagsOfCurrentCommit
				ifEmpty: [ self tagsOfClosestTaggedAncestor ifEmpty: [ self currentBranchName ] ifNotEmpty: [ :tags | '{1} (from {2})' format: {self currentBranchName . tags anyOne name} ] ]
				ifNotEmpty: [ :tags | tags anyOne name ] ]
		onRepositoryProblem: [ 'No repository' ]
]
