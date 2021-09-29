---
title: How to contribute to Eclipse Keyple™ project
summary: Find out how to contribute to the Keyple project and how it can benefit your organization.
---

Thanks for your interest in the Eclipse Keyple™ project.

---
## Via fork (for external contributors)

Prerequisites:
* Have a [GitHub](https://github.com/join) account.

Workflow:
1. Check if there is already a GitHub issue for what you want to work on or create one.
2. Announce in the comments section that you want to work on the issue. Also describe the solution you want to implement. 
To improve the chances for your contribution to be accepted, you'll want to wait for the feedback of the committers.
3. Fork the repository.
4. Create a new branch from `main` for your changes. Name it after the issue number, e.g. `#XXX_[descriptionofchanges]`.
5. Implement your changes.
6. Rebase on `main`.
7. Run `./gradlew spotlessApply` to format the code and add licence headers to the files.
8. Run `./gradlew build` (to check code formatting and run tests)
9. Commit using [sign off](https://git-scm.com/docs/git-commit#git-commit--s) option with the same email address you are using for your GitHub account. 
Use descriptive and meaningful commit messages. 
In particular, start the first line of the commit message with the number of the issue that the commit addresses, e.g. `#XXX [descriptionofchanges]`.
10. Push your changes to your forked repository.
11. Create a [pull request (PR)](https://help.github.com/articles/using-pull-requests/) to `main`.
12. After submitting, do not use your branch for any other development, otherwise further changes that you make will be visible in the PR.

---
## As an Eclipse Keyple™ project committer

Prerequisites:
1. Have a [GitHub](https://github.com/join) account,
2. Have an [Eclipse](https://accounts.eclipse.org/user/register) account,
3. Have signed the [Eclipse Contributor Agreement](https://accounts.eclipse.org/user/login?destination=user/eca),
4. Have been elected as a committer by the project's team.

Workflow:
1. Check if there is already a GitHub issue for what you want to work on or create one.
1. Assign the issue to yourself.
4. Create a new branch from `main` for your changes. Name it after the issue number, e.g. `#XXX_[descriptionofchanges]`.
1. Implement your changes.
1. Rebase on `main`.
1. Run `./gradlew spotlessApply` to format the code and add licence headers to the files.
1. Run `./gradlew build` (to check code formatting and run tests)
9. Commit your changes.
   Use descriptive and meaningful commit messages.
   In particular, start the first line of the commit message with the number of the issue that the commit addresses, e.g. `#XXX [descriptionofchanges]`.
1. Push the branch into the repository.
1. Create a pull request and ask somebody who is familiar with the code you modified to review it.
1. If the reviewer approves and all checks are OK, merge using **squash and commit** method.