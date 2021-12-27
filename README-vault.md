# Ansible vault

Ansible vault is a kind of password manager which is used to store sensitive content (such as credentials or keys) in an encrypted format.
This prevents the disclosure of sensitive information that might be present in the Ansible code.

More info here:
https://docs.ansible.com/ansible/latest/user_guide/vault.html

For obvious reasons the vault files are not uploaded to the public git repository. Instead, in each location where a `vault.yml` is required you will find a file named `README-vault.md` with instructions explaining how to generate the file and which variables must be included.

You can find all the `README-vault.md` files with the command below:

`find ./ -type f -name "README-vault.md" -print` 

As you can see, different set of variables/values are required for each logical group of machines defined in the inventories.

In order to run playbooks requiring unlocking of vault files we can call `ansible-playbook` with the parameter `--ask-vault-password`.
Or, we can create a file containing the vault master password and use the parameter `--vault-password-file <vault file>`.

This second option is more dangerous but it might be required in case we need to automate the execution of the playbooks (crontab jobs, for instance).
If that's the case, we have to make sure that the file containing the master password has the correct permissions.

`echo "<master password>" > ./.vault && chmod 600 ./.vault`
