#kakathic

# Home
TOME="$GITHUB_WORKSPACE"
User="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
echo -e "nameserver 1.1.1.1\nnameserver 1.0.0.1" | sudo tee /etc/resolv.conf

# function
Xem () { curl -s -G -L -N -H "$User" "$1"; }
Taive () { curl -s -L -N -H "$User" -O "$1"; }
Taive2 () { curl -s -L -N -H "$User" "$1" -o "$2"; }

# tao tm
mkdir -p Up
cd Up

echo "- Url: $URL"
(
sleep 10
echo "Kích thước sau 10s tải"
ls -lh
) &
# phát hiện sv download & tải về 
if [ "$(echo "$URL" | grep -cm1 'mega.nz')" == 1 ];then
sudo apt-get install megatools -y &>/dev/null
megadl "$URL" &> "$TOME/bug.txt"
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
if [ "$NUT2" == 'true' ];then
curl -sT "$url1" -u :829e6679-9f44-4e4e-8bdd-ffc3b19ac979 https://pixeldrain.com/api/file/ | jq -r .id | awk '{print "https://pixeldrain.com/u/"$1}'
fi

if [ "$NUT" == 'true' ];then
#res_json=$(curl -s -X GET "https://devuploads.com/api/upload/server?key=47395exzbd07av0fozl8h")
#sess_id=$(echo "$res_json" | grep -o '"sess_id":"[^"]*"' | awk -F ':' '{print $2}' | tr -d '"')
#server_url=$(echo $res_json | sed -n 's/.*"result":"\([^"]*\).*/\1/p')
#curl -s -X POST -F "sess_id=$sess_id" -F "utype=reg" -F "file=@$url1" "$server_url" | tee s.json
#echo "https://devuploads.com/$(cat s.json | jq -r .[].file_code)"
url2="$(curl -s -H "$User" https://api.gofile.io/servers | jq -r .data.servers[0].name)"
[ -z "$url2" ] && url2='upload-ap-sgp.gofile.io' || url2="$url2.gofile.io"
eval "curl -sL -N -H '$User' -F 'file=@$url1' 'https://$url2/contents/uploadfile'" | jq
#echo "$url2" | tee $TOME/tc.log
fi

#LinkDow="$(eval "curl -X POST -F 'email=kakathic@gmail.com' -F 'key=xcjdJTOsvZJhgVV10B' -F 'file=@$url1' -F 'folder=821972' https://ul.mixdrop.ag/api" | jq -r .result.url)"

echo
