# -----------------------------
# General
# -----------------------------
# based on https://qiita.com/ryuichi1208/items/2eef96debebb15f5b402
# 色を使用
autoload -Uz colors ; colors

# cdした際のディレクトリをディレクトリスタックへ自動追加
setopt auto_pushd

# ディレクトリスタックへの追加の際に重複させない
setopt pushd_ignore_dups

# emacsキーバインド
bindkey -e

# viキーバインド
#bindkey -v

# フローコントロールを無効にする
setopt no_flow_control

# ワイルドカード展開を使用する
setopt extended_glob

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の入力のみで移動する
setopt auto_cd

# bgプロセスの状態変化を即時に知らせる
setopt notify

# 8bit文字を有効にする
setopt print_eight_bit

# 終了ステータスが0以外の場合にステータスを表示する
setopt print_exit_value

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

# コマンドのスペルチェックをする
setopt correct

# コマンドライン全てのスペルチェックをする
setopt correct_all

# 上書きリダイレクトの禁止
setopt no_clobber

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# パスの最後のスラッシュを削除しない
setopt noautoremoveslash

# correct 機能を無効
unsetopt correctall

# deactivate glob expression
setopt nonomatch

# -----------------------------
# Completion
# -----------------------------
# 自動補完を有効にする
autoload -Uz compinit ; compinit

# 単語の入力途中でもTab補完を有効化
#setopt complete_in_word

# コマンドミスを修正
setopt correct

# 補完の選択を楽にする
zstyle ':completion:*' menu select

# 補完候補をできるだけ詰めて表示する
setopt list_packed

# 補完候補にファイルの種類も表示する
#setopt list_types

# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad

# 補完時の色設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true

# 補完候補に色つける
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 大文字・小文字を区別しない(大文字を入力した場合は区別する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true

# --prefix=/usr などの = 以降でも補完
setopt magic_equal_subst


# -----------------------------
# History
# -----------------------------
# 基本設定
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# ヒストリーに重複を表示しない
setopt histignorealldups

# 他のターミナルとヒストリーを共有
setopt share_history

# すでにhistoryにあるコマンドは残さない
setopt hist_ignore_all_dups

# historyに日付を表示
alias h='fc -lt '%F %T' 1'

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 履歴をすぐに追加する
setopt inc_append_history

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify


# -----------------------------
# Pyenv
# -----------------------------
eval "$(pyenv init -)"


# -----------------------------
# Alias
# -----------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias gd='git --no-pager diff --color=always'
alias gb='git --no-pager branch'
alias less='less -R'

alias tmux='tmux -u'

# nvim Docker wrapper function (with file completion)
nvim() {
    docker run --rm -it \
        --detach-keys=ctrl-q,ctrl-q \
        -u $(id -u):$(id -g) \
        -e HOME=/root \
        -e TERM="$TERM" \
        -e COLORTERM=truecolor \
        -v $HOME:$HOME \
        --workdir=$(pwd) \
        nvim "$@"
}

alias k="kubectl"

# colordiff
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
  export LESS='-R'  # to enable colordiff | less
else
  alias diff='diff -u'
fi


# -----------------------------
# Plugin
# -----------------------------
# zplugが無ければインストール
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# zplugを有効化する
source ~/.zplug/init.zsh

# プラグインList
# zplug "ユーザー名/リポジトリ名", タグ
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:init.sh
#zplug "junegunn/fzf-bin", as:command, from:gh-r, file:fzf
zplug "peco/peco"

# インストールしていないプラグインをインストール
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose


# -----------------------------
# Prompt
# -----------------------------
function git-prompt {
  local branchname branch st remote pushed upstream
  branchname=`git symbolic-ref --short HEAD 2> /dev/null`
  if [ -z $branchname ]; then
    return
  fi
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    branch=" %{${fg_bold[green]}%}($branchname)%{$reset_color%}"
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    branch=" %{${fg_bold[yellow]}%}($branchname)%{$reset_color%}"
  else
    branch=" %{${fg_bold[red]}%}($branchname)%{$reset_color%}"
  fi

  remote=`git config branch.${branchname}.remote 2> /dev/null`

  # if [ -z $remote ]; then
  #   pushed=''
  # else
  #   upstream="${remote}/${branchname}"
  #   if [[ -z `git log ${upstream}..${branchname}` ]]; then
  #     pushed="%{${fg[green]}%}[up]%{$reset_color%}"
  #   else
  #     pushed="%{${fg[red]}%}[up]%{$reset_color%}"
  #   fi
  # fi

  echo "$branch$pushed"
}

PROMPT='%{$fg_bold[blue]%}${HOST} %{$fg_bold[cyan]%}[%~]%{$reset_color%}`git-prompt` $ '
RPROMPT='%*'
setopt prompt_subst


# -----------------------------
# env
# -----------------------------
export PATH=~/bin:$PATH
. "$HOME/.local/bin/env"


# -----------------------------
# Prompt
# -----------------------------
export PATH=/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin:$PATH


# -----------------------------
# kubernetes
# -----------------------------
if type kubectl > /dev/null; then
    source <(kubectl completion zsh)
fi


# -----------------------------
# Direnv
# -----------------------------
eval "$(direnv hook zsh)"


# -----------------------------
# Set Go Path
# -----------------------------
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH


# -----------------------------
# bindkey
# -----------------------------
bindkey \^U backward-kill-line


# -----------------------------
# npm
# -----------------------------
export PATH="$HOME/.npm-global/bin:$PATH"
