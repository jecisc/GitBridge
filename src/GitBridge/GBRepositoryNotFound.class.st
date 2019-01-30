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
	^ String
		streamContents: [ :stream | 
			stream
				<< 'Bridge not found. Associate an Iceberg repository containing the package ';
				<< self bridge package name;
				<< ' to use the bridge.';
				lf;
				<< 'Available repositories:';
				lf.
			IceRepository registry do: [ :each | stream << '- ' << each name ] separatedBy: [ stream lf ] ]
]
