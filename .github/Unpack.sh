# Kakathic
curl -sL https://github.com/althafvly/AmlogicKitchen/archive/refs/heads/master.zip \
-o mod.zip
unzip -qoj mod.zip */bin/* -d bin
PATH=bin:$PATH
TOME="$GITHUB_WORKSPACE"
MOME="$TOME/.github"

ls bin

gettype -i $TOME/.github/mi_ext.img

Taiveeu(){
mausourcef="$(echo "$1" | cut -d '/' -f 5,7)"
tensourcef="$(echo "$1" | cut -d '/' -f 10)"
Taive2 "${1}?use_mirror=zenlayer&r=" "$tensourcef" 2>&1
}



echo
env

