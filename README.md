![hacienda ninja](https://github.com/jg-made/jg-made-system/blob/master/img/hacienda-ninja.png)

Disclaimer: this repo exists just for @jg-made to do dev work for made. Use any part of it at your own risk.
JFYI I am currently using `ubuntu 19.04`.

If you just want to browse the repo for useful stuff, I advise looking at the files in `profiles/`.
The file names indicate what they pertain to. For example, if you want to see how I am able to connect to the procurement database with such ease, maybe you want to read `profiles/procurement.profile`.

# THE FIVE HEAVENLY LEVELS OF NINJA, A BATTLE OF INCREASING DIFFICULTY, VICTORY WITH DILLIGENCE

### STEP_0
```
git clone https://github.com/jg-made/jg-made-system ~/.jg-made-system
```

### STEP_1
Use oh-my-zsh shell.
https://github.com/robbyrussell/oh-my-zsh

### STEP_2
Ensure you have vault, consul and Jira CLI installed:
- https://www.vaultproject.io/docs/commands/
- https://www.consul.io/docs/commands/index.html
- https://github.com/go-jira/jira

### STEP_3
Symlink the stuff in `configs` to where they need to go. Just look up their names on the internet.
Some of these configs you won't need (e.g. maybe you don't use `screen` like me).
The sylink you probably want the most is: 
```
ln -s ~/.jg-made-system/configs/zshrc ~/.zshrc
```
If you are using my `zshrc`, you almost certainly will want to remove some stuff (it's all in the `#CUSTOM` section) such as me setting my `EDITOR` to a custom binary called `em`. In `zshrc` you will probably also want to comment out certain sourced "profiles". If in doubt, comment it out.
Read any config before you use it!

### STEP_4
Create a ROOT-ONLY (use `sudo mkdir` and `sudo touch`) `auths` directory in this project root. It should minimally look like this:
```
~/.jg-made-system/auths
├── aws
│   └── secret_key_aws
├── madevpn
│   ├── Linux-AWS-VPN.conf
│   └── madevpn.profile
│   └── .secret_base_password
├── unset
│   └── madevpn.profile
└── vault
    └── github_token
```

`secret_key_aws` should be a root-only executable that returns the AWS MFA code which changes every 30 seconds.
Mine looks like this:
```
watch -n1 oathtool --totp -b AWS_CREDENTIAL
```

`Linux-AWS-VPN.conf` you should get wholesale from dev-ops team.

`madevpn.profile` only exports two sensitive env vars: `MADEVPN\_GOOGLE\_COD3` (I forget how I got this) and `MADEVPN\_USER\_NAM3` (obvious typos intentional)

`.secret_base_password` is your okta password.

`unset/madevpn.profile` only unsets sensitive env vars.

`vault/github_token` should contain only your vault github token.

Good luck!
