Class {
	#name : #GBError,
	#superclass : #Error,
	#instVars : [
		'bridge'
	],
	#category : #GitBridge
}

{ #category : #accessing }
GBError >> bridge [
	^ bridge
]

{ #category : #accessing }
GBError >> bridge: anObject [
	bridge := anObject
]
