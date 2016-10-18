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


### find how many line I commit this day
git log --author='0xd3' --oneline --shortstat --pretty="%cd"  
git log  --oneline --shortstat --pretty="%cd"  


### More about git log
https://git-scm.com/book/en/v2/Git-Basics-Viewing-the-Commit-History

## Show difference introduced
git log -p -2 

## See abbreviate stats
git log --stat

## --pretty
git log --pretty=online
git log --pretty=short
git log --pretty=full
git log --pretty=fuller
git log --pretty=format:"%h - %an, %ar : %s"

Source:
https://www.atlassian.com/git/tutorials/git-log
https://www.andyjeffries.co.uk/25-tips-for-intermediate-git-users/
http://zsoltfabok.com/blog/2012/02/git-blame-line-history/

# checkout old file
git log
git checkout <hash>
cp <restore file> <path>
git checkout master

git diff --cached --stat

gitstats static your project

git show 27cf8e84bb88e24ae4b4b3df2b77aab91a3735d8:my_file.txt > my_file.txt.OLD

<!--reset add before commit-->
git reset

git filter-branch --env-filter \
    'if [ $GIT_COMMIT = 119f9ecf58069b265ab22f1f97d2b648faf932e0 ]
     then
         export GIT_AUTHOR_DATE="Thur Sep 8 21:38:53 2009 -0800"


         export GIT_COMMITTER_DATE="Sat May 19 01:01:01 2007 -0700"
     fi'


GIT_COMMITTER_DATE="Thur Sep 8 21:38:53 2016 +0800" git commit --amend --date "Thur Sep 8 21:38:53 2016 +0800"

如何删除撤销暂存区域的文件:
git reset filename.txt

如何只提交一个文件当中的部分代码
You can do git add --patch filename.x (or -p for short), and git will begin
breaking down your file in what it thinks are sensible "hunks" (portions of the
file). You will then be prompted with this question:

Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]?

And here the meaning of each option:

y stage this hunk for the next commit
n do not stage this hunk for the next commit
q quit; do not stage this hunk or any of the remaining hunks
a stage this hunk and all later hunks in the file
d do not stage this hunk or any of the later hunks in the file
g select a hunk to go to
/ search for a hunk matching the given regex
j leave this hunk undecided, see next undecided hunk
J leave this hunk undecided, see next hunk
k leave this hunk undecided, see previous undecided hunk
K leave this hunk undecided, see previous hunk
s split the current hunk into smaller hunks
e manually edit the current hunk
? print hunk help
If the file is not in the repository yet, do first git add -N filename.x.
Afterwards you can go on with git add -p filename.x.

You can use than: git diff --staged afterwards to check that you staged the
correct ones git reset -p to unstage incorrect hunks git commit -v to view your
commit while you edit the commit message.

Note this is a far different than the git format-patch command, which is
entirely different.

Git aliases
One of the best ways to ease your daily workflow with Git is to create aliases for common commands you use every day. This can save you some time in the terminal.

You can use the following commands to create aliases for the most used Git commands, checkout, commit and branch.

git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.br branch
This way, instead of typing git checkout master you only need to type git co master.

You could also edit them or add more by modifying the ~/.gitconfig file directly:

[alias]
    co = checkout
    ci = commit
    br = branch



And your changes will be recovered. If you no longer need those changes and want to clear the stash stack you can do so with:
$ git stash drop

--------------------------------------------------
Compare commits from the command line
An easy and quick way to compare the differences between commits, or versions of the same file is to use the command line. For this you can use the git diff command.

If you want to compare the same file between different commits, you do the following:

$ git diff $start_commit..$end_commit -- path/to/file
Anf if you want to compare the changes between two commits:

$ git diff $start_commit..$end_commit
These commands will open the diff view inside the terminal, but if you prefer to use a more visual tool to compare your diffs, you can use git difftool. A really great diff viewer/editor is Meld.

To configure Meld:

$ git config --global diff.tool git-meld
Now to start viewing the diffs:

$ git difftool $start_commit..$end_commit -- path/to/file
# or
$ git difftool $start_commit..$end_commit

--------------------------------------------------
Use Git blame more efficiently
Git blame is a great tool for finding out who changed a line in a file, but there are ways you can use it more efficiently. You can pass different flags, depending on what you want to show.

$ git blame -w  # ignores white space
$ git blame -M  # ignores moving text
$ git blame -C  # ignores moving text into other files

--------------------------------------------------
Commit often, but don't push every commit
Committing your changes often will keep your changes concise and make them easier to revert, if you were to need that. But it is not necessary to push every single commit to the server, as it will appear in the activity feed and probably spam your colleagues. Work on your changes until you are ready to push.

