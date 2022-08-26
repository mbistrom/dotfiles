RED='\033[0;31m' # Red
GREEN='\033[0;32m' # Green
NC='\033[0m' # No Color

if [[ $OSTYPE == 'darwin'* ]]; then
   ESCAPE=""
else
   ESCAPE="-e"
fi

echo ${ESCAPE} "${RED}### ${GREEN}Pulling the latest version of the repo${NC}"
cd ~/.dotfiles
git pull

echo ${ESCAPE} "${RED}### ${GREEN}Creating necessary folders${NC}"
mkdir ~/.local
mkdir ~/.local/bin
mkdir ~/.local/share

echo ${ESCAPE} "${RED}### ${GREEN}Creating symlinks for dotfiles${NC}"
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.local/bin/update-zsh-plugins ~/.local/bin/update-zsh-plugins

#echo ${ESCAPE} "${RED}### ${GREEN}Installing packages${NC}"
#sudo dnf -y install git zsh util-linux-user

echo ${ESCAPE} "${RED}### ${GREEN}Installing dependencies (git, zsh & chsh)${NC}"
echo ${ESCAPE} "${RED}### ${GREEN}Detecting package manager${NC}"

if VERB="$( which apt-get )" 2> /dev/null; then
   echo ${ESCAPE} "${RED}### ${GREEN}Debian-based distro detected - Using APT${NC}"
   sudo apt-get -y install git zsh
elif VERB="$( which yum )" 2> /dev/null; then
   echo ${ESCAPE} "${RED}### ${GREEN}Modern Red Hat-based distro detected - Using Yum${NC}"
   sudo yum -y install git zsh util-linux-user
elif [[ $OSTYPE == 'darwin'* ]]; then
   echo ${ESCAPE} "${RED}### ${GREEN}MacOS detected - Checking for Homebrew${NC}"
   if VERB="$( which brew )" 2> /dev/null; then
       echo ${ESCAPE} "${RED}### ${GREEN}Using Homebrew${NC}"
       brew install git
   else
       echo ${ESCAPE} "${RED}### Homebrew not found - Please install it!${NC}"
       exit 1
   fi
else
   echo ${ESCAPE} "${RED}### No package manager detected - Cannot install dependencies - Exiting${NC}" >&2
   exit 1
fi

echo ${ESCAPE} "${RED}### ${GREEN}Installing/updating ZSH plugins${NC}"

~/.local/bin/update-zsh-plugins

echo ${ESCAPE} "${RED}### ${GREEN}Changing default shell to ZSH${NC}"
sudo chsh -s $(which zsh) $(whoami)

echo ${ESCAPE} "${RED}### ${GREEN}Starting ZSH...${NC}"

zsh
