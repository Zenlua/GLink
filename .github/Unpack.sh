# Kakathic

sudo rm -rf /usr/share/dotnet &
sudo rm -rf /opt/ghc &
sudo rm -rf /usr/local/share/boost &

User="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
echo -e "nameserver 1.1.1.1\nnameserver 1.0.0.1" | sudo tee /etc/resolv.conf

Taive2 () { curl -s -L -N "$1" -o "$2"; }
unzip -qoj .github/bin.zip bin/* -d bin
mv .github/payload-dumper-go bin
#Taive2 "https://github.com/sekaiacg/erofs-utils/releases/download/v1.8.10-250719/erofs-utils-v1.8.10-g0e284fcb-Linux_x86_64-2507191652.zip" "mod2.zip" 
#Taive2 "https://github.com/sekaiacg/lptools/releases/download/lptools-250703/lptools-Linux_x86_64-2507032337.zip" mod3.zip
#unzip -qoj mod2.zip -d bin
#unzip -qoj mod3.zip -d bin
chmod -R 777 bin
export PATH=bin:$PATH
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
[[ ":$LD_LIBRARY_PATH:" != *":$ROOT_DIR/bin:"* ]] && export LD_LIBRARY_PATH="$ROOT_DIR/bin${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

TOME="$ROOT_DIR"
MOME="$TOME/.github"

Taiveeu(){
mausourcef="$(echo "$1" | cut -d '/' -f 5,7)"
tensourcef="$(echo "$1" | cut -d '/' -f 10)"
Taive2 "${1}?use_mirror=zenlayer&r=" "file_rom.zip" 2>&1
}

echo "Đang tải xuống..."
(
sleep 10
echo "Kích thước sau 10s tải"
ls -lh "file_rom.zip"
) &
if [ "$(echo "$URL" | grep -cm1 'sourceforge.net')" == 1 ];then
Taiveeu "$URL"
else
Taive2 "$URL" "file_rom.zip"
fi

unzip -oj file_rom.zip payload.bin images/super.img.* *.br *.list -d imgs

if [ -f $TOME/imgs/payload.bin ];then
payload-dumper-go -o $TOME/imgs -p system_ext,system,product,mi_ext $TOME/imgs/payload.bin &>/dev/null
rm -fr $TOME/imgs/payload.bin
fi

if [ -n "$(ls $TOME/imgs/super.img.*)" ];then
listsup="$(ls $TOME/imgs/super.img.* | sort -n -t . -k 3)"
rm -fr file_rom.zip
simg2img $listsup "super.img"
rm -fr $TOME/imgs/*
lpunpack "$TOME/super.img" "$TOME/imgs" &>/dev/null
rm -fr $TOME/super.img
fi

mkdir -p $TOME/vip $TOME/file

for vr in $TOME/imgs/*.br; do
brotli -f -d "$vr" -o "${vr%%.*}_tmpkk" &>/dev/null
$TOME/bin/sdat2img.py "${vr%%.*}.transfer.list" "${vr%%.*}_tmpkk" "${vr%%.*}.img" &>/dev/null
done

echo
ls -lh "$TOME/imgs"

for vv in $TOME/imgs/*.img; do
[ -s $vv ] || continue
dangtype="$(gettype -i $vv)"
echo "${vv##*/}: $dangtype"
if [ "$dangtype" == 'erofs' ];then
extract.erofs -i "$vv" -o "$TOME/vip" -x &>/dev/null
elif [ "$dangtype" == 'ext' ];then
sudo python3 $TOME/bin/imgextractor.py "$vv" "$TOME/vip" &>/dev/null
else
echo "Lỗi file không biết: $dangtype"
fi
#rm -f $vv
done

for bb in $FFile; do
echo "File $bb"
pathzip="$(sudo find $TOME/vip -type f -name "$bb")"
cp -rf "$pathzip" file || echo "Error: $bb"
[ -f $TOME/imgs/$bb ] && mv $TOME/imgs/$bb file/$bb
done

cd file
zip -jr $TOME/file.zip *
cd $TOME

# uploaded
if [ -f $TOME/file.zip ];then
url2="$(curl -s https://api.gofile.io/servers | jq -r .data.servers[0].name)"
eval "curl -s -L -N -H '$User' -F 'file=@file.zip' 'https://'$url2'.gofile.io/contents/uploadfile'" | jq
echo "$url2"
fi

echo
ls vip

