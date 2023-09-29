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

# Startup check
if [ "$EUID" -eq 0 ]; then
    echo "Please run as normal user. Don't use sudo. Exiting..."
    exit
fi

export OLD_PROMPT="PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\\$ '"

# 1. update PS1, shell prompt
executeStep 'cp ~/.bashrc ~/.bashrc.bkp' 'Backup Config'
executeStep 'wget https://raw.githubusercontent.com/mukherjeearnab/dotfiles/main/bash/helpers/bash_prompt.py -O ~/bash_prompt.py'
executeStep 'python3 ./bash_prompt.py' 'Update bashrc Config'
executeStep 'rm ./bash_prompt.py' 'Cleaning...'
