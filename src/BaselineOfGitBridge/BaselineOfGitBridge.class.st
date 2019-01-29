Class {
	#name : #BaselineOfGitBridge,
	#superclass : #BaselineOf,
	#category : #BaselineOfGitBridge
}

{ #category : #baselines }
BaselineOfGitBridge >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'GitBridge' ]
]

{ #category : #accessing }
BaselineOfGitBridge >> projectClass [
	^ MetacelloCypressBaselineProject
]
