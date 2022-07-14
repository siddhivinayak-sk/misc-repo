
## Git configuration
Set the name:

```
git config --global user.name "User name"
```

Set the email:

```
git config --global user.email "himanshudubey481@gmail.com"
```

Set the default editor:

```
git config --global core.editor Vim
```

Check the setting:

```
git config -list
```

Git alias
Set up an alias for each command:

```
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
```

## Git init
Create a local repository:

```
git init
```

## Git Status

```
git status
```

## Git clone

```
git clone <remote_url>
```

```
git clone -b <branch_name> <remote_url>
```

## Git add - Add a file to staging (Index) area:

```
git add Filename
```

Add all files of a repo to staging (Index) area:

```
git add .

git add -A
```

Add all and ignore removal

```
git add --ignore-removal . 
```

Add all modified or deleted files

```
git add -u 
```

Undo added file from index

```
git reset <filename> 
```

## Remve file

```
git rm <file>
```

Remove file from Git but keep in local repo

```
git rm --cached
```


## Git commit

```
git commit -m " Commit Message"
```

Change committed message

```
git commit -amend 
```

## Git statsh

List stash

```
git stash list 
```

Show files which are stashed and changed

```
git stash show 
```

Save changed file in statsh with message

```
git stash save <message>
```

Push file into stash

```
git stash push <file>
```

Pop file from stash and reapply in current file

```
git stash pop
```

```
git stash apply
```

Delete stash from queue

```
git stash drop
```

Delete all items from stash

```
git stash clear 
```

Stash changes in separate branch

```
git stash branch <branch_name>
```

## Git ignore
Create a file named .gitignore and profile all filename and path which need to be ingored while git commands

e.g.

.gitingore
------------------
.DS_STORE
*.bin

## Git Fork

Use GitHub UI to fork branch

Need to provide source repository and destination namespace

## Git Index
When a file is changed, it will be changed into current directory
When changes are added, it reach to Git Index area (also called staging area)
When file committed, files from Git Index reaches to repository

## Git HEAD
HEAD is the last commit on the repository and branch. When a change is pushed, HEAD changed to last push

```
git show HEAD
```

When HEAD doesn't point to most recent commit, such state is called detached Head


## Git Remote

In Git, local and remote repository is maintained

```
git remote add <name> <url>
```

Rename

```
git remote rename <old> <new>
```

Remove

```
git remote remote <name>
```

Get Url

```
git remote get-url <name>
```

Get current branch remote

```
git remote
```

Set remote Url

```
git remote set-url <name> <url>
```

Default remote is Origin

Pulling from origin remote

Pull from current branch and remote

```
git pull
```

Pull from specified remote

```
git pull origin 
```

Pull from specified remote and branch

```
git pull origin branch
```

## Git fetch

```
git fetch <remote>
```

```
git fetch <remote> <branch>
```

Fetch simultaneously

```
git fetch -all
```

After fetch need to run merge:

```
git merge
```

PULL = FETCH + MERGE

## Git revert

Revert changes to particular commit:

```
git revert <commit>
```

## Git reset - Undoing changes 


```
git reset --hard [<commit>]
```


```
git reset --soft [<commit>]
```


```
git reset --mixed [<commit>]
```

Reset to HEAD - Undo last change

```
git reset HEAD  
```

Undo last 2 commits

```
git reset --hard HEAD~2
```


## Git Branch

Git provides to store separate code segment separated by branch

List branch

```
git branch
```

Create branch 

```
git branch <new_branch_name>
```

Delete branch

```
git branch -d <branch_name>
```

Delete remote branch

```
git push <remote_name> -d <branch_name>
```

Switch Branch

```
git checkout <branch_name>
```

```
git checkout -b <branch> <remote>
```

Rename branch

```
git branch -m <old_branch> <new_Branch>
```

Merge Branch

```
git merge <branch_name> 
```

## Git Merge

Merge branch

```
git merge <branch_name> 
```

Merge specific commit

```
git merge <commit name>
```

## Git Rebase

Git Rebase from master branch

```
git rebase master
```

```
git rebase -continue
```

```
git rebase --skip
```


Intractive Rebase

```
git rebase -i
```

It provides list of options:
Pick (-p): Pick stands here that the commit is included. Order of the commits depends upon the order of the pick commands during rebase. If you do not want to add a commit, you have to delete the entire line.

Reword (-r): The reword is quite similar to pick command. The reword option paused the rebase process and provides a chance to alter the commit message. It does not affect any changes made by the commit.

Edit (-e): The edit option allows for amending the commit. The amending means, commits can be added or changed entirely. We can also make additional commits before rebase continue command. It allows us to split a large commit into the smaller commit; moreover, we can remove erroneous changes made in a commit.

Squash (-s): The squash option allows you to combine two or more commits into a single commit. It also allows us to write a new commit message for describing the changes.

Fixup (-f): It is quite similar to the squash command. It discarded the message of the commit to be merged. The older commit message is used to describe both changes.

Exec (-x): The exec option allows you to run arbitrary shell commands against a commit.

Break (-b): The break option stops the rebasing at just position. It will continue rebasing later with 'git rebase --continue' command.

Drop (-d): The drop option is used to remove the commit.

Label (-l): The label option is used to mark the current head position with a name.

Reset (-t): The reset option is used to reset head to a label.


## Squash
Make single commit from multiple commits

Squash last three commits

```
git reset --soft HEAD~3
git commit
```

Squash last 12 commits

```
git reset --hard HEAD~12
git merge --squash HEAD@{1}
git commit
```

Always force push after squash

```
git push -f origin branch
```

Squash using rebase, last three branches

```
git rebase -i HEAD~3
```

It will open a file for reabse in intractive mode


## Git diff
Track the changes that have staged but not committed:

```
git diff --staged
```

Track the changes after committing a file:

```
git diff HEAD
```

Track the changes between two commits:
```
git diff <branch_2>
```

## Git log

```
git log
```

Display the output as one commit per line:

```
git log -oneline
```

Displays the files that have been modified:

```
git log -stat
```

Display the modified files with location:

```
git log -p
```

Check RefLog

```
git reflog
```


## Git blame

Display the modification on each line of a file:

```
git blame <file_name>
```

## Git cherry pic
Apply the changes introduced by some existing commit:

```
git cherry-pick <commit>
```

## Merging

```
git merge
```

```
git merge <commit>
```

## Push / Update Remote Branch

```
git push <remote> <branch>
```

Force

```
git push -f <remote> <branch>
```

Upstream

```
git push -u <remote> <branch>
```

Delete remote branch

```
git push <remote> -delete <branch>
```


## Clean unknown files

Clean unknown files from working tree

```
git clean
```

