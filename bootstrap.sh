echo "### Pulling the latest version of the repo"
git pull

echo "### Creating necessary folders"
mkdir ~/.local
mkdir ~/.local/bin
mkdir ~/.local/share

echo "### Creating symlinks for dotfiles"
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.local/bin/update-zsh-plugins ~/.local/bin/update-zsh-plugins

#echo "### Installing packages"
#sudo dnf -y install git zsh util-linux-user

echo "### Installing dependencies (git, zsh & chsh)"

echo "### Detecting package manager"

if VERB="$( which apt-get )" 2> /dev/null; then
   echo "### Debian-based distro detected - Using APT"
   sudo apt-get -y install git zsh
elif VERB="$( which yum )" 2> /dev/null; then
   echo "### Modern Red Hat-based distro detected - Using Yum"
   sudo yum -y install git zsh util-linux-user
elif [[ $OSTYPE == 'darwin'* ]]; then
   echo "### MacOS detected - Checking for Homebrew"
   if VERB="$( which brew )" 2> /dev/null; then
       echo "### Using Homebrew"
       brew install git
   else
       echo "### Homebrew not found - Please install it!"
   fi
else
   echo "### No package manager detected - Cannot install dependencies - Exiting" >&2
   exit 1
fi

echo "### Installing/updating ZSH plugins"

~/.local/bin/update-zsh-plugins

echo "### Changing default shell to ZSH"
sudo chsh -s $(which zsh) $(whoami)

echo "### Starting ZSH..."

zsh

echo "Done, I guess?"

#echo "### Sourcing ZSH config"
#source ~/.zshrc

