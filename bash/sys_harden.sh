######################
# 1. Firewall Config #
######################
# enable ufw firewall and deny incomming traffic to all open ports
ufw enable

# check firewall status
ufw status


###########################
# 2. Disable Root Account #
###########################
# disable password for root user
passwd -l root


#################
# 3. SSH Config #
#################
# install ssh if not installed
apt install openssh-server -y

# check ssh status
systemctl status ssh

# enable ssh
systemctl enable ssh

# allow ssh through firewall
ufw allow ssh

# disable ssh root user login
    # backup ssh config
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

    # if PermitRootLogin is commented, uncomment
    sed -i  's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
    # if PermitRootLogin is yes, set it to no
    sed -i  's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# restart ssh service
systemctl restart ssh


#############################
# 4. Update Package Manager #
#############################
# run apt update and upgrade
apt update
apt upgrade


######################
# 5. Fail2Ban Config #
######################
# install fail2ban
apt install fail2ban -y

# copy fail2ban config as .local
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# check fail2ban service and enable it
systemctl status fail2ban.service
systemctl enable --now fail2ban.service

# update fail2ban config
    # set ban increment to true
    sed -i 's/#bantime.increment/bantime.increment/' /etc/fail2ban/jail.local

    # uncomment ban factor
    sed -i 's/#bantime.factor/bantime.factor/' /etc/fail2ban/jail.local
    # set ban factor to 2
    sed -i 's/bantime.factor = 1/bantime.factor = 2/' /etc/fail2ban/jail.local

# restart fail2ban service
systemctl restart fail2ban.service

# check fail2ban service status
systemctl status fail2ban.service


###################
# 6. Final Checks #
###################
# finally check open ports if any
ss -antp

# check firewall status
ufw status
