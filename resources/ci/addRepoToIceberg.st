'Execute pre testing scripts' traceCr.

'.' asFileReference entries traceCr.

(IceRepositoryCreator new
	location: '.' asFileReference;
	subdirectory: 'src';
	createRepository) register