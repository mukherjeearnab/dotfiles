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

# 0. Run apt update
executeStep 'sudo apt update' 'Running APT Update'

# 1. Install the Slim Display Manager
executeStep 'sudo apt install slim -y' 'Installing Slim Display Manager'

# 2. Install the LXDE Desktop Environment
executeStep 'sudo apt install lxde -y' 'Installing LXDE Desktop Environment'
