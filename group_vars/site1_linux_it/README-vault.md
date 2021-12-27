## README Vault 

An Ansible vault file containing sensitive variables (such as credentials) must exist in this folder. 

It can be generated with the command below:

`ansible-vault create vault.yml`

The following variables must be defined:

`vault_linux_admin_user: CHANGEME`

`vault_linux_admin_password: CHANGEME`

`vault_domain_admin: CHANGEME`

`vault_domain_password: CHANGEME`

`vault_kibana_user: CHANGEME`

`vault_kibana_passwords: CHANGEME`

`elasticsearch_user: CHANGEME`

`elasticsearch_password: CHANGEME`

