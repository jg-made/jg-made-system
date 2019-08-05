non-sensitive config and cool functions/aliases
Disclaimer: this repo exists just for @jg-made to do dev work for made. Use any part of it at your own risk.
![hacienda ninja](https://github.com/jg-made/jg-made-system/blob/master/img/hacienda-ninja.png)

#HOWTO:

```
git clone https://github.com/jg-made/jg-made-system ~/.jg-made-system
```

I assume you are using zsh shell (I use oh-my-zsh).

I also assume you have vault, consul and Jira CLI installed:
https://www.vaultproject.io/docs/commands/
https://www.consul.io/docs/commands/index.html
https://github.com/go-jira/jira

Basically just symlink the stuff in `configs` to where they need to go.

Then you need to create a ROOT-ONLY (use `sudo mkdir` and `sudo touch`) `auths` dir in this project root. It should minimally look like this:

```
auths
├── aws
│   └── secret_key_aws
├── madevpn
│   ├── Linux-AWS-VPN.conf
│   └── madevpn.profile
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

`madevpn.profile` only exports two sensitive env vars: `MADEVPN\_GOOGLE\_COD3` and `MADEVPN\_USER\_NAM3` (obvious typos intentional)

`unset/madevpn.profile` only unsets sensitive env vars.

Finally, your vault github token should be saved in `vault/github_token`.
