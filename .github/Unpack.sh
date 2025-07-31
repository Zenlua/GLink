# Kakathic
curl -L https://github.com/althafvly/AmlogicKitchen/archive/refs/heads/master.zip \
-o mod.zip
unzip -qoj mod.zip */bin/* -d bin
PATH=bin:$PATH
TOME="$GITHUB_WORKSPACE"
ls bin

gettype -i $TOME/.github/mi_ext.img

echo
env

