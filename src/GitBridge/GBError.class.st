"
Description
--------------------

I am a common superclass for all GitBridge errors.
"
Class {
	#name : #GBError,
	#superclass : #Error,
	#instVars : [
		'bridge'
	],
	#category : #GitBridge
}

{ #category : #signalling }
GBError class >> signalFor: aGitBridge [
	^ self new
		bridge: aGitBridge;
		signal
]

{ #category : #accessing }
GBError >> bridge [
	^ bridge
]

{ #category : #accessing }
GBError >> bridge: anObject [
	bridge := anObject
]
