#Script for backing up old and downloading fresh copies of files from server

localdir=~/Viktigt             # Directory cointaining files on local machine
servdir=/home/files/Viktigt    #                     -||-        server machine
olddir=~/Viktigt/viktigt.old   # Directory for backup of old files
files="pwddb.kdb pwdkey"       # List of files to sync
hostname="peyron@ssh.peyronson.se" # Username@hostname to remote server

#Creating the needed folders.
echo "Creating $localdir $olddir"
mkdir -p $localdir
mkdir -p $olddir
echo "done"

# Change to $localdir directory 
echo "Changing to $localdir directory"
cd $localdir
echo "Done"

#Move old files to $olddir directory and download fresh
for file in $files; do
    echo "Moving old $file to $olddir"
    mv $localdir/$file $olddir
    echo "Done"
    echo "Downloading remote copy of $file"
    scp $hostname:$servdir/$file $localdir
    echo "Done"
done
