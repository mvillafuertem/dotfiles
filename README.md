# Dotfiles



Quick install:

----

sh -c "`curl -fsSL https://raw.githubusercontent.com/mvillafuertem/dotfiles/master/install.sh`"

----

Install with ssh (easier for committing updates):


----

git clone git@github.com:mvillafuertem/dotfiles.git ~/.dotfiles && cd .dotfiles && ./install.sh

----


https://mkyong.com/java/how-to-install-java-on-mac-osx/

http://www.appsdeveloperblog.com/how-to-set-java_home-on-mac/

https://www.shell-tips.com/mac/upgrade-bash/

## Netcat

https://blog.niklasottosson.com/mac/using-netcat-to-catch-request-data-from-curl/
https://jameshfisher.com/2018/12/31/how-to-make-a-webserver-with-netcat-nc/

Listener
```shell

nc -l 5000

```

Client 
```shell

nc -v 5000

```

Web server
```shell

while true; do echo "HTTP/1.1 200 OK" | nc -l 8000; done

```

## VIM

https://superuser.com/questions/486532/how-to-open-files-in-vertically-horizontal-split-windows-in-vim-from-the-command

----

Ctrl+W, S (upper case) for horizontal splitting

Ctrl+W, v (lower case) for vertical splitting

Ctrl+W, Q to close one

Ctrl+W, Ctrl+W to switch between windows

Ctrl+W, J (xor K, H, L) to switch to adjacent window (intuitively up, down, left, right)

RESIZE

Ctrl+W+ (n) >/<: For right/left

Ctrl+W+ (n) +/-: For up/down

where n = any number.

----


https://vi.stackexchange.com/questions/13735/how-can-i-make-keymap-to-open-a-new-file-in-a-vertical-split

----

The command you are looking for is :vertical new or :vnew. The latter has the advantage that is easier to make a command which takes a count, e.g., :20vnew. In the following mapping,

----

## Bash shortcuts
https://skorks.com/2009/09/bash-shortcuts-for-maximum-productivity/

----

Ctrl-u  Cut everything before the cursor
Ctrl-a  Move cursor to beginning of line
Ctrl-e  Move cursor to end of line
Ctrl-b  Move cursor back one word
Ctrl-f  Move cursor forward one word
Ctrl-w  Cut the last word
Ctrl-k  Cut everything after the cursor
Ctrl-y  Paste the last thing to be cut
Ctrl-_  Undo

----

Merge Files

----

find . -name "*12T00_00_00_mongodb.txt" | xargs cat > 2020-05-11T00_00_00_2020-05-12T00_00_00_mongodb_MERGED.txt

----


Docker Brigde or Host Mode


----

https://stackoverflow.com/questions/24319662/from-inside-of-a-docker-container-how-do-i-connect-to-the-localhost-of-the-mach

----


You can use the option -o to open the files in horizontal splits or -O (letter "O") to open vertical splits. The following commands open a window for each file specified:

vim -o *.cpp
vim -O foo bar baz
You can tell Vim the maximum number of windows to open by putting an integer after o or O options, the following example will open at most two windows no matter how many file matches, you will see the first two file specified on the command line, the rest will remain hidden:

vim -o2 *.cpp
See :help -o for all the details.




zz - move current line to the middle of the screen
(Careful with zz, if you happen to have Caps Lock on accidentally, you will save and exit vim!)
zt - move current line to the top of the screen
zb - move current line to the bottom of the screen


Additionally:

Ctrl-y Moves screen up one line
Ctrl-e Moves screen down one line
Ctrl-u Moves cursor & screen up ½ page
Ctrl-d Moves cursor & screen down ½ page
Ctrl-b Moves screen up one page, cursor to last line
Ctrl-f Moves screen down one page, cursor to first line
Ctrl-y and Ctrl-e only change the cursor position if it would be moved off screen.

Courtesy of http://www.lagmonster.org/docs/vi2.html

## Git

