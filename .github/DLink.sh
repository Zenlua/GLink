#kakathic

# Home
TOME="$GITHUB_WORKSPACE"
User="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
echo -e "nameserver 1.1.1.1\nnameserver 1.0.0.1" | sudo tee /etc/resolv.conf

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
[ -z "$url2" ] && url2="store$(( $RANDOM % 8 + 1 ))"
[ "$url2" == "null" ] && url2="store$(( $RANDOM % 8 + 1 ))"
eval "curl --dns-servers '1.1.1.1' -L -N -H '$User' -F 'file=@$url1' 'https://'$url2'.gofile.io/uploadFile'" | jq
echo "$url2" | tee $TOME/tc.log

res_json=$(curl -s -X GET "https://devuploads.com/api/upload/server?key=47395exzbd07av0fozl8h")
sess_id=$(echo "$res_json" | grep -o '"sess_id":"[^"]*"' | awk -F ':' '{print $2}' | tr -d '"')
server_url=$(echo $res_json | sed -n 's/.*"result":"\([^"]*\).*/\1/p')
curl --dns-servers '1.1.1.1' -s -X POST -F "sess_id=$sess_id" -F "utype=reg" -F "file=@$url1" "$server_url" | jq -r .file_code | awk '{print "https://devuploads.com/"$0}'

while true; do
if [ -e $TOME/tc.log ];then
break
else
sleep 1
fi
done

#LinkDow="$(eval "curl -X POST -F 'email=kakathic@gmail.com' -F 'key=xcjdJTOsvZJhgVV10B' -F 'file=@$url1' -F 'folder=821972' https://ul.mixdrop.ag/api" | jq -r .result.url)"
fi
