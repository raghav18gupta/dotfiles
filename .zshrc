# Anaconda setup
export PATH=$HOME/miniconda3/bin:$PATH
. $HOME/miniconda3/etc/profile.d/conda.sh

# ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bob-the-frog"
plugins=(
	colorful-man
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
# ------ vars ------
export GOOGLE_APPLICATION_CREDENTIALS=~/Desktop/gitHub/projects/green-corridor-v2/serviceAccountKey.json
