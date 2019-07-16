# User documentation of GitBridge

GitBridge is a project allow Pharo projects to communicate with the git repository storing them. Once the bridge is made, you can access resources or informations about the repository.

This documentation will cover the creation of a GitBridge for your project and all the different features it propose.

> Some notes like this one will be present in the documentation. They will give implementation details since there is not enough material to do a full page on implementation details.

- [Create a bridge for your project](#create-a-bridge-for-your-project)
  * [Create a simple bridge](#create-a-simple-bridge)
  * [Add conditions on the bridge selection](#add-conditions-on-the-bridge-selection)
- [Access resources and informations](#access-resources-and-informations)
  * [Access to local resources](#access-to-local-resources)
  * [Get informations of the project version](#get-informations-of-the-project-version)
  * [Actions](#actions)
- [Use GitBridge in CI environment](#use-gitbridge-in-ci-environment)

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

It can often be useful to display version infos for a project. Git bridge allows one to access such infos. Here is a description of the API:
- `#gitTags` : Return the list of all tags of the project.
- `#currentBranchName` : Return the name of the current branch.
- `#tagsOfCurrentCommit` : Return the tags of the current commit. If none, return an empty array.
- `#tagsOfClosestTaggedAncestor` : Return the tags of the closest ancestor with tags.
- `#version` : Return a string which can either be a tag name of the current commit or a branch name in case the commit has no tag.
- `#closestVersion` :  Return a string which can either be the tag name of the closest tagged ancestor commit or a branch name in case the project has no tag.
- `#versionOrBranchNameWithLastTag` : Return the name of a tag of the current commit, in case there is none, return the name of the current branch with the tag name of the closest ancestor in parenthesis.

Example: 

```Smalltalk
MyProjectBridge gitTags. "an Array(IceTag: 'v0.1.0' IceTag: 'v1.0.0' IceTag: 'v1.0.x' IceTag: 'v1.x.x')"

MyProjectBridge currentBranchName. "'master'"

MyProjectBridge tagsOfCurrentCommit. "#()"

MyProjectBridge tagsOfClosestTaggedAncestor. "an Array(IceTag: 'v1.0.0' IceTag: 'v1.0.x' IceTag: 'v1.x.x')"

MyProjectBridge version. "'master'"

MyProjectBridge closestVersion. "'v1.0.0'"

MyProjectBridge versionOrBranchNameWithLastTag. "'master (from v1.0.0)'"
```

### Actions

GitBridge can also be used to unable some actions.

For now, only one action is possible: open in the Native file browser the root folder of the git repository.

```Smalltalk
MyProjectBridge openInNativeFileSystem
```

## Use GitBridge in CI environment

If you use your Git Bridge to access resources in tests, you might need some extra setup with your continuous integration.

For Jenkins, if you use a bash script, you might not need any extra step since you will probably load your project with the Iceberg integration enabled.

In Travis, if you use SmalltalkCI, you will need to register your repository in Iceberg since SmalltalkCI disable the Metacello integration of Iceberg.

You can do this via a pre testing script in your smalltalk.ston file. For example:

```Smalltalk
SmalltalkCISpec {
  #loading : [
    SCIMetacelloLoadSpec {
      #baseline : 'GitBridge',
      #directory : 'src'
    }
  ],
  #preTesting : SCICustomScript {
    #path : 'resources/ci/addRepoToIceberg.st'
  }
}
```

The script will look like this:

```Smalltalk
(IceRepositoryCreator new
	location: '.' asFileReference;
	subdirectory: 'src';
	createRepository) register
```

Where `src` will need to be changed to correspond to your code subdirectory.
