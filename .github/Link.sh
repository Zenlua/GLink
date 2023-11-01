#kakathic

# install
sudo apt-get install megatools

# Home
TOME="$GITHUB_WORKSPACE"

# clear 
sudo rm -rf /usr/share/dotnet
sudo rm -rf /opt/ghc
sudo rm -rf /usr/local/share/boost

# get 
Xem "https://github.com/Zelooooo/GLink/issues/$NUMBIE" > $TOME/1.ht

# get url
URL="$(grep -m1 'dir="auto">Url:' $TOME/1.ht | grep -o 'Url:.*<' | sed 's|Url:<||' | cut -d '"' -f2)"

# tao tm
mkdir -p Up
cd Up

curl -L -N -H --connect-timeout 20 -O "$URL"
url1="$(ls)"

if [ "$chsv" == 1 ];then

else
url2="$(curl -s https://api.gofile.io/getServer | jq -r .data.server)"
eval "curl -F 'file=@$url1' 'https://$url2.gofile.io/uploadFile' > $TOME/1.json"
echo "Link download: $(cat $TOME/1.json | jq -r .data.downloadPage)"
fi

