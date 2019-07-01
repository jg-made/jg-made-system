eval "$(hub alias -s)"
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

alias hubpr='hub pr list \
-f "\
============
%sC [%S] %sC [%i] %Creset %t
%l %sC%NC comments%Creset
  - Created %cr by %au
  - Last updated %ur.
  - Assigned to %as
  - %U
  - requested reviewers: %rs
  - merged date (may be blank if not merged): %mt
  $ git checkout %H

%b
============
" -o "updated"'
