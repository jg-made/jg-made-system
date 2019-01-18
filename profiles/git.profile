function gc_commit_message() {
  # quick and dirty add/commit
  git add .;
  vim .gc_commit_message;
  if [ $# -eq 1 ]
  then
    GIT_COMMITTER_DATE=$1 git commit --date=$1 -a -F .gc_commit_message;
  else
    git commit -a -F .gc_commit_message;
  fi
}
alias gc_commit_message=gc_commit_message;

function git_prune_local() {
  # get rid of local branches that used to track now-dead remotes
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D;
}
alias git_prune_local=git_prune_local;

function gdno() {
    # git diff show only file names
    git diff --name-only $1;
}
alias gdno=gdno;

function gdelremote() {
    # delete a remote branch - noice
    git push origin --delete $1
}
alias gdelremote=gdelremote;

function glolz() {
    # git log only this branches commits, in chronological order
    git log --color --stat --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --reverse $(git_current_branch)  ^master $@
}

function glolacherry() {
    git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)           %C(bold blue)<%an>%Creset' --no-merges master..;
}
alias glolacherry=glolacherry;

function gdcolorwords() {
    git diff --color-words;
}
alias gdcolorwords=gdcolorwords;

alias gba='git branch --all --sort=-committerdate'
