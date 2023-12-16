#kakathic

# Home
TOME="$GITHUB_WORKSPACE"
User="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

# clear 
sudo rm -rf /usr/share/dotnet
sudo rm -rf /opt/ghc
sudo rm -rf /usr/local/share/boost

# function
Xem () { curl --dns-servers "1.1.1.1,8.8.8.8,8.8.4.4" -s -G -L -N -k -H "$User" --connect-timeout 20 "$1"; }
Taive () { curl --dns-servers "1.1.1.1,8.8.8.8,8.8.4.4" -L -N -k -H "$User" --connect-timeout 20 -O "$1"; }
Taive2 () { curl --dns-servers "1.1.1.1,8.8.8.8,8.8.4.4" -L -N -k -H "$User" --connect-timeout 20 "$1" -o "$2"; }
checktc(){ grep -co 'dir="auto">.*'$1'' $TOME/1.ht 2>/dev/null; }

# bot chat, thêm thẻ, đóng và chat, hủy chạy work, xoá thẻ 
Chatbot(){ gh issue comment $NUMBIE --body "$1" >/dev/null & echo "$1"; }
addlabel(){ gh issue edit $NUMBIE --add-label "$1" >/dev/null; }
closechat(){ [ "$1" ] && gh issue close $NUMBIE -c "$1" >/dev/null || gh issue close $NUMBIE >/dev/null; }
cancelrun(){ gh run cancel $GITHUB_RUN_ID >/dev/null; }
removelabel(){ gh issue edit $NUMBIE --remove-label "$1" >/dev/null; }
addtitle(){ gh issue edit $NUMBIE --title "$1" >/dev/null; }
chatbotedit(){ gh issue comment $NUMBIE --edit-last -b "$1" >/dev/null; }

bug(){
Chatbot "$1 <br/><br/>Report bugs at: [Discussions](https://github.com/Zelooooo/GLink/discussions)" &
addlabel "Error" &
removelabel "Wait,Link,Complete"
closechat
cancelrun
exit 0
}

# chat
Chatbot 'The process can be canceled by pressing the `Close Issues` button, or view the running process 📱[Actions](https://github.com/Zelooooo/GLink/actions/runs/'$GITHUB_RUN_ID')'

# get 
Xem "https://github.com/Zelooooo/GLink/issues/$NUMBIE" > $TOME/1.ht

# get url
URL="$(grep -m1 'dir="auto">Url:' $TOME/1.ht | grep -o 'Url:.*<' | sed 's|Url:<||' | cut -d '"' -f2)"

# get sv
if [ "$(checktc Transfer)" == 1 ];then
chsv=1
elif [ "$(checktc Gofile)" == 1 ];then
chsv=2
else
chsv=0
fi


if [ "$URL" ];then
addlabel "Wait" & removelabel "Error"
else
bug 'No link detected, stop process. Note, please leave the `Url: ` if you remove the Url it will not receive the link.'
fi

# tao tm
mkdir -p Up
cd Up

(
# phát hiện sv download & tải về 
if [ "$(echo "$URL" | grep -cm1 'mega.nz')" == 1 ];then
sudo apt-get install megatools >/dev/null 2>/dev/null
megadl "$URL" 2>&1 | tee "$TOME/bug.txt"
elif [ "$(echo "$URL" | grep -cm1 'sourceforge.net')" == 1 ];then
mausourcef="$(echo "$URL" | cut -d '/' -f 5,7)"
tensourcef="$(echo "$URL" | cut -d '/' -f 10)"
Taive2 "$(echo "${URL}?use_mirror=zenlayer&r=" | grep -om1 "https://.*.$mausourcef.*" | cut -d '"' -f1)" "$tensourcef" 2>&1 | tee "$TOME/bug.txt"
else
Taive "$URL" 2>&1 | tee "$TOME/bug.txt"
fi
echo > "$TOME/done"
) & 
# Hiện tốc độ và check close
jsdhhd=0
while true; do
if [ "$(gh issue view $NUMBIE | grep -cm1 CLOSED)" == 1 ];then
bug "The order to cancel the process has been received."
sleep 100
fi
if [ ! -e "$TOME/chat" ];then
Chatbot "Calculate loading speed..."
echo > $TOME/chat
sleep 2
fi
sleep 1
[ -e "$TOME/done" ] && break || ffngnw="$(($ffngnw + 1))"
[ "$(grep -cm1 'API rate limit' $TOME/log.txt 2>/dev/null)" == 1 ] && bug 'The download speed has exceeded the allowable limit. Please download tomorrow.'
[ "$ffngnw" -ge 2000 ] && bug '30 minute download limit has expired, canceling the run.'
if [ "$(echo "$URL" | grep -cm1 'mega.nz')" == 1 ];then
chatbotedit "$(tail -n1 $TOME/bug.txt)"
else
chatbotedit "$(tail -c80 $TOME/bug.txt | awk '{print "Total: "$3" Loaded: "$5" Speed: "$13"b"}')"
checksp="$(tail -c80 $TOME/bug.txt | awk '{print $13}')"
fi
done


# Tên file
url1="$(ls)"
echo "- Name: $url1"
[[ -e "$url1" ]] && chatbotedit "Uploading files to the server..." || bug "Download file not found, download error.<br/><br/>$(cat "$TOME/bug.txt")"
sleep 1
addtitle "Link Speed: $url1"

# upload 
(
if [ "$chsv" == 1 ];then
curl --upload-file "$url1" https://transfer.sh > $TOME/1.json
else
url2="$(curl -s https://api.gofile.io/getServer | jq -r .data.server)"
eval "curl --dns-servers '1.1.1.1,8.8.8.8,8.8.4.4' -L -N -k -H '$User' -F 'file=@$url1' 'https://$url2.gofile.io/uploadFile' 2>&1 > $TOME/1.json"
#LinkDow="$(eval "curl -X POST -F 'email=kakathic@gmail.com' -F 'key=xcjdJTOsvZJhgVV10B' -F 'file=@$url1' -F 'folder=821972' https://ul.mixdrop.ag/api" | jq -r .result.url)"
fi
echo > $TOME/bone
) & (
stken=0
while true; do
[ -e "$TOME/bone" ] && break || stken="$(($stken + 1))"
sleep 1
[ "$stken" -ge 2000 ] && bug '30 minute upload limit has expired, canceling the run.'
done
)

# link download 
if [ "$(cat $TOME/1.json)" ];then
removelabel "Wait,Link,Error"
addlabel "Complete"
[ "$chsv" == 1 ] && closechat "$(cat $TOME/1.json)" || closechat "$(cat $TOME/1.json | jq)"
else
bug "Download link not found, upload error. $(cat $TOME/1.json | jq)"
fi
