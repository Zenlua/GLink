#kakathic

# Home
TOME="$GITHUB_WORKSPACE"
User="User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36"

# clear 
#sudo rm -rf /usr/share/dotnet
#sudo rm -rf /opt/ghc
#sudo rm -rf /usr/local/share/boost

# function
Xem () { curl -s -G -L -N -H "$User" --connect-timeout 20 "$1"; }
Taive () { curl -L -N -H "$User" --connect-timeout 20 -O "$1"; }
checktc(){ grep -co 'dir="auto">.*'$1'' $TOME/1.ht 2>/dev/null; }

# bot chat, thêm thẻ, đóng và chat, hủy chạy work, xoá thẻ 
Chatbot(){ gh issue comment $NUMBIE --body "$1" 2>/dev/null & echo "$1"; }
addlabel(){ gh issue edit $NUMBIE --add-label "$1"; }
closechat(){ gh issue close $NUMBIE -c "$1" 2>/dev/null; }
cancelrun(){ gh run cancel $GITHUB_RUN_ID; }
removelabel(){ gh issue edit $NUMBIE --remove-label "$1"; }
addtitle(){ gh issue edit $NUMBIE --title "$1"; }

bug(){
closechat "$1"
closechat "Report bugs at: [Discussions](https://github.com/Zelooooo/GLink/discussions)"
addlabel "Error"
removelabel "Wait"
cancelrun
}

# chat
Chatbot "Start looking for links..."
Chatbot 'The process can be canceled by pressing the `Close Issues` button'

# get 
Xem "https://github.com/Zelooooo/GLink/issues/$NUMBIE" > $TOME/1.ht

# get url
URL="$(grep -m1 'dir="auto">Url:' $TOME/1.ht | grep -o 'Url:.*<' | sed 's|Url:<||' | cut -d '"' -f2)"

# get sv
chsv="$(checktc Transfer)"

if [ "$URL" ];then
Chatbot "Link detected: $URL"
addlabel "Wait"
else
bug "No link detected, stop process."
fi

# tao tm
mkdir -p Up
cd Up

Chatbot "Download to your device..."
# phát hiện sv
[ "$(echo "$URL" | grep -cm1 'mega.nz')" == 1 ] && SVD=1
(
# Tải về 
if [ "$SVD" = 1 ];then
sudo apt-get install megatools >/dev/null 2>/dev/null
megadl "$URL"
else
Taive "$URL"
fi
echo > "$TOME/done"
) & (
# Tải rom và tải file khác
while true; do
if [ "$(gh issue view $NUMBIE | grep -cm1 CLOSED)" == 1 ];then
bug "The order to cancel the process has been received."
else
[ -e "$TOME/done" ] && break
sleep 10
fi
done
)

# Tên file
url1="$(ls)"
echo "- Name: $url1"
[ "$url1" ] && Chatbot "Uploading files to the server..." || bug "Download file not found, download error."
addtitle "Link Speed: $url1"

# upload 
if [ "$chsv" == 1 ];then
LinkDow="$(curl --upload-file "$url1" https://transfer.sh)"
else
url2="$(curl -s https://api.gofile.io/getServer | jq -r .data.server)"
eval "curl -F 'file=@$url1' 'https://$url2.gofile.io/uploadFile' > $TOME/1.json"
LinkDow="$(cat $TOME/1.json | jq -r .data.downloadPage)"
fi

# link download 
if [ "$LinkDow" ];then
removelabel "Wait"
addlabel "Complete"
closechat "Link download: $LinkDow"
else
bug "Download link not found, upload error."
fi
