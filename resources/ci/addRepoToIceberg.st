| location |

"Because the working directory behavior changed in P7"
location := SystemVersion current major < 7 ifTrue: [ '../../build/jecisc/GitBridge' asFileReference ] ifFalse: [ '.' asFileReference ].

(IceRepositoryCreator new
	location: location;
	subdirectory: 'src';
	createRepository) register