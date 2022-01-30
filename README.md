# GitBridge

GitBridge is a project which allow Pharo projects to communicate with the git repository storing them. Once the bridge is made, you can access resources in or information about the repository.

- [Installation](#installation)
- [Quick start](#quick-start)
- [Documentation](#documentation)
- [Version management](#version-management)
- [Smalltalk versions compatibility](#smalltalk-versions-compatibility)
- [Contact](#contact)

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

In order to create a GitBridge to your project, you first need to subclass `GitBridge` and to store your bridge in a package of your project.

```Smalltalk
GitBridge subclass: #MyProjectBridge
	slots: {  }
	classVariables: {  }
	package: 'MyProject'
```

This new bridge needs a class initialization like this one:

```Smalltalk
MyProjectBridge class>>initialize
	SessionManager default registerSystemClassNamed: self name
```

This will allow the bridge to reset some cache at the image startup.

Now that your bridge is created, if it finds an Iceberg repository, associated to its local clone, containing the package in which the bridge is defined, you will be able to use the bridge to access some resources.

For example you can get a file reference to the git folder like this:

```Smalltalk
MyProjectBridge root
```

You can open the git repository by executing:

```Smalltalk
MyProjectBridge openInNativeFileSystem
```

You can get the version of you project by executing:

```Smalltalk
MyProjectBridge versionOrBranchNameWithLastTag
```

For more informations see the following documentation.

## Documentation

You can find the full documentation here : [User documentation](resources/documentation/UserGuide.md).

## Version management 

This project uses semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Smalltalk versions compatibility

| Version 	| Compatible Pharo versions 		|
|-------------	|---------------------------	|
| 1.x.x       	| Pharo 70, 80, 90				|

## Contact

If you have any questions or problems do not hesitate to open an issue or contact cyril (a) ferlicot.me 
