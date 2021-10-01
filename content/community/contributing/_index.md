---
title: How to contribute to Eclipse Keyple® project
linktitle: Contributing
summary: Find out how to contribute to the Keyple project and how it can benefit your organization.
type: book
toc: true
weight: 1
---

---
## Types of contributions

Thanks for your interest in the **Eclipse Keyple®** project.

There are several ways to contribute to the project:
* **Propose a fix** for a problem that is already known or that you have identified.
  In this case you will have to notify the issue in the repository where the problem appeared and reference the issue in all the other repositories affected by the fix.
* **Propose the creation of a new component**.
  In this case you will first have to create an issue in the repository https://github.com/eclipse/keyple to justify the need and request the creation of a new repository, wait for the issue to be resolved by the decision of the committers, and then create an issue in the new repository signifying the start of development of the new component.

---
## Eclipse Contributor Agreement

Before your contribution can be accepted by the project team contributors must
electronically [sign](https://accounts.eclipse.org/user/login?destination=user/eca) the Eclipse Contributor Agreement (ECA).

* http://www.eclipse.org/legal/ECA.php

Commits that are provided by non-committers must have a Signed-off-by field in
the footer indicating that the author is aware of the terms by which the
contribution has been provided to the project. The non-committer must
additionally have an Eclipse Foundation account and must have a signed Eclipse
Contributor Agreement (ECA) on file.

For more information, please see the Eclipse Committer Handbook:
https://www.eclipse.org/projects/handbook/#contributing

---
## Contributing via fork

1. Check if there is already a GitHub issue for what you want to work on or create one.
2. Announce in the comments section that you want to work on the issue. Also describe the solution you want to implement. 
To improve the chances for your contribution to be accepted, you'll want to wait for the feedback of the committers.
3. Fork the repository.
4. Create a new branch from `main` for your changes. Name it after the issue number, e.g. `#XXX_[description_of_changes]`.
5. Implement your changes.
6. Rebase on `main`.
7. Run `./gradlew spotlessApply` to format the code and add licence headers to the files.
8. Run `./gradlew build` (to check code formatting and run tests)
9. Commit your changes using the `-s` flag in order to add a **Signed-off-by** footer as mentioned above and use the same email address you are using for your GitHub account.<br>
   Use descriptive and meaningful commit messages.
   In particular, start the first line of the commit message with the number of the issue that the commit addresses, e.g. `#XXX [description of changes]`.
10. Push your changes to your forked repository.
11. Submit a [pull request](https://help.github.com/articles/using-pull-requests/) referencing the related issue(s).
12. After submitting, do not use your branch for any other development, otherwise further changes that you make will be visible in the PR.

---
## Contributing as a project committer

1. Check if there is already a GitHub issue for what you want to work on or create one.
1. Assign the issue to yourself.
4. Create a new branch from `main` for your changes. Name it after the issue number, e.g. `#XXX_[description_of_changes]`.
1. Implement your changes.
1. Rebase on `main`.
1. Run `./gradlew spotlessApply` to format the code and add licence headers to the files.
1. Run `./gradlew build` (to check code formatting and run tests)
9. Commit your changes.
   Use descriptive and meaningful commit messages.
   In particular, start the first line of the commit message with the number of the issue that the commit addresses, e.g. `#XXX [description of changes]`.
1. Push the branch into the repository.
1. Submit a [pull request](https://help.github.com/articles/using-pull-requests/) and ask somebody who is familiar with the code you modified to review it.
1. If the reviewer approves and all checks are OK, merge using **squash & commit** method.