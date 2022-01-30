| repo head |
'Execute pre testing scripts' traceCr.

'.' asFileReference entries traceCr.

'Init' traceCr.

repo := IceRepositoryCreator new
	location: '.' asFileReference;
	subdirectory: 'src';
	yourself.
	
'CREATE' traceCr.

repo validate. 
repo isCloning traceCr.

	repo repository location: repo locationToUse.
	
	
'CREATE2' traceCr.
	repo repository pluginManager repositoryWillBeCreated: repo repository.
		
'CREATE3' traceCr.	


head := repo repository workingCopy repository head.
head name traceCr.
head commitsDo: [:c | c id traceCr ].

	repo repository workingCopy initializePackagesFromRepository.
	
'CREATE4' traceCr.
	repo doEnsureProject. 	

'CREATE5' traceCr.
	repo repository pluginManager repositoryWasCreated: repo repository.
	
'CREATE6' traceCr.
	repo := repo repository.	

'Register' traceCr.

repo register.
	
'End pre script' traceCr