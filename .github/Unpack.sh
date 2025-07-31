# Kakathic
User="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
echo -e "nameserver 1.1.1.1\nnameserver 1.0.0.1" | sudo tee /etc/resolv.conf

Taive2 () { curl -L -N "$1" -o "$2"; }
unzip -qoj .github/bin.zip bin/* -d bin
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

# uploaded
if [ -f $TOME/file.zip ];then
url2="$(curl -s https://api.gofile.io/servers | jq -r .data.servers[0].name)"
eval "curl -L -N -H '$User' -F 'file=@file.zip' 'https://'$url2'.gofile.io/contents/uploadfile'" | jq
echo "$url2"
fi

ls
echo
env

