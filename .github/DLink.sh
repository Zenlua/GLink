#kakathic

# Home
TOME="$GITHUB_WORKSPACE"
User="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

# function
Xem () { curl -s -G -L -N -H "$User" "$1"; }
Taive () { curl --dns-servers '1.1.1.1' -L -N -H "$User" -O "$1"; }
Taive2 () { curl --dns-servers '1.1.1.1' -L -N -H "$User" "$1" -o "$2"; }

# tao tm
mkdir -p Up
cd Up

echo "- Url: $URL"

# phát hiện sv download & tải về 
if [ "$(echo "$URL" | grep -cm1 'mega.nz')" == 1 ];then
sudo apt-get install megatools >/dev/null 2>/dev/null
megadl "$URL" 2>&1 | tee "$TOME/bug.txt"
elif [ "$(echo "$URL" | grep -cm1 'sourceforge.net')" == 1 ];then
mausourcef="$(echo "$URL" | cut -d '/' -f 5,7)"
tensourcef="$(echo "$URL" | cut -d '/' -f 10)"
Taive2 "${URL}?use_mirror=zenlayer&r=" "$tensourcef" 2>&1 | tee "$TOME/bug.txt"
else
Taive "$URL"
fi

# Tên file
url1="$(ls)"
echo "- Name: $url1"

# upload 
if [ "$chsv" == 1 ];then
curl --upload-file "$url1" https://transfer.sh > $TOME/1.json
else
url2="$(curl -s https://api.gofile.io/getServer | jq -r .data.server)"
eval "curl --dns-servers '1.1.1.1,8.8.8.8' -L -N -H '$User' -F 'file=@$url1' 'https://$url2.gofile.io/uploadFile'" | jq
#LinkDow="$(eval "curl -X POST -F 'email=kakathic@gmail.com' -F 'key=xcjdJTOsvZJhgVV10B' -F 'file=@$url1' -F 'folder=821972' https://ul.mixdrop.ag/api" | jq -r .result.url)"
fi
