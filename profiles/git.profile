function gc_commit_message() {
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
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D;
}
alias git_prune_local=git_prune_local;

function gdno() {
    git diff --name-only $1;
}
alias gdno=gdno;

function gdelremote() {
    git push origin --delete $1
}
alias gdelremote=gdelremote;

function glolacherry() {
    git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)           %C(bold blue)<%an>%Creset' --no-merges master..;
}
alias glolacherry=glolacherry;

function gdcolorwords() {
    git diff --color-words;
}
alias gdcolorwords=gdcolorwords;

alias gba='git branch --all --sort=-committerdate'
