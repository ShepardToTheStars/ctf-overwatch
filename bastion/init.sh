#!/bin/sh

# Who doesn't like colors?!
RESET='\e[0m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'

echo "${BLUE}Creating user vanessa as a super user."
# I like ZSH as my default shell, so let's install it before we add my user. Then
# create my user, and give me all the conviences!
(which zsh > /dev/null 2>&1 && echo "${GREEN}zsh is already installed! Skipping installation.") \
    || (echo "${YELLOW}zsh not installed! Installing zsh..." && yum install zsh)

# wheel is the admin group. May need to add a check if vanessa is not in the wheel group.
(id -u vanessa > /dev/null 2>&1 && echo "${GREEN}vanessa already exists! Skipping creation.") \
     || (echo "${YELLOW} Creating vanessa as an admin user..." && useradd -m -s "$(which zsh)" -g wheel vanessa)

# prevents password prompt when sudo'ing
(grep 'vanessa' /etc/sudoers > /dev/null 2>&1 && echo "${GREEN}vanessa exists in sudoers file already.") || \
    (echo "${YELLOW} Adding vanessa to sudoers file..." && echo "vanessa ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers)

# setup my SSH key
echo "${BLUE}Adding ssh keys for vanessa"
mkdir -p /home/vanessa/.ssh
(grep 'vanessa@louwagie.io' /home/vanessa/.ssh/authorized_keys > /dev/null 2>&1 \
    && echo "${GREEN}SSH key for vanessa already set up!") \
    || (echo "${YELLOW}Adding SSH public key for vanessa." \
    && echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGtZ42pF4hbWQVnXxMbFWuShrYJZhcb2oKLrTeC61+XC vanessa@louwagie.io" \
    >> /home/vanessa/.ssh/authorized_keys)

