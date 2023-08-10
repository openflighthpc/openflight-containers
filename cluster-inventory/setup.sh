#
# Bash Script to Setup Container
#

dnf install -y flight-runway
dnf install -y git gcc lsof

git clone --depth=1 --no-single-branch https://github.com/openflighthpc/flight-hunter /root/flight-hunter
cd /root/flight-hunter
git checkout develop
/opt/flight/bin/bundle install

# Configure Hunter
cat << 'EOF' > /root/flight-hunter/etc/config.yml
port: 8888
auth_key: hunter
EOF

cat << 'EOF' > /usr/lib/systemd/system/flight-hunter.service
[Unit]
Description=Flight Hunter

[Service]
ExecStart=/opt/flight/bin/ruby /root/flight-hunter/bin/hunter hunt

[Install]
WantedBy=multi-user.target
EOF

systemctl enable flight-hunter

mkdir -p /root/bin/utils
cat << 'EOF' > /root/bin/hunter
#!/bin/bash -l

/opt/flight/bin/ruby /root/flight-hunter/bin/hunter $@
EOF
chmod +x /root/bin/hunter

curl https://raw.githubusercontent.com/openflighthpc/cluster-inventory/main/scripts/modify > /root/bin/modify
chmod +x /root/bin/modify

curl https://raw.githubusercontent.com/openflighthpc/cluster-inventory/main/scripts/open_for_editing.rb > /root/bin/utils/open_for_editing.rb
chmod +x /root/bin/utils/open_for_editing.rb
