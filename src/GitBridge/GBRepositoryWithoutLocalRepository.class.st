"
Description
--------------------

I am an error raised when an Iceberg corresponding to the current bridge is found but does not have a local repository.

Examples
--------------------

	GBRepositoryWithoutLocalRepository signalFor: GBBridge
"
Class {
	#name : #GBRepositoryWithoutLocalRepository,
	#superclass : #GBError,
	#category : #GitBridge
}

{ #category : #accessing }
GBRepositoryWithoutLocalRepository >> messageText [
	^ 'The iceberg repository responsible of the bridge does not have a local repository associated. Please provide a local repository in Iceberg to proceed.'
]
