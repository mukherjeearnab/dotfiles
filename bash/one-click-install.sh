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

# 1. install git
executeStep 'sudo apt install git -y' 'Installing Git'

# 2. install curl and wget
executeStep 'sudo apt install git wget -y' 'Installing curl and wget'

# 3. install docker and docker-compose
executeStep 'sudo apt install docker.io -y' 'Installing Docker'
executeStep 'sudo apt install docker-compose -y' 'Installing Docker Compose'

executeStep 'sudo usermod -aG docker $USER' 'Add current user to docker group'
executeStep 'sudo chmod 777 /var/run/docker.sock' 'Add r/w permissions to the docker.sock'

# 4. install golang
executeStep 'sudo apt install golang-go -y' 'Installing GoLang'
executeStep 'echo "export GOPATH=\"$HOME/go\"" >> ~/.bashrc' 'Set GOPATH'

# 5. install git
executeStep 'sudo apt install git -y' 'Installing Git'

# 6. install nvm and node 16
executeStep 'wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash' 'Installing NVM'

executeStep 'nvm install 16' 'Installing Node 16'
executeStep 'nvm alias default 16' 'Setting Node 16 as default'
executeStep 'node -v' 'Check Node Version'
executeStep 'nvm -v' 'Check NPM Version'

# 7. install conda
executeStep 'wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh' 'Downloading Miniconda'
executeStep 'bash ~/miniconda.sh -b -p $HOME/.miniconda/' 'Installing Miniconda'
executeStep 'rm -rf ~/miniconda.sh' 'Removing Miniconda Installer'

# 8. install tmux ncdu screenfetch ranger htop
executeStep 'sudo apt install tmux ncdu screenfetch ranger htop -y' 'Installing tmux, ncdu, screenfetch, ranger, htop'

# 9. install cockpit
executeStep 'sudo apt install cockpit -y' 'Installing Cockpit'
executeStep 'sudo systemctl enable --now cockpit.socket' 'Enabling Cockpit'

# 10. install chromium
executeStep 'sudo apt install chromium-browser -y' 'Installing Chromium Browser'

# 11. install uget
executeStep 'sudo apt install uget -y' 'Installing uGet Downloader'

# 12. install VS Code
executeStep 'wget https://az764295.vo.msecnd.net/stable/ee2b180d582a7f601fa6ecfdad8d9fd269ab1884/code_1.76.2-1678817801_amd64.deb -O ~/vscode.deb' 'Downloading VS Code'
executeStep 'sudo dpkg -i ~/vscode.deb' 'Installing VS Code'
executeStep 'rm -rf ~/vscode.deb' 'Remove VS Code Installer'

# 13. install and enable remote desktop
executeStep 'sudo apt install xrdp -y' 'Installing XRDP'
executeStep 'sudo systemctl enable --now xrdp' 'Enabling XRDP'
executeStep 'sudo systemctl status xrdp' 'Check XRDP Status'

# 14. update PS1, shell prompt
executeStep 'cp ~/.bashrc ~/.bashrc.bkp' 'Backup Config'
executeStep 'wget https://raw.githubusercontent.com/mukherjeearnab/dotfiles/main/bash/bash_prompt.sh -O ~/bash_prompt.sh'
executeStep 'export TPROMPT=$(cat ~/bash_prompt.sh)' ''
executeStep 'sed -i "s/PS1=${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$/$TPROMPT/" ~/.bashrc' 'Update Config'
