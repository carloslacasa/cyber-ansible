# cyber-ansible

## Ansible playbooks related to Cybersecurity

### Keeping Windows systems up-to-date
Automated upgrade of Windows servers and workstations. The upgrade can be launched in a controlled way to different groups of boxes defined in the inventories. 
It takes care of Windows updates as well as packages installed through Chocolatey repositories.

Tested on Windows 10 (64, 32bits), Windows Server 2016, Windows Server 2019

How to call the playbook:

`ansible-playbook -i inventory/on-premise/windows/dev --limit site1_windows_wks_personal -T 5 ./windows_provisioning.yml --tags upgrade -vault-password-file ./.vault`


### Keeping Linux (Ubuntu) systems up-to-date
Automated upgrade of Ubuntu servers and workstations. The upgrade can be launched in a controlled way to different groups of boxes defined in the inventories. 

Tested on Ubuntu>=18.04 LTS

How to call the playbook:

`ansible-playbook -i inventory/on-premise/linux/dev --limit site1_linux_wks_it -T 5 ./linux_provisioning.yml --tags upgrade --vault-password-file ./.vault`

### Hardening rules for Windows systems
Security configuration for Windows systems according to recommendations published by CIS, GSA and ACSC.
CIS: Center for Internet Security
GSA: US General Services Administration
ACSC: Australian Cyber Security Center

Different configuration options can be customized at group level or host level defined in the Ansible inventories.

Tested on Windows 10 (64, 32bits), Windows Server 2016, Windows Server 2019
DISCLAIMER: These rules must be seen as an example. They must be reviewed/modified in order to suit the needs of any particular environments. Do NOT apply them in production without a previous and careful testing.

How to call the playbook:

`ansible-playbook -i inventory/on-premise/windows/dev --limit site1_windows_wks_personal -T 5 ./windows_provisioning.yml --tags cis,acsc,gsa,install,configuration,services -vault-password-file ./.vault`


### Hardening rules for Linux (Ubuntu) systems
Configuration of Ubuntu systems according to CIS security baselines.
OpenSCAP software and up-to-date security guides are included in order to audit our security posture against different security profiles and Cybersecurity frameworks.
Different configuration options can be customized at group level or host level defined in the Ansible inventories.

Tested on Ubuntu>=18.04 LTS
DISCLAIMER: These rules must be seen as an example. They must be reviewed/modified in order to suit the needs of any particular environments. Do NOT apply them in production without a previous and careful testing.

How to call the playbook:

`ansible-playbook -i inventory/on-premise/linux/dev --limit site1_linux_wks_it -T 5 ./linux_provisioning.yml --tags scap,install,configuration,services --vault-password-file ./.vault`

### Generic protective measures for Windows systems
Define which services must be running or stopped, which software packages must be installed or removed.
Workaround for known vulnerabilities (such as CVE-2021-34527 and CVE-2021-40444).
Generic configuration settings such as:
- NTLM relay protection (disabling LLMNR, NBT-NS, IPv6, WPAD)
- Windows firewall enabled
- Define local administrators
- Update administrator password

Tested on Windows 10 (64, 32bits)

How to call the playbook:

`ansible-playbook -i inventory/on-premise/windows/dev --limit site1_windows_wks_personal -T 5 ./windows_provisioning.yml --tags generic,install,configuration,services -vault-password-file ./.vault`

### Windows remote access
#### RDP
Define which machines require the RDP service. Custom firewall rules for the RDP service as well as restricted access to a defined set of users.

#### VNC
Define which machines require VNC (either in server or client mode). Install TightVNC from Chocolatey repositories and make sure it is an up-to-date version. Configure different settings (remote access through HTTP, file sharing, remote access password, control password). Define customized firewall rules for the VNC service.

#### TeamViewer
Define which machines require the TeamViewer service. Install the software from Chocolatey repositories and make sure it is and up-to-date version. Remove TeamViewer where this service is not required or not allowed.

Tested on Windows 10 (64, 32bits)

How to call the playbook:

`ansible-playbook -i inventory/on-premise/windows/dev --limit site1_windows_wks_personal -T 5 ./windows_provisioning.yml --tags rdp,vnc,teamviewer,install,configuration,services -vault-password-file ./.vault`

### logstash
Logstash server acting as an message broker from linux and windows clients towards an external (cloud) Elasticsearch and Kibana instance.

PKI in place so that both ends (logstash server and clients) are mutually authenticated and the data stream is encrypted (log messages might contain sensitive information).

