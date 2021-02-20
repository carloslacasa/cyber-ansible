OpenVPN + 2FA

OpenVPN server in TAP mode (bridge)  
Multifactor authentication
	PKI
	OTP (Google Authenticator)
A specific PAM module for Google Authenticator is required (openvpn-plugin-auth-pam.so)
The playbooks take care of the PKI setup (client and server certificates), as well as the generation of ovpn files containing the configuration for each particular client.
The utility googleauthenticator is used in order to generate the seed for OTP
Scripts containing basic rules for controlling traffic at level 2 (local network, with ebtables) and level 3 (remote network access through the VPN gateway, with iptables).



CREDITS:
https://github.com/BastiPaeltz/ansible-openvpn/tree/master/playbooks

References:
https://medium.com/we-have-all-been-there/using-google-authenticator-mfa-with-openvpn-on-ubuntu-16-04-774e4acc2852
https://www.digitalocean.com/community/tutorials/how-to-configure-multi-factor-authentication-on-ubuntu-18-04
https://www.linuxbabe.com/ubuntu/two-factor-authentication-ssh-key-ubuntu-18-04
