# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

source ~/.oh-my-zsh/plugins/virtualenv/virtualenv.plugin.zsh
source ~/.oh-my-zsh/plugins/virtualenvwrapper/virtualenvwrapper.plugin.zsh
unset VIRTUAL_ENV_DISABLE_PROMPT
