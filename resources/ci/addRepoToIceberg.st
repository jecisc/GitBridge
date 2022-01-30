'Execute pre testing scripts' traceCs.

(IceRepositoryCreator new
	location: '.' asFileReference;
	subdirectory: 'src';
	createRepository) register