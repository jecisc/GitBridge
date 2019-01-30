Class {
	#name : #BaselineOfGitBridge,
	#superclass : #BaselineOf,
	#category : #BaselineOfGitBridge
}

{ #category : #baselines }
BaselineOfGitBridge >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec
				package: 'GitBridge';
				package: 'GitBridge-Tests' with: [ spec requires: #('GitBridge') ].

			"Group"
			spec
				group: 'Minimal' with: #('GitBridge');
				group: 'Tests' with: #('GitBridge-Tests') ]
]

{ #category : #accessing }
BaselineOfGitBridge >> projectClass [
	^ MetacelloCypressBaselineProject
]
