# Kakathic
Taive2 () { curl -L -N "$1" -o "$2"; }
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

Taiveeu 'https://sourceforge.net/projects/xiaomi-eu-multilang-miui-roms/files/xiaomi.eu/HyperOS-STABLE-RELEASES/HyperOS2.0/xiaomi.eu_LISA_OS2.0.10.0.UKOCNXM_14.zip/download'

ls
echo
env

