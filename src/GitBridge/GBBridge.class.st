Class {
	#name : #GBBridge,
	#superclass : #GitBridge,
	#category : #GitBridge
}

{ #category : #accessing }
GBBridge class >> resources [
	^ self root / 'resources'
]

{ #category : #accessing }
GBBridge class >> testResources [
	^ self resources / 'test'
]
