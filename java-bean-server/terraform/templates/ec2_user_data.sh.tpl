#!/bin/bash
cd /home/ec2-user/
mkdir java
cd java

wget https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz

tar -xvf "\$(ls *tar.gz | tail -1)"
rm *.tar.gz

echo 'export JAVA_HOME=/home/ec2-user/java/jdk-21.0.2' >> ~/.bashrc
echo 'export PATH=\$JAVA_HOME/bin:\$PATH' >> ~/.bashrc

cd
source .bashrc

cd /home/ec2-user/
mkdir server

# Now, create the systemd service file for your server
cat <<'SERVICE' | sudo tee /etc/systemd/system/server.service > /dev/null
[Unit]
Description=Server Service
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/server/
ExecStart=/home/ec2-user/java/jdk-21.0.2/bin/java -jar /home/ec2-user/server/java-bean-server-1.0.jar
ExecStop=
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
SERVICE

# Reload systemd to recognize the new service
sudo systemctl daemon-reload