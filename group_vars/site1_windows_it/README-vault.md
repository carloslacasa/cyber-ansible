## README Vault 

An Ansible vault file containing sensitive variables must exist in this folder. 

It can be generated with the command below:

`ansible-vault create vault.yml`

The following variables must be defined:

`vault_domain_admin_user: CHANGEME
vault_domain_admin_password: CHANGEME
vault_local_admin_user: CHANGEME
vault_local_admin_password: CHANGEME
vault_local_user_generic_password: CHANGEME
vault_samba_user: CHANGEME
vault_samba_password: CHANGEME`
