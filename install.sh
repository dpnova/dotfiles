HERE=`pwd`
sudo apt install zsh -y
chsh dpn -s `which zsh`
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mkdir -p ~/.vimrc/colors
cd ~/.vimrc/colors
wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim
ln -s `pwd`/vimrc ~/.vimrc
cd ~/Downloads
wget https://github.com/BurntSushi/ripgrep/releases/download/0.5.2/ripgrep-0.5.2-x86_64-unknown-linux-musl.tar.gz
tar xvzf ripgrep*
mkdir ~/bin
cp ripgrep-0.5.2-x86_64-unknown-linux-musl/rg ~/bin
# something
