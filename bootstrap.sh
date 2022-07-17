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

echo "### Installing packages"
sudo dnf install git zsh util-linux-user

echo "installing/updating ZSH plugins"
~/.local/bin/update-zsh-plugins

echo "### Changing default shell to ZSH"
sudo chsh -s $(which zsh) $(whoami)

#echo "### Sourcing ZSH config"
#source ~/.zshrc