Push when changes are tested
A nice sign that your changes are ready to push is when they have been tested and the tests are green. This usually also means that this part of your feature is done and you can concentrate on the next part. Push your changes once this has been done and let the CI server test them again.

--------------------------------------------------
10. Cherry Pick
I have saved the most elegant Git command for the last. The cherry-pick command is by far my favorite Git command, because of its literal meaning as well as its utility!

In the simplest of terms, cherry-pick is picking a single commit from a different branch and merging it with your current one. If you are working in a parallel fashion on two or more branches, you might notice a bug that is present in all branches. If you solve it in one, you can cherry pick the commit into the other branches, without messing with other files or commits.

Let’s consider a scenario where we can apply this. I have two branches and I want to cherry-pick the commit b20fd14: Cleaned junk into another one.

Before cherry pick

I switch to the branch into which I want to cherry-pick the commit, and run the following:

git cherry-pick [commit_hash]
After cherry pick

Although we had a clean cherry-pick this time, you should know that this command can often lead to conflicts, so use it with care.

--------------------------------------------------
9. Check for Lost Commits
Although reflog is one way of checking for lost commits, it’s not feasible in large repositories. That is when the fsck (file system check) command comes into play.

git fsck --lost-found
Git fsck results

Here you can see a lost commit. You can check the changes in the commit by running git show [commit_hash] or recover it by running git merge [commit_hash].

git fsck has an advantage over reflog. Let’s say you deleted a remote branch and then cloned the repository. With fsck you can search for and recover the deleted remote branch.

--------------------------------------------------
That way:

each time you checkout some files of your repo, spaces can be converted in tabs,
but when you check-in (and push and publish), those same files are stored back using only spaces.
You can declare this filter driver (named here 'tabspace') in the .git/info/attributes (for a filter applied to all files within the Git repo), with the following content:

*.py  filter=tabspace
Now run the commands:

# local config for the current repo
git config filter.tabspace.smudge 'script_to_make_tabs'
git config filter.tabspace.clean 'script_to_make_spaces'
See Olivier's answer for a concrete working example of such a smudge/clean set of instructions.

--------------------------------------------------
Git Tip of the Week: Git Archive
 2011, git, gtotw
This week's Git Tip of the Week is about archives. You can subscribe to the feed if you want to receive new instalments automatically.

If you want to extract the contents of a Git repository, perhaps to make it available for a source download somewhere, then you can of course zip (or tar) up the contents of the repository with a command line tool.

However, there's another way of doing this with a Git repository, using the git archive command. This takes the contents of the current working tree and generates a zip (or tar) file.

One key advantage of using Git to perform the archive rather than a command line tool is to avoid accidentally capturing the (large) .git directory, or any work-in-progress content. For example, if you have just run a build, then zip (tar) will include the content of the build output as well.

Another advantage is that you can extract the content of the repository at an arbitrary revision. Whilst HEAD is used by default, you can put in any tree or tag in the extraction, which makes it useful for being able to generate a source tar ball from a given tag (even if that tree doesn't happen to be the default). For example, let's say we wanted to generate a source bundle from the EGit repository


(master) $ git archive --format tar v1.0.0.201106090707-r | gzip -9 > /tmp/egit-v1.0.0.tgz
(master) $ tar tzf /tmp/egit-v1.0.0 | head
.eclipse_iplog
.gitattributes
EGIT_INSTALL
LICENSE
README
SUBMITTING_PATCHES
org.eclipse.egit-feature/
org.eclipse.egit-feature/.gitignore
org.eclipse.egit-feature/.project
org.eclipse.egit-feature/.settings/
This feature is used when browsing the contents of a repository via cgit. It's possible to click on any link (commit or branch) and download a tgz of the repository at the time. All of this is powered by git archive. In fact, you can create an archive from a remote repository, without needing an explicit clone – though it's worth noting that most http repositories don't support this.


(master) $ git archive --format tar -9 --remote ssh://server.org/path/to/git > /tmp/remotearchive.tgz
Finally, it's possible to extract only a subset of files rather than the whole repository. If you wanted to generate only the docs for a project, and they were all present in the docs/ folder, then you could create an archive just containing that with:


(master) $ git archive --format tar -9 HEAD docs > /tmp/docs.tgz
It's fairly common that git describe will be used in conjunction with git archive in creating the name of the output file, and optionally, the global prefix to put in the compressed archive output as well:


(master) $ NAME=project-`git describe`
(master) $ git archive --format tar -9 HEAD docs > ${NAME}-docs.tgz 


--------------------------------------------------
Then did g clone github.com:torvalds/linux --depth 1 and it did cloned quite fast. And I have only one commit in git log.

So clone --depth 1 should work. If you need to update existing repository, you should use git fetch origin branchname:branchname --depth 1. It works too, it fetches only one commit.
