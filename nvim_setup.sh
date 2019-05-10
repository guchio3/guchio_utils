# install neovim
conda install -y -c conda-forge neovim

# install dein
mkdir -p ~/.cache/dein
cd ~/.cache/dein

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
mkdir -p ~/.config/nvim
sh ./installer.sh ~/.config/nvim

# ln each setttings
cd ~/.config/nvim
ln -s ~/guchio_utils/nvim/* .
