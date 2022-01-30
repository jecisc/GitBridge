'Execute pre testing scripts' traceCr.

FileLocator workingDirectory asFileReference entries traceCr.

(IceRepositoryCreator new
	location: '.' asFileReference;
	subdirectory: 'src';
	createRepository) register