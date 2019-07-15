"
Description
--------------------

I am an abstract superclass for git bridge.

My subclass should includes an initialize class method calling: `SessionManager default registerSystemClassNamed: self name`.

My subclasses will be used as a bridge to a git repository for a project. Then they will be used to access things such has:
- Resources stored in the git repository
- Git informations such the the current version of the project (tag)
- ...

In order to find those information, GitBridge will check the repositories registered in Iceberg and find the first one containing the package storing the GitBridge.

You can add more/different condition by overriding the method #isValidRepository:.

A cache containing the found repository will be created and flush at each startup.

In case no valid repository is present, an error will be thrown.


Examples with GBBrigde
--------------------

	GBBridge root. ""File @ C:\Users\JeCisC\Pharo\GitRepositories\jecisc\GitBridge""

	GBBridge sourceDirectory. ""File @ C:\Users\JeCisC\Pharo\GitRepositories\jecisc\GitBridge\src""

	GBBridge currentBranchName. ""'master'""

	GBBridge tagsOfCurrentCommit. ""#()""

	GBBridge tagsOfClosestTaggedAncestor. ""an Array(IceTag: 'v1.0.0' IceTag: 'v1.x.x')""

	GBBridge version. ""'master'""

	GBBridge closestVersion. ""'v1.0.0'""

	GBBridge versionOrBranchNameWithLastTag. ""'master (from v1.0.0)'""
	
	GBBridge openInNativeFileSystem.
"
Class {
	#name : #GitBridge,
	#superclass : #Object,
	#classInstVars : [
		'repositoryCache'
	],
	#category : #GitBridge
}

{ #category : #versions }
GitBridge class >> closestVersion [
	^ self
		do: [ self tagsOfClosestTaggedAncestor ifEmpty: [ self currentBranchName ] ifNotEmpty: [ :tags | "If there is more than one, take randomly." tags anyOne name ] ]
		onRepositoryProblem: [ 'No repository' ]
]

{ #category : #versions }
GitBridge class >> currentBranchName [
	^ self icebergRepository branchName
]

{ #category : #execution }
GitBridge class >> do: aBlock onRepositoryProblem: anotherBlock [
	^ [ aBlock value ]
		on: GBError
		do: anotherBlock
]

{ #category : #actions }
GitBridge class >> findIcebergRepository [
	^ IceRepository registry detect: [ :each |  self isValidRepository: each ] ifNone: [ GBRepositoryNotFound signalFor: self ]
]

{ #category : #versions }
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

{ #category : #testing }
GitBridge class >> isValidRepository: anIcebergRepository [
	^ anIcebergRepository includesPackageNamed: self package name
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

{ #category : #versions }
GitBridge class >> tagsOfClosestTaggedAncestor [
	self icebergRepository workingCopy referenceCommit commitsDo: [ :commit | commit tags ifNotEmpty: [ :collection | ^ collection ] ].
	
	^ #()
]

{ #category : #versions }
GitBridge class >> tagsOfCurrentCommit [
	^ self icebergRepository workingCopy referenceCommit tags
]

{ #category : #versions }
GitBridge class >> version [
	^ self
		do: [ self tagsOfCurrentCommit ifEmpty: [ self currentBranchName ] ifNotEmpty: [ :tags | "If there is more than one, take randomly." tags anyOne name ] ]
		onRepositoryProblem: [ 'No repository' ]
]

{ #category : #versions }
GitBridge class >> versionOrBranchNameWithLastTag [
	"If there is more than one tag, take randomly."

	^ self
		do: [ self tagsOfCurrentCommit
				ifEmpty: [ self tagsOfClosestTaggedAncestor ifEmpty: [ self currentBranchName ] ifNotEmpty: [ :tags | '{1} (from {2})' format: {self currentBranchName . tags anyOne name} ] ]
				ifNotEmpty: [ :tags | tags anyOne name ] ]
		onRepositoryProblem: [ 'No repository' ]
]
