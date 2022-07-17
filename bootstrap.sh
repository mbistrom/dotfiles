echo "Pulling the latest version of the repo"
git pull

echo "Creating symlinks for dotfiles"
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

echo "installing packages"
dnf install git zsh util-linux-user

echo "Changing default shell to ZSH"
chsh -s $(which zsh)
