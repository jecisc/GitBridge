Class {
	#name : #GBRepositoryWithoutLocalRepository,
	#superclass : #GBError,
	#category : #GitBridge
}

{ #category : #signalling }
GBRepositoryWithoutLocalRepository class >> signalFor: aGitBridge [
	^ self new
		bridge: aGitBridge;
		signal
]

{ #category : #accessing }
GBRepositoryWithoutLocalRepository >> messageText [
	^ 'The iceberg repository responsible of the bridge does not have a local repository associated. Please provide a local repository in Iceberg to proceed.'
]
