# Configure Remotes
When a repository is cloned, it has a default remote called `origin` that points to your fork on GitHub, not the original repository it was forked from. To keep track of the original repository, you should add another remote named `upstream`:<br />
1. Get the path where you have your git repository on your machine. Go to that path in Terminal using cd. Alternatively, right click on project in Github Desktop and hit ‘Open in Terminal’.<br />
2. Run `git remote -v`  to check the status you should see something like the following:<br />
> origin    https://github.com/YOUR_USERNAME/mentorship-ios.git (fetch)<br />
> origin    https://github.com/YOUR_USERNAME/mentorship-ios.git (push)<br />
3. Set the `upstream`:<br />
 `git remote add upstream https://github.com/anitab-org/mentorship-ios.git`<br />
4. Run `git remote -v`  again to check the status, you should see something like the following:<br />
> origin    https://github.com/YOUR_USERNAME/mentorship-ios.git (fetch)<br />
> origin    https://github.com/YOUR_USERNAME/mentorship-ios.git (push)<br />
> upstream  https://github.com/anitab-org/mentorship-ios.git (fetch)<br />
> upstream  https://github.com/anitab-org/mentorship-ios.git (push)<br />
5. To update your local copy with remote changes, run the following:<br />
`git fetch upstream develop`<br />
 `git rebase  upstream/develop`<br />
This will give you an exact copy of the current remote, make sure you don't have any local changes.<br />
6. Project set-up is complete.
