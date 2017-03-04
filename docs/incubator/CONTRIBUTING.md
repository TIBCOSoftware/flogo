# Contributing to Flogo
Document with the guidelines for contributing to flogo projects.

## Topics
* [How to contribute](#how-to-contribute)
* [Configure Git and fork the repo](#configure-git-and-fork-the-repo)
* [Reporting Issues](#reporting-issues)
* [Fixing Issues](#fixing-issues)
* [Rebase your branch](#rebase-your-branch)
* [Todo list](#todo-list)

## TODO list
TODO List of tasks to finish before we go public with this contribution guidelines

* Get a CLA approved from Legal. See http://oss-watch.ac.uk/resources/cla and samples up at Google's or RedHat's OSS portals.
* Define testing requirements [here](#test-changes).
* Define how to contribute design proposals.
* List communication channels for users and contributers.
* Define code of conduct. See https://github.com/cncf/foundation/blob/master/code-of-conduct.md.
* Define code style.
* Define how to claim an issue (need to define a flogo bot here)

## How to contribute
There are many different ways to contribute to flogo:

* Report an issue: for details click [here](#reporting-issues)
* Fix an existing issue: for details click [here](#fixing-issues)

## Configure Git and fork the repo.
This is a quick guide on how to configure your [Git](https://git-scm.com/) and how to fork the project for changing and contributing code.

1.- Open a browser and log into GitHub with your account.

2.- Browse to the repository you want to contribute to (for example: https://github.com/TIBCOSoftware/flogo-cli)

3.- Click the “Fork” button in the upper right corner of the GitHub page.

4.- Create a new directory (for example my_flogo_cli)
```
$ mkdir my_flogo_cli
```

5.- [Optional] Create language specific structure of new project (for example: for Golang projects)
[TODO: Improve these steps by pointing at the installation or better]
```
$ cd my_flogo_cli
$ mkdir src/github.com/TIBCOSoftware
$ cd src/github.com/TIBCOSoftware
```

6.- Clone the ORIGINAL project you want to contribute to (Note, yes clone the Original, NOT your fork. This is IMPORTANT)
```
$ git clone https://github.com/TIBCOSoftware/flogo-cli.git
```

7.- Set your signature 
[TODO: discuss with legal, possible template: https://docs.docker.com/opensource/project/set-up-git/#/task-2-set-your-signature-and-an-upstream-remote]

8.- [Optional]Setup your git repository details, only needed if you don't have global settings
```
$ git config --local user.name "FirstName LastName"
$ git config --local user.email "emailname@mycompany.com"
```

9.- Set up your remotes
```
$ git remote remove origin
$ git remote add origin https://github.com/my_git_account_name/flogo-cli.git
$ git remote add upstream https://github.com/TIBCOSoftware/flogo-cli.git
```

## Reporting Issues
One way of contributing to the project is to file a detailed report when you encounter an issue. We always appreciate a well-written, thorough bug report, and will thank you for it!

Please check that the issue you are reporting does not exist already. If it happens to already exist, you can click the "subscribe" button on that issue to receive notifications.

When reporting issues, always include:

* The steps required to reproduce the problem if possible and applicable.

## Fixing Issues
One way of contributing to the project is to fix an existing issue.

If you haven't done it already, you will need to configure git and fork the repo as explained [here](#configure-git-and-fork-the-repo).

1.- Find and claim an issue 
[TODO before publishing to public repos, define detailed steps of how to do this, possible template: https://docs.docker.com/opensource/workflow/find-an-issue/]

2.- Work on the issue
You should test your changes following [this guideline](#test-changes)

3.- Add and commit your changes to your branch

4.- Rebase your branch as defined [here](#rebase-your-branch)

## Test changes
TODO: Define testing requirements

## Rebase your branch
Always rebase and squash your commits before making a pull request.

1.- Checkout your feature branch in your local flogo-fork repository.
This is the branch associated with your request.

2.- Fetch any last minute changes from TIBCOSoftware/flogo-lib
```
$ git fetch upstream master
From https://github.com/TIBCOSoftware/flogo-cli
 * branch            master     -> FETCH_HEAD
 ```
 
3.- Start an interactive rebase.
```
$ git rebase -i upstream/master
```

4.- Rebase opens an editor with a list of commits.
```
 pick 2d87d98 Fix exception
 pick 53e4678 Fix another thing
 pick 5ce23be Fix yet another thing
```
 
5.- Replace the pick keyword with squash on all but the first commit.
```
 pick 2d87d98 Fix exception
 squash 53e4678 Fix another thing
 squash 5ce23be Fix yet another thing
```
After you save the changes and quit from the editor, git starts the rebase, reporting the progress along the way. Sometimes your changes can conflict with the work of others. If git encounters a conflict, it stops the rebase, and prints guidance for how to correct the conflict.

6.- Edit and save your commit message.
```
$ git commit -s -m "Add commit with signature example"
```
Make sure your message includes your signature.

7.- Force push any changes to your fork on GitHub.
```
$ git push -f origin XXXX-my-branch-here
```