if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias gs="git status"
alias ga="git add -A"
alias gc="git commit"
alias gp="git push"
alias av="source venv/bin/activate"
alias dr="python manage.py runserver"
alias dmm="python manage.py makemigrations"
alias dm="python manage.py migrate"
alias radio="mpg123 --shuffle ~/Music/**/*.mp3"
alias vim="nvim"
alias v="nvim"
alias code="~/code/"
alias blog="~/code/blog/"
alias install="sudo pacman -S"
alias update="sudo pacman -Syu"
alias e="exit"
alias t="tmux"
alias publish-blog="~/code/blog/publish-blog.sh"
alias dtf="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias bootstrap="$HOME/.dotfiles/scripts/bootstrap.sh"
alias dtfpush='dtf add -f ~/.dotfiles/scripts/bootstrap.sh  ~/.zshrc ~/.config/i3 ~/.config/nvim && dtf commit -m "update dotfiles" && dtf push'

play() {
    mpg123 --loop -1 ~/Music/**/"$@"
}

chpwd() {
    ls
}

setopt BEEP

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

