# GitBridge

[![Build Status](https://travis-ci.org/jecisc/GitBridge.svg?branch=master)](https://travis-ci.org/jecisc/GitBridge)

GitBridge is a project allow Pharo projects to communicate with the git repository storing them. Once the bridge is made, you can access ressources or informations about the repository.

## Installation

To install GitBridge in your Pharo image execute:

```Smalltalk
    Metacello new
    	githubUser: 'jecisc' project: 'GitBridge' commitish: 'v1.x.x' path: 'src';
    	baseline: 'GitBridge';
    	load
```

To add it to your baseline:

```Smalltalk
    spec
    	baseline: 'GitBridge'
    	with: [ spec repository: 'github://jecisc/GitBridge:v1.x.x/src' ]
```

Note that you can replace the #v1.x.x by another branch such as #development or a tag such as #v1.0.0, #v1.? or #v1.1.?.

## Quick start

TODO

## Documentation

TODO

Documentation is split into separate links as follows:
* [User documentation](documentation/UserGuide.md) 
* [Developer documentation](documentation/DevelopmentGuide.md)

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Smalltalk versions compatibility

| Version 	| Compatible Pharo versions 		|
|-------------	|---------------------------	|
| 1.x.x       	| Pharo 70, 80					|

## Contact

If you have any questions or problems do not hesitate to open an issue or contact cyril (a) ferlicot.me 
