#kakathic

# install
sudo apt-get install megatools

TOME="$GITHUB_WORKSPACE"

sudo rm -rf /usr/share/dotnet
sudo rm -rf /opt/ghc
sudo rm -rf /usr/local/share/boost
mkdir -p Up
cd Up
curl -L -N -H --connect-timeout 20 -O "$FEATURE"
url1="$(ls)"

if [ "$chsv" == 1 ];then

else
url2="$(curl -s https://api.gofile.io/getServer | jq -r .data.server)"
eval "curl -F 'file=@$url1' 'https://$url2.gofile.io/uploadFile' > $TOME/1.json"
echo "Link download: $(cat $TOME/1.json | jq -r .data.downloadPage)"
fi