Tested on Ubuntu >= 18.04 LTS

How to call the playbook:

`ansible-playbook -i inventory/on-premise/linux/dev --limit site1_logstash_it_dmz -T 5 ./logstash_provisioning.yml --tags logstash,fail2ban,install,configuration,services -vault-password-file ./.vault`

`ansible-playbook -i inventory/on-premise/linux/dev --limit site1_logstash_ot_dmz -T 5 ./logstash_provisioning.yml --tags logstash,fail2ban,install,configuration,services -vault-password-file ./.vault`

### Sysmon + logshipping
Sysmon monitoring and logshipping to external logstash service.

Sysmon configuration can be customized for either groups or individual hosts, as determined by the variable `sysmon_url` which points to a remote repository containing a XML file with the sysmon required configuration.

For instance:

[Modular sysmon config 1](https://github.com/olafhartong/sysmon-modular/blob/master/sysmonconfig.xml)

[Modular sysmon config 2](https://github.com/SwiftOnSecurity/sysmon-config/blob/master/sysmonconfig-export.xml)

[Full logging sysmon config](https://raw.githubusercontent.com/MotiBa/Sysmon/master/FullLogging_v1.xml)

Tested on Windows 10 (64, 32bits)

How to call the playbook:

`ansible-playbook -i inventory/on-premise/windows/dev --limit site1_windows_wks_personal -T 5 ./windows_provisioning.yml --tags sysmon,logshipping,install,configuration,services -vault-password-file ./.vault`

Credits:

Talk _SysFu: How to use sysmon at scale to kick attacker asses_ at I CONForense by **@antoniosanzlc**

Slides here:

[Google docs](https://docs.google.com/spreadsheets/d/1t3BL09-K3wZ7TpG1B26o2f-TOadF4H1TRpXj6GInsDI/edit#gid=0)

### WAF
Web application firewall with apache2+modsecurity+fail2ban.

Tested on Ubuntu >= 18.04 LTS

How to call the playbook:

`ansible-playbook -i inventory/on-premise/linux/dev --limit site1_reverse_proxies_it_dmz_ha -T 5 ./reverse_proxy_provisioning.yml --tags haproxy,waf,fail2ban,keepalived,install,configuration,services -vault-password-file ./.vault`

`ansible-playbook -i inventory/on-premise/linux/dev --limit site1_reverse_proxies_ot_dmz_ha -T 5 ./reverse_proxy_provisioning.yml --tags haproxy,waf,fail2ban,keepalived,install,configuration,services -vault-password-file ./.vault`

### 2FA
Multifactor authentication with Google Authenticator for both console and SSH access.

Tested on Ubuntu >= 18.04 LTS

How to call the playbook:

`ansible-playbook -i inventory/on-premise/linux/dev --limit site1_linux_it -T 5 ./openvpn_provisioning.yml --tags 2fa,install,configuration,services -vault-password-file ./.vault`


### OpenVPN + 2FA

OpenVPN server in TAP mode (_bridge_). 
VPN clients will get an IP address belonging to the local network address space 

Multifactor authentication
- PKI
- OTP (Google Authenticator)

A specific PAM module for Google Authenticator is required (`openvpn-plugin-auth-pam.so`)
The playbooks take care of the PKI setup (client and server certificates), as well as the generation of ovpn files containing the configuration for each particular user.
The utility googleauthenticator is used in order to generate the seed for OTP.
Scripts containing basic rules for controlling traffic at level 2 (local network, with ebtables) and level 3 (remote network access through the VPN gateway, with iptables) are also provided.

Tested with Ubuntu-18.04 LTS server 

How to call the playbook:

`ansible-playbook -i inventory/on-premise/linux/dev --limit site1_vpn_servers -T 300 ./openvpn_provisioning.yml --tags 2fa,openvpn,install,configuration,services -vault-password-file ./.vault`

Note that the timeout parameter (`-T`) is quite high due to the time required to run some of the PKI playbooks the first time the playbooks are applied on a system..

Credits:

[BastiPaltz openVPN](https://github.com/BastiPaeltz/ansible-openvpn/tree/master/playbooks)

References:

[Google authenticator and openVPN](https://medium.com/we-have-all-been-there/using-google-authenticator-mfa-with-openvpn-on-ubuntu-16-04-774e4acc2852)

[MFA on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-configure-multi-factor-authentication-on-ubuntu-18-04)

[2FA for SSH on Ubuntu](https://www.linuxbabe.com/ubuntu/two-factor-authentication-ssh-key-ubuntu-18-04)


