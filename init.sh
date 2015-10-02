
PROVISION_DIR=".mac_provisioning"

echo "Install Xcode..."
sudo xcodebuild -license


echo "Install Command Line Tool"
xcode-select --install


echo "Install Homebrew"
sudo mkdir -p /usr/local && sudo chflags norestricted /usr/local && sudo chown $(whoami):admin /usr/local && sudo chown -R $(whoami):admin /usr/local
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


echo "Update Homebrew"
brew update


echo "Install Ansible"
brew install ansible
brew install python


echo "Create TMP DIR"
mkdir "$PROVISION_DIR" && cd $_
echo 'localhost' > hosts


echo "Start Provisioning..."
HOMEBREW_CASK_OPTS="--appdir=/Applications" ansible-playbook -i hosts -vv ../localhost.yml

echo "Remove TMP DIR"
cd .. && rm -fr "$PROVISION_DIR"

