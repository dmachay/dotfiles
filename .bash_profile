export PATH="/usr/local/bin:$PATH"
export PATH="~/bin:$PATH"

# add some color to the terminal
export CLICOLOR=1
export GREP_OPTIONS="--color"
alias ls='ls -G'

# append to history rather than overwrite
shopt -s histappend

# startup virtualenv-burrito
if [ -f $HOME/.venvburrito/startup.sh ]; then
    . $HOME/.venvburrito/startup.sh
fi
