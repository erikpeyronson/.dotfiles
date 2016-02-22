dir=~/.dotfiles                    # dotfiles directory
confdir=~/.dotfiles/.config        # config directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files=".bashrc .emacs .bash_aliases .bash_logout .emacs.d"        # list of files/folders to symlink in homedir
folders="terminator"
##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/.dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done

#The same as above but folders in .config
for folder in $folders; do
    echo "Moving old folders from .config to $olddir/.config_old"
    mv ~/.config/$folder ~/.dotfiles_old/.config_old
    echo "Creating symlink to $file in .comfig directory."
    ln -s $confdir/$folder ~/.config/$folder
done

source ~/.bashrc
