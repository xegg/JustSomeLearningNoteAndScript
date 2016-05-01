### Add new remote 
git remote add origin %{url}s

### remember password
git config credential.helper store

### http://stackoverflow.com/questions/927358/how-do-you-Undo a commit and redo

$ git commit -m "Something terribly misguided"              (1)
$ git reset --soft HEAD~                                    (2)
<< edit files as necessary >>                               (3)
$ git add ...                                               (4)
$ git commit -c ORIG_HEAD                                   (5)
This is what you want to undo
This is most often done when you remembered what you just committed is incomplete, or you misspelled your commit message1, or both. Leaves working tree as it was before git commit.
Make corrections to working tree files.
git add whatever changes you want to include in your new commit.
Commit the changes, reusing the old commit message. reset copied the old head to .git/ORIG_HEAD; commit with -c ORIG_HEAD will open an editor, which initially contains the log message from the old commit and allows you to edit it. If you do not need to edit the message, you could use the -C option instead.
Editor's note 1: You don't need to reset to an earlier commit if "you misspelled your commit message". If you reset, git will not link new activity to the previous commit in any way, giving you a blank slate for a new commit message. The easier option is git commit --amend, which will open your default commit message editor pre-populated with the last commit message.

Beware however that if you have added any new changes to the index, using commit --amend will add them to your previous commit.

You may find these answers helpful as well:

How to move HEAD (checkout, revert, reflog, reset)
How to uncommit my last commit in gitundo-the-last-commit
