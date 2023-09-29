#####################
# Auxiliary Methods #
#####################
function executeStep() {
    BBlue='\033[1;34m'
    BYellow='\033[1;33m'
    Green='\033[0;32m'
    Cyan='\033[0;36m'
    Color_Off='\033[0m'
    echo -e "${Cyan}STEP: $2"
    echo -e "${BYellow}Executing: ${Green} $1 ${Color_Off}"
    eval $1
    echo -e "${BBlue}Completed: ${Green} $1 ${Color_Off}"
}

# startup check
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo). Exiting..."
    exit
fi

######################
# 1. Firewall Config #
######################
# enable ufw firewall and deny incomming traffic to all open ports
executeStep 'ufw enable' 'Enable Firewall'

# check firewall status
executeStep 'ufw status' 'Firewall Status Check'

###########################
# 2. Disable Root Account #
###########################
# disable password for root user
executeStep 'passwd -l root' 'Disable ROOT user password'

#################
# 3. SSH Config #
#################
# install ssh if not installed
executeStep 'apt install openssh-server -y' 'Install OpenSSH Server'

# check ssh status
executeStep 'systemctl status ssh' 'Check SSH Status'

# enable ssh
executeStep 'systemctl enable ssh' 'Enable SSH'

# allow ssh through firewall
executeStep 'ufw allow ssh' 'Allow SSH through Firewall'

# disable ssh root user login
# backup ssh config
executeStep 'cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup' 'Backup SSH Config'

# if PermitRootLogin is commented, uncomment
executeStep 'sed -i  "s/#PermitRootLogin/PermitRootLogin/" /etc/ssh/sshd_config' 'Disable ROOT SSH login #1'

# if PermitRootLogin is yes, set it to no
executeStep 'sed -i  "s/PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config' 'Disable ROOT SSH login #2'

# restart ssh service
executeStep 'systemctl restart ssh' 'Restart SSH Service'

#############################
# 4. Update Package Manager #
#############################
# run apt update and upgrade
executeStep 'apt update' 'Update APT Repositories'
executeStep 'apt upgrade -y' 'Update Installed Packages'

######################
# 5. Fail2Ban Config #
######################
# install fail2ban
executeStep 'apt install fail2ban -y' 'Install Fail2Ban'

# copy fail2ban config as .local
executeStep 'cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local' 'Backup Fail2Ban Config'

# check fail2ban service and enable it
executeStep 'systemctl status fail2ban.service' 'Check Fail2Ban Service Status'
executeStep 'systemctl enable --now fail2ban.service' 'Enable Fail2Ban Service'

# update fail2ban config
# set ban increment to true
executeStep 'sed -i "s/#bantime.increment/bantime.increment/" /etc/fail2ban/jail.local' 'Enable Fail2Ban Ban-time Increment'

# uncomment ban factor
executeStep 'sed -i "s/#bantime.factor/bantime.factor/" /etc/fail2ban/jail.local' 'Enable Fail2Ban Ban-time Mult Factor'
# set ban factor to 2
executeStep 'sed -i "s/bantime.factor = 1/bantime.factor = 2/" /etc/fail2ban/jail.local' 'Set Mult Factor to 2'

# set ban max retry to 2
executeStep 'sed -i "s/maxretry = 5/maxretry = 2/" /etc/fail2ban/jail.local' 'Set MAX RETRY from 5 to 2'

# restart fail2ban service
executeStep 'systemctl restart fail2ban.service' 'Restart Fail2Ban Service'

# check fail2ban service status
executeStep 'systemctl status fail2ban.service' 'Check Fail2Ban Service Status'

###################
# 6. Final Checks #
###################
# finally check open ports if any
executeStep 'ss -antp' 'Check for Open Ports'

# check firewall status
executeStep 'ufw status' 'Check Firewall Status'
