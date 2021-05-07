sudo apt update

sudo apt install -y curl ufw nginx vim

curl -L -o /tmp/jamulus_headless_3.7.0_ubuntu_amd64.deb \
  https://github.com/jamulussoftware/jamulus/releases/download/r3_7_0/jamulus_headless_3.7.0_ubuntu_amd64.deb

sudo apt install -y /tmp/jamulus_headless_3.7.0_ubuntu_amd64.deb

sudo systemctl enable jamulus-headless

sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 22124/udp
sudo ufw enable

sudo sed -i.bak "s/ExecStart=.*/ExecStart=\/bin\/sh -c '\/usr\/bin\/jamulus-headless -s -n -u 20 -T --htmlstatus \/etc\/html\/status.html'/g" /lib/systemd/system/jamulus-headless.service
cat /lib/systemd/system/jamulus-headless.service

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo apt-key add -
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee -a /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install -y caddy

sudo mkdir -p /etc/html
sudo chown -R jamulus:root /etc/html

sudo systemctl enable caddy

