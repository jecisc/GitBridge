| repo |
'Execute pre testing scripts' traceCr.

'.' asFileReference entries traceCr.

'Init' traceCr.

repo := IceRepositoryCreator new
	location: '.' asFileReference;
	subdirectory: 'src';
	yourself.
	
'CREATE' traceCr.


repo := repo createRepository.

'Register' traceCr.

repo register.
	
'End pre script' traceCr