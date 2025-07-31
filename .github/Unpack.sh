# Kakathic
Taive2 () { curl -s -L -N "$1" -o "$2"; }
curl -sL https://github.com/althafvly/AmlogicKitchen/archive/refs/heads/master.zip \
-o mod.zip
unzip -qoj mod.zip */bin/* -d bin
PATH=$TOME/bin:$PATH
TOME="$GITHUB_WORKSPACE"
MOME="$TOME/.github"

ls bin

gettype -i $TOME/.github/mi_ext.img

Taiveeu(){
mausourcef="$(echo "$1" | cut -d '/' -f 5,7)"
tensourcef="$(echo "$1" | cut -d '/' -f 10)"
Taive2 "${1}?use_mirror=zenlayer&r=" "file_rom.zip" 2>&1
}

Taiveeu 'https://sourceforge.net/projects/xiaomi-eu-multilang-miui-roms/files/xiaomi.eu/HyperOS-STABLE-RELEASES/HyperOS2.0/xiaomi.eu_LISA_OS2.0.10.0.UKOCNXM_14.zip/download'
unzip -qoj file_rom.zip images/super.img.* -d imgs
listsup="$(ls $TOME/imgs/super.img.* | sort -n -t . -k 3)"
rm -fr file_rom.zip
simg2img $listsup "super.img"
rm -fr $TOME/imgs/*
lpunpack "$TOME/super.img" "$TOME/imgs" 
rm -fr $TOME/super.img
mkdir -p vip

for vv in $TOME/imgs/*; do
dangtype="$(gettype -i $vv)"
echo "${vv##*/}: $dangtype"
if [[ "$dangtype" == 'erofs' ]];then
extract.erofs -i "$vv" -o "$TOME/vip"
elif [[ "$dangtype" == 'ext' ]];then
python3 $TOME/bin/imgextractor.py "$vv" $TOME/vip
else
echo "Lỗi file không biết: $dangtype"
exit 1
fi
rm -f $vv
done

pathzip="$(find $TOME/vip -type f -name 'MiuiHome.apk')"

zip -jr file.zip $pathzip

ls
echo
env

