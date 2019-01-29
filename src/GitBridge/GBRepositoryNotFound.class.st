Class {
	#name : #GBRepositoryNotFound,
	#superclass : #GBError,
	#category : #GitBridge
}

{ #category : #signalling }
GBRepositoryNotFound class >> signalFor: aGitBridge [
	^ self new
		bridge: aGitBridge;
		signal
]

{ #category : #accessing }
GBRepositoryNotFound >> messageText [
	^ 'Bridge not found. Associate an Iceberg repository containing the package ' , self bridge package name , ' to use the bridge.'
]
