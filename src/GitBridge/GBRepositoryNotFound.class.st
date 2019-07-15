"
Description
--------------------

I am an error raised when no repository in Iceberg correspond to the current bridge.

Examples
--------------------

	GBRepositoryNotFound signalFor: GBBridge
"
Class {
	#name : #GBRepositoryNotFound,
	#superclass : #GBError,
	#category : #GitBridge
}

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
