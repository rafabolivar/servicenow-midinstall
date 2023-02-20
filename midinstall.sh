#!/bin/bash

INSTANCE="bderafademo"
MIDNAME="rafa_mid"
MIDUSER="miduser"
MIDPASSWD="your_mid_password"
MIDSW="https://install.service-now.com/glide/distribution/builds/package/app-signed/mid-linux-installer/2022/12/05/mid-linux-installer.tokyo-07-08-2022__patch4-11-23-2022_12-05-2022_2132.linux.x86-64.deb"
MIDGPG="https://install.service-now.com/glide/distribution/builds/package/app-signed/mid-linux-installer/2022/12/05/mid-linux-installer.tokyo-07-08-2022__patch4-11-23-2022_12-05-2022_2132.linux.x86-64-deb.zip"

echo "Installing required packages"
echo "----------------------------"
sudo apt-get -y update
sudo apt-get -y install unzip
sudo apt-get -y install dpkg-sig

echo "Downloading software"
echo "--------------------"
mkdir -p /home/$USER/midserver
wget $MIDSW -O /home/$USER/midserver/midserver.deb
wget $MIDGPG -O /home/$USER/midserver/midserver_key.zip

echo "Installing MID Server"
echo "---------------------"
unzip /home/$USER/midserver/midserver_key.zip -d /home/$USER/midserver/
gpg --import /home/$USER/midserver/gpg-key.pem 
dpkg-sig --verify /home/$USER/midserver/midserver.deb
sudo dpkg -i /home/$USER/midserver/midserver.deb
sudo /opt/servicenow/mid/agent/installer.sh -silent -INSTANCE_URL https://$INSTANCE.service-now.com -MUTUAL_AUTH N -MID_USERNAME $MIDUSER -MID_PASSWORD $MIDPASSWD -USE_PROXY N -MID_NAME $MIDNAME -APP_NAME mid -APP_LONG_NAME ServiceNow_MID_Server_Mid -NON_ROOT_USER $USER
echo "Waiting for MID Server to connect"
echo "---------------------------------"
sleep 20

echo "Validating MID Server $MIDNAME with instance $INSTANCE"
echo "---------------------------------------------------------------"
curl -u $MIDUSER:$MIDPASSWD -v -H "Accept: application/json" -H "Content-Type: application/json" -X POST --data "{}" https://$INSTANCE.service-now.com/api/snc/midvalidate/$MIDNAME
