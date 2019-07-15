# User documentation of GitBridge

GitBridge is a project allow Pharo projects to communicate with the git repository storing them. Once the bridge is made, you can access resources or informations about the repository.

This documentation will cover the creation of a GitBridge for your project and all the different features it propose.

> Some notes like this one will be present in the documentation. They will give implementation details since there is not enough material to do a full page on implementation details.

## Create a bridge for your project

### Create a simple bridge

In order to create a simple GitBridge to your project, you first need to subclass `GitBridge` and to store your bridge in a package of your project.

```Smalltalk
GitBridge subclass: #MyProjectBridge
	slots: {  }
	classVariables: {  }
	package: 'MyProject'
```

This new bridge need a class initialization like this one:

```Smalltalk
MyProjectBridge class>>initialize
	SessionManager default registerSystemClassNamed: self name
```

This will allow the bridge to reset some cache at the image startup.

> When you access your bridge for the first time after you launched your image, the Iceberg repository linked to your project will be cached. By registering your bridge to the SessionManager you will provide a way to your image to clear this cache at startup in case you moved your image. If you need to clear the cache yourself, you can call the method `#reset` on your git bridge.

By default, a bridge will be made to the first Iceberg repository registered meeting two conditions:
- The repository need to contain the package in which the bridge is defined (here `MyProject`)
- The repository need to have a local clone of the project

In case none of those conditions are met, special exceptions will be launched: `GBRepositoryNotFound` or `GBRepositoryWithoutLocalRepository`.

### Add conditions on the bridge selection

The previous section show how to create bridges for simple projects, but sometime it is not enough. For example, if the package containing your bridge is present in multiple project, you might want to add more conditions to your repository lookup.

This is possible in two way.

The first one is to override the method `#isValideRepository:`. This method will be called with each iceberg repositories as parameter. In case we want to select the first repository containing the package of the bridge but that does not contain a package `BaselineOfPharo` we can do:

```Smalltalk
MyProjectBridge class>>isValidRepository: anIcebergRepository
	^ (super isValidRepository: anIcebergRepository) and: [ (anIcebergRepository includesPackageNamed: 'BaselineOfPharo') not ]
```

The second way is to override the method `findIcebergRepository` to create your own lookup.

## Access resources and informations

Once your bridge created, you have the possibility to access divers informations.

### Access to local resources

One of the main feature of GitBridge is to be able to access to local resources. Before Pharo improved its git integration, we used Monticello to store code. Monticello did not allow the developeur to store files. Thus, a lot of project stored files in memory or downloaded them during the installation. Now, with GitBridge, we can just store them in a git repository and access them from the image via a GitBridge.

This can be useful in many case such has:
- Storing files used as test resources
- Access to CSS, JS or image files for web applications
- Storing documentation in Markdown format to get a nice rendering in Github/Bitbucket/Gitlab
- ...

Access to those files can be easily done via the GitBridge:

```Smalltalk
MyProjectBridge root.	"Return a FileReference to the root folder of the git repository."

MyProjectBridge sourceDirectory.	"Return a FileReference to the source directory of the project."
```

You can also create your own access methods such as:

```Smalltalk
MyProjectBridge class>>resources
	^ self root / 'resources'
```

### Get informations of the project version

TODO

### Actions

TODO

## Use GitBridge in CI environment

TODO