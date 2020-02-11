#!/bin/sh

# Who doesn't like colors?!
export RESET='\e[0m'
export RED='\e[31m'
export GREEN='\e[32m'
export YELLOW='\e[33m'
export BLUE='\e[34m'

echo -e "${BLUE}Create vanessa as a super user.${RESET}"
# I like ZSH as my default shell, so let's install it before we add my user. Then
# create my user, and give me all the conviences!
(which zsh > /dev/null 2>&1 && echo -e "${GREEN}zsh is already installed.${RESET}") \
    || (echo -e "${YELLOW}zsh not installed! Installing zsh...${RESET}" && yum install zsh)

# wheel is the admin group. May need to add a check if vanessa is not in the wheel group.
(id -u vanessa > /dev/null 2>&1 && echo -e "${GREEN}vanessa already exists.${RESET}") \
     || (echo -e "${YELLOW} Creating vanessa as an admin user...${RESET}" && useradd -m -s "$(which zsh)" -g wheel vanessa)

# prevents password prompt when sudo'ing
(grep 'vanessa' /etc/sudoers > /dev/null 2>&1 && echo -e "${GREEN}vanessa exists in sudoers file already.${RESET}") || \
    (echo -e "${YELLOW} Adding vanessa to sudoers file...${RESET}" && echo "vanessa ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers)

# setup my SSH key
mkdir -p /home/vanessa/.ssh
(grep 'vanessa@louwagie.io' /home/vanessa/.ssh/authorized_keys > /dev/null 2>&1 \
    && echo -e "${GREEN}SSH key for vanessa already set up.${RESET}") \
    || (echo -e "${YELLOW}Adding SSH public key for vanessa...${RESET}" \
    && echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGtZ42pF4hbWQVnXxMbFWuShrYJZhcb2oKLrTeC61+XC vanessa@louwagie.io" \
    >> /home/vanessa/.ssh/authorized_keys)


curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh > /tmp/ohmyzsh-install.sh
sh /tmp/ohmyzsh-install.sh --unattended
runuser -l vanessa -c 'sh /tmp/ohmyzsh-install.sh --unattended' 

echo -e "${BLUE}Resizing Root Partition.${RESET}"
# Easy mode! No praying to the fdisk gods for me!
rootfs-expand

echo -e "${BLUE}Install applications.${RESET}"

# Need to do a work-around to install the epel yum repo
cat > /etc/yum.repos.d/epel.repo << EOF
[epel]
name=Epel rebuild for armhfp
baseurl=https://armv7.dev.centos.org/repodir/epel-pass-1/
enabled=1
gpgcheck=0

EOF

yum check-update
yum install -y epel-release 
yum install -y git zsh bash net-tools wireless-tools
yum update -y
yum clean all