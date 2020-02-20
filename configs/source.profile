# alias hub as git before anything else
source $JG_MADE_SYSTEM/profiles/hub.profile

source $JG_MADE_SYSTEM/profiles/alarm.profile
source $JG_MADE_SYSTEM/profiles/asdf.profile
source $JG_MADE_SYSTEM/profiles/bluejeans.profile
source $JG_MADE_SYSTEM/profiles/docker.profile
source $JG_MADE_SYSTEM/profiles/dns.profile
source $JG_MADE_SYSTEM/profiles/dvm.profile
source $JG_MADE_SYSTEM/profiles/emacs.profile
source $JG_MADE_SYSTEM/profiles/eventstore.profile
source $JG_MADE_SYSTEM/profiles/go.profile
source $JG_MADE_SYSTEM/profiles/git.profile
source $JG_MADE_SYSTEM/profiles/iex.profile
source $JG_MADE_SYSTEM/profiles/image.profile
source $JG_MADE_SYSTEM/profiles/locale.profile
source $JG_MADE_SYSTEM/profiles/nvm.profile
source $JG_MADE_SYSTEM/profiles/pgcli.profile
source $JG_MADE_SYSTEM/profiles/postman.profile
source $JG_MADE_SYSTEM/profiles/pyenv.profile
source $JG_MADE_SYSTEM/profiles/python.profile
source $JG_MADE_SYSTEM/profiles/rbenv.profile
source $JG_MADE_SYSTEM/profiles/sound.profile
source $JG_MADE_SYSTEM/profiles/todo.profile
source $JG_MADE_SYSTEM/profiles/yarn.profile

# zplug hs caused me weird problems - i am deprecating it in my life
#source $JG_MADE_SYSTEM/profiles/zplug.profile

# nice MADE-specific stuff
source $JG_MADE_SYSTEM/profiles/madeenv.profile;
source $JG_MADE_SYSTEM/profiles/madevpn.profile;

# infra - vault/nomad/consul relies on madeenv.profile
source $JG_MADE_SYSTEM/profiles/consul.profile
source $JG_MADE_SYSTEM/profiles/nomad.profile
source $JG_MADE_SYSTEM/profiles/vault.profile

# jira convenience functions rely on zsh git aliases
source $JG_MADE_SYSTEM/profiles/jira.profile

# MADE projects - rely on vault, consul, madeenv
source $JG_MADE_SYSTEM/profiles/hacienda.profile
source $JG_MADE_SYSTEM/profiles/procurement.profile
#source $JG_MADE_SYSTEM/profiles/procurement_selenium.profile
source $JG_MADE_SYSTEM/profiles/erp.profile
source $JG_MADE_SYSTEM/profiles/rip.profile
source $JG_MADE_SYSTEM/profiles/flexport.profile
source $JG_MADE_SYSTEM/profiles/aqui.profile

# PUT LAZYFINGERS LAST
# Use lazyfingers for the stupid lazy i-hate-both-typing-and-thinking functions
# Put it last so it knows about all the other good functions and can play with them
source $JG_MADE_SYSTEM/profiles/lazyfingers.profile
