# install neovim
$HOME/anaconda3/bin/conda install -y -c conda-forge neovim

# install dein
mkdir -p ~/.cache/dein
cd ~/.cache/dein

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
mkdir -p ~/.config/nvim
sh ./installer.sh ~/.config/nvim

# ln each setttings
cd ~/.config/nvim
ln -s ~/guchio_utils/nvim/* .

# mk conda env for nvim packages
$HOME/anaconda3/bin/conda create -n neovim-3 python=3.7
$HOME/anaconda3/envs/neovim-3/bin/pip install neovim
$HOME/anaconda3/bin/conda create -n neovim-2 python=2.7
$HOME/anaconda3/envs/neovim-2/bin/pip install neovim
