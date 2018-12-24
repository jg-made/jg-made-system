fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit

alias hubpr='hub pr list -f "%sC%i%Creset %Nc  %t  %n%b%l%n" -o "updated"'
