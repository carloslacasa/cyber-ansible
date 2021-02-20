# cyber-ansible

Ansible playbooks related to Cybersecurity

2FA
---
Multifactor authentication with Google Authenticator for both console and SSH access.

Tested on Ubuntu >= 18.04 LTS

How to call the playbook:

ansible-playbook -i inventory/on-premise/linux/dev --limit site1_linux_it -T 5 ./openvpn_provisioning.yml --tags 2fa,install,configuration,services


OpenVPN + 2FA
-------------

OpenVPN server in TAP mode (bridge). 
VPN clients will get an IP address belonging to the local network address space 

Multifactor authentication
- PKI
- OTP (Google Authenticator)

A specific PAM module for Google Authenticator is required (openvpn-plugin-auth-pam.so)
The playbooks take care of the PKI setup (client and server certificates), as well as the generation of ovpn files containing the configuration for each particular user.
The utility googleauthenticator is used in order to generate the seed for OTP.
Scripts containing basic rules for controlling traffic at level 2 (local network, with ebtables) and level 3 (remote network access through the VPN gateway, with iptables) are also provided.

Tested with Ubuntu-18.04 LTS server 

How to call the playbook:

ansible-playbook -i inventory/on-premise/linux/dev --limit site1_vpn_servers -T 300 ./openvpn_provisioning.yml --tags 2fa,openvpn,install,configuration,services

CREDITS:

https://github.com/BastiPaeltz/ansible-openvpn/tree/master/playbooks

References:

https://medium.com/we-have-all-been-there/using-google-authenticator-mfa-with-openvpn-on-ubuntu-16-04-774e4acc2852
https://www.digitalocean.com/community/tutorials/how-to-configure-multi-factor-authentication-on-ubuntu-18-04
https://www.linuxbabe.com/ubuntu/two-factor-authentication-ssh-key-ubuntu-18-04

