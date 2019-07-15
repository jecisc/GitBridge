"
Description
--------------------

I am a git bridge for the GitBridge project. I mostly serve as example and for tests.
"
Class {
	#name : #GBBridge,
	#superclass : #GitBridge,
	#category : #GitBridge
}

{ #category : #'class initialization' }
GBBridge class >> initialize [
	SessionManager default registerSystemClassNamed: self name
]

{ #category : #accessing }
GBBridge class >> resources [
	^ self root / 'resources'
]

{ #category : #accessing }
GBBridge class >> testResources [
	^ self resources / 'test'
]
