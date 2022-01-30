'Execute pre testing scripts' traceCr.

FileReference workingDirectory pathString traceCr.

(IceRepositoryCreator new
	location: '.' asFileReference;
	subdirectory: 'src';
	createRepository) register