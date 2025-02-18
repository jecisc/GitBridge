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
		do: [ "Packages"
			spec
				package: 'GitBridge';
				package: 'GitBridge-Tests' with: [ spec requires: #('GitBridge') ].

			"Group"
			spec
				group: 'Minimal' with: #('GitBridge');
				group: 'Tests' with: #('GitBridge-Tests') ].

	spec
		for: #'pharo7.x'
		do: [ self nativeBrowser: spec.
			spec package: 'GitBridge' with: [ spec requires: #('NativeBrowser') ] ]
]

{ #category : #dependencies }
BaselineOfGitBridge >> nativeBrowser: spec [
	spec baseline: 'NativeBrowser' with: [ spec repository: 'github://jecisc/Native-Browser:v1.x.x/src' ]
]

{ #category : #accessing }
BaselineOfGitBridge >> projectClass [
	^ self class environment at: #MetacelloCypressBaselineProject ifAbsent: [ super projectClass ]
]
