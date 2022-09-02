# Set up prompt colors
RED='\033[0;31m' # Red
GREEN='\033[0;32m' # Green
NC='\033[0m' # No Color

# If using MacOS, customize how colors are echoed
if [[ $OSTYPE == 'darwin'* ]]; then
   ESCAPE=""
else
   ESCAPE="-e"
fi

# Change into the .dotfiles directory and update pull the repo, ignoring local changes
echo ${ESCAPE} "${RED}### ${GREEN}Pulling the latest version of the repo${NC}"
cd ~/.dotfiles
git reset --hard
git pull

echo ${ESCAPE} "${RED}### ${GREEN}Runnign the bootstrapper${NC}"
./bootstrap.sh

