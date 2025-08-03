# Kakathic

sudo rm -rf /usr/share/dotnet &
sudo rm -rf /opt/ghc &
sudo rm -rf /usr/local/share/boost &

User="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

Taive2 () { curl -s -L -N "$1" -o "$2"; }
unzip -qoj .github/bin.zip bin/* -d bin
#Taive2 "https://github.com/sekaiacg/erofs-utils/releases/download/v1.8.10-250719/erofs-utils-v1.8.10-g0e284fcb-Linux_x86_64-2507191652.zip" "mod2.zip" 
#Taive2 "https://github.com/sekaiacg/lptools/releases/download/lptools-250703/lptools-Linux_x86_64-2507032337.zip" mod3.zip
#unzip -qoj mod2.zip -d bin
#unzip -qoj mod3.zip -d bin
chmod -R 777 bin
PATH=bin:$PATH

TOME="$(pwd)"
MOME="$TOME/.github"
ls bin

Taiveeu(){
mausourcef="$(echo "$1" | cut -d '/' -f 5,7)"
tensourcef="$(echo "$1" | cut -d '/' -f 10)"
Taive2 "${1}?use_mirror=zenlayer&r=" "file_rom.zip" 2>&1
}

Taiveeu "$URL"
unzip -qoj file_rom.zip images/super.img.* -d imgs
listsup="$(ls $TOME/imgs/super.img.* | sort -n -t . -k 3)"
rm -fr file_rom.zip
simg2img $listsup "super.img"
rm -fr $TOME/imgs/*
lpunpack "$TOME/super.img" "$TOME/imgs" 
rm -fr $TOME/super.img
mkdir -p $TOME/vip $TOME/file
echo
ls -lh "$TOME/imgs"

for vv in $TOME/imgs/*_a.img; do
dangtype="$(gettype -i $vv)"
echo "${vv##*/}: $dangtype"
if [ "$dangtype" == 'erofs' ];then
extract.erofs -i "$vv" -o "$TOME/vip"
elif [ "$dangtype" == 'ext' ];then
python3 $TOME/bin/imgextractor.py "$vv" $TOME/vip
else
echo "Lỗi file không biết: $dangtype"
exit 1
fi
rm -f $vv
done

find $TOME/vip -type f

for bb in $FFile; do
pathzip="$(find $TOME/vip -type f -name "$bb")"
cp -rf "$pathzip" file
done

cd file
zip -jr $TOME/file.zip *
cd $TOME

# uploaded
if [ -f $TOME/file.zip ];then
url2="$(curl -s https://api.gofile.io/servers | jq -r .data.servers[0].name)"
eval "curl -L -N -H '$User' -F 'file=@file.zip' 'https://'$url2'.gofile.io/contents/uploadfile'" | jq
echo "$url2"
fi

ls vip
echo


