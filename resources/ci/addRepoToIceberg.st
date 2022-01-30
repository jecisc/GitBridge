| repo |
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

'Create 2' traceCr.

repo := repo createRepository.

'Register' traceCr.

repo register.
	
'End pre script' traceCr