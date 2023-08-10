dnf install -y openssh openssh-clients

cat << 'EOF' > /root/start.sh
#!/bin/bash
KEY=/root/.ssh/id_flightadmin
if [ ! -f $KEY ] ; then
    ssh-keygen -t rsa -q -f $KEY -N '' -C flightadmin-ssh-key
    echo "Host *" >> /root/.ssh/config
    echo "  IdentityFile $KEY" >> /root/.ssh/config
fi

/usr/bin/socat -U TCP4-LISTEN:1234,reuseaddr,fork FILE:"${KEY}.pub",rdonly
EOF

chmod +x /root/start.sh

dnf install -y socat

cat << 'EOF' > /usr/lib/systemd/system/flight-sharepubkey.service
[Unit]
Description=Share Public SSH Key On Port 1234

[Service]
ExecStart=/root/start.sh

[Install]
WantedBy=multi-user.target
EOF

systemctl enable flight-sharepubkey 

