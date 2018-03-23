# Contirbuting to Project Flogo

Are you interested in contributing to Project Flogo? If so, this doc was created specifically for you! If you’re not ready to start contributing code, no problem, feel free to check out the [documentation issues](https://github.com/TIBCOSoftware/flogo/labels/kind%2Fdocs) and begin my helping enhance the documentation!

Detailed instructions on contributing to the documentation and sharing your projects via the showcase can be found in our documentation, here:

https://tibcosoftware.github.io/flogo/contributing/

If you’re ready and interested to make code contributions, we’ve tried to make the process as easy as possible. First, an automated contributor license agreement (CLA) has been put in place, after your first pull request, you’ll be prompted to sign the agreement, no hassles, easy and integrated right into GitHub. Also, before you begin, take a look at the general guidelines below for contributing.

## How do I make a contribution?

Never made an open source contribution before? Wondering how contributions work in our project? Here's a quick rundown!

* Find an issue that you are interested in addressing or a feature that you would like to add. Look for issues labeled `good first issue`, `kind/help-wanted` if you’re unsure where to begin. Don’t forget to checkout all of the Flogo repositories: [flogo-contrib](https://github.com/TIBCOSoftware/flogo-contrib), [flogo-lib](https://github.com/TIBCOSoftware/flogo-lib), [flogo-cli](https://github.com/TIBCOSoftware/flogo-cli) & [flogo-services](https://github.com/TIBCOSoftware/flogo-services).
* Fork the repository associated with the issue to your local GitHub account. This means that you will have a copy of the repository under github-username/repository-name.
* Clone the repository to your local machine using `git clone https://github.com/github-username/repository-name.git`.
* Create a new branch for your fix using `git checkout -b branch-name-here`.
* Make the appropriate changes for the issue you are trying to address or the feature that you want to add.
* Use `git add insert-paths-of-changed-files-here` to add the file contents of the changed files to the "snapshot" git uses to manage the state of the project, also known as the index.
* Use `git commit -m "Insert a short message of the changes made here"` to store the contents of the index with a descriptive message.
* Push the changes to the remote repository using `git push origin branch-name-here`.
* Submit a pull request to the upstream repository.
* Title the pull request with a short description of the changes made and the issue or bug number associated with your change. For example, you can title an issue like: "Registering mapper functions as outlined in #4352".
* In the description of the pull request, explain the changes that you made, any issues you think exist with the pull request you made, and any questions you have for the maintainers.
* Sign the CLA if you have not yet done so in the past.
* Wait for the pull request to be reviewed by a maintainers.
* Make changes to the pull request if the reviewing maintainer recommends them.
* Congratulations, you’ve contributed to Project Flogo, a celebration is in order!
