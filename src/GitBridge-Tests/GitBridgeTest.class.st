Class {
	#name : #GitBridgeTest,
	#superclass : #TestCase,
	#instVars : [
		'bridge'
	],
	#category : #'GitBridge-Tests'
}

{ #category : #running }
GitBridgeTest >> setUp [
	super setUp.
	bridge := GBBridge
]

{ #category : #tests }
GitBridgeTest >> testGitTags [
	self assert: (bridge gitTags anySatisfy: [ :tag | tag name = 'tagForTests' ])
]

{ #category : #tests }
GitBridgeTest >> testIcebergRepository [
	self shouldnt: [ bridge icebergRepository ] raise: Error.
	self assert: (bridge testResources / 'testFile.txt') contents equals: 'test'
]

{ #category : #tests }
GitBridgeTest >> testRoot [
	self assert: bridge root exists.
	self assert: ((bridge root entries collect: #basename) includesAll: #('README.md' 'resources' 'src'))
]

{ #category : #tests }
GitBridgeTest >> testSourceDirectory [
	self assert: bridge sourceDirectory exists.
	self assert: bridge sourceDirectory basename equals: 'src'
]

{ #category : #tests }
GitBridgeTest >> testTagsOfClosestTaggedAncestor [
	self shouldnt: [ bridge tagsOfClosestTaggedAncestor ] raise: Error.
	self assert: bridge tagsOfClosestTaggedAncestor isCollection
]

{ #category : #tests }
GitBridgeTest >> testTagsOfCurrentCommit [
	self shouldnt: [ bridge tagsOfCurrentCommit ] raise: Error.
	self assert: bridge tagsOfCurrentCommit isCollection
]