https://goiabada.blog/git-tricks-avoid-solving-the-same-rebase-conflict-multiple-times-9a3afbcf1d22
### Using git cherry-pick
This is not as simple as using rerere but it’s still simple. With cherry-pick we can select a range of commits to apply to a given branch. This way, we can make a “manual rebase”, selecting only the commits that were not rebased onto the first one.
In our example situation, we’ll need to select commits f, h and i from branch C and put them on top of branch A:

```shell

$ git checkout A
$ git cherry-pick f^..i

```
And it’s done.


### AVOID REBASE HELL: SQUASHING WITHOUT REBASING

https://blog.oddbit.com/post/2019-06-17-avoid-rebase-hell-squashing-wi/

You’re working on a pull request. You’ve been working on a pull request for a while, and due to lack of sleep or inebriation you’ve been merging changes into your feature branch rather than rebasing. You now have a pull request that looks like this (I’ve marked merge commits with the text [merge]):

```shell

7e181479 Adds methods for widget sales
0487162 [merge] Merge remote-tracking branch 'origin/master' into my_feature
76ee81c [merge] Merge branch 'my_feature' of https://github.com/my_user_name/widgets into my_feature
981aab4 Adds api for the widget service.
b048836 Includes fixes suggested by reviewer.
3dd0c22 adds changes requested by reviewer
5891db2 [merge] fixing merge conflicts
2e226e4 fixes suggestions given by the reviewer
da1e85c Adds gadget related API spec
c555cc1 Adds doodad related API spec
e5beb3e Adds api for update and delete of widgets
c43bade Adds api for creating widgets
deaa962 Adds all get methods for listing widgets
9de79ab Adds api for showing a widget and simple data model
8288ab1 Adds api framework for widget service
You know that’s a mess, so you try to fix it by running git rebase -i master and squashing everything together…and you find yourself stuck in an endless maze of merge conflicts. There has to be a better way!

```
(voiceover: there is a better way…)

#### Option 1: merge –squash

In this method, you will create a temporary branch and use git merge --squash to squash together the changes in your pull request.

Check out a new branch based on master (or the appropriate base branch if your feature branch isn’t based on master):
```shell
git checkout -b work master

```
(This creates a new branch called work and makes that your current branch.)

Bring in the changes from your messy pull request using git merge --squash:

```shell
git merge --squash my_feature

```
This brings in all the changes from your my_feature branch and stages them, but does not create any commits.

Commit the changes with an appropriate commit message:
```shell
git commit
```
At this point, your work branch should be identical to the original my_feature branch (running git diff my_feature_branch should not show any changes), but it will have only a single commit after master.

Return to your feature branch and reset it to the squashed version:
```shell
git checkout my_feature
git reset --hard work
```
Update your pull request:

```shell
git push -f
```
Optionally clean up your work branch:
```shell
git branch -D work
```
#### Option 2: Using git commit-tree

In this method, you will use git commit-tree to create a new commit without requiring a temporary branch.

Use git commit-tree to create new commit that reproduces the current state of your my_feature branch but

```shell
git commit-tree -p master -m 'this implements my_feature' my_feature^{tree}
```

This uses the current state of the my_feature branch as the source of a new commit whose parent is master. This will print out a commit hash:

```
1d3917a3b7c43f4585084e626303c9eeee59c6d6

```

Reset your my_feature branch to this new commit hash:

```shell
git reset --hard 1d3917a3b7c43f4585084e626303c9eeee59c6d6

```
Consider editing your commit message to meet best practices.

Update your pull request:

```shell
git push -f
```

#### Option 3: Using common ancestor
https://www.ctrlaltdan.com/2017/11/20/why-so-many-merge-conflicts/
We start by finding the common ancestor of our two branches. (my_feature and master).
```
$ git merge-base my_feature master
1c5908a2392d758c805c1ebac6707b7490cc615e


$ git checkout my_feature
$ git reset --soft <common ancestor commit hash>

$ git commit -m "We did it!"
$ git rebase master
```
