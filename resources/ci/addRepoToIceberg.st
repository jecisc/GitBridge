'Execute pre testing scripts' traceCr.

FileLocator workingDirectory pathString traceCr.

(IceRepositoryCreator new
	location: '.' asFileReference;
	subdirectory: 'src';
	createRepository) register