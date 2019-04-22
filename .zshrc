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

# ------ alias/functions ------
gacp(){
	git add .
	git commit -m "$1"
	git push origin master
}

printer_setup(){
	setopt +o nomatch
	for f in /dev/usb/lp*; do
		if [ -e "$f" ]; then
			echo "Restarting org.cups.cupsd.service..."
			sudo systemctl restart org.cups.cupsd.service
			echo "Configuring printer..."
			sudo /usr/bin/lpadmin -p LBP2900 -m CNCUPSLBP2900CAPTK.ppd -v ccp://localhost:59687 -E
			sudo /usr/bin/ccpdadmin -p LBP2900 -o $f
			echo "Restarting ccpd.service..."
			sudo systemctl restart ccpd.service
			echo "Done!"
		else
			echo "Looks like No printer attached"
		fi
		break
	done
	unsetopt +o nomatch
}