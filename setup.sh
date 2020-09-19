# == check the number of args ==
if [ $# -ne 1 ]; then
    echo "invalid # of args"
    echo "your's is $#, but only 1 (cpu or gpu) is needed."
    exit 1
fi

mkdir $HOME/mnt
chmod 777 $HOME/mnt


# == install basic packages ==
sudo apt update
sudo apt install -y unzip sshfs wget htop git ncurses-term exuberant-ctags


# == set locale ==
sudo apt-get update && apt-get install -y locales
locale-gen en_US.UTF-8  
LANG=en_US.UTF-8  
LANGUAGE=en_US:en  
LC_ALL=en_US.UTF-8


# == set dotfiles ==
cd $HOME
git clone https://github.com/guchio3/guchio_utils.git
rm .bashrc && ln -s $HOME/guchio_utils/.bashrc .bashrc
ln -s $HOME/guchio_utils/.tmux.conf .tmux.conf
mkdir -p .config/nvim/
ln -s $HOME/guchio_utils/nvim/* .config/nvim/


# == set git ==
git config --global user.email "astt.hwhw@gmail.com"
git config --global user.name "guchio3"


# == put git-completion and bash-completion seed ==
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash \
    && chmod a+x ~/.git-completion.bash
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh \
    && chmod a+x ~/.git-prompt.sh

# == install and setup conda env
# dl and install anaconda
curl -o ~/anaconda.sh -O https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
chmod +x ~/anaconda.sh
~/anaconda.sh -b -p ~/anaconda3
rm ~/anaconda.sh

# set path
PATH=$HOME/anaconda3/bin:$PATH

# install basic libs
$HOME/anaconda3/bin/conda install -y python=$PYTHON_VERSION ipython flake8 autopep8
$HOME/anaconda3/bin/conda install -y -c conda-forge tmux isort pudb clangdev
$HOME/anaconda3/bin/conda clean -ya
$HOME/anaconda3/bin/pip install ninja kaggle imgcat


# == install and setup neovim ==
# install neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

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
$HOME/anaconda3/bin/conda create -y -n neovim-3 python=3.7
$HOME/anaconda3/envs/neovim-3/bin/pip install neovim jedi
$HOME/anaconda3/bin/conda create -y -n neovim-2 python=2.7
$HOME/anaconda3/envs/neovim-2/bin/pip install neovim jedi


# == set ctags ==
ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./pylibs.tags $($HOME/anaconda3/bin/python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")
mkdir ~/.config/nvim/tags/
mv pylibs.tags ~/.config/nvim/tags/


# == install and setup docker (setup gpu if needed) ==
cd $HOME/guchio_utils
if [ $1 = gpu ]; then
    sh gpu_setup.sh
    sh docker_setup.sh gpu
elif [ $1 = cpu ]; then
    sh docker_setup.sh cpu
else
    echo "invalid argment, $1"
    exit 1
fi
