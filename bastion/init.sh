#!/bin/sh

# Who doesn't like colors?!
export RESET='\e[0m'
export RED='\e[31m'
export GREEN='\e[32m'
export YELLOW='\e[33m'
export BLUE='\e[34m'

echo -e "${BLUE}Creating user vanessa as a super user."
# I like ZSH as my default shell, so let's install it before we add my user. Then
# create my user, and give me all the conviences!
(which zsh > /dev/null 2>&1 && echo -e "${GREEN}zsh is already installed.") \
    || (echo -e "${YELLOW}zsh not installed! Installing zsh..." && yum install zsh)

# wheel is the admin group. May need to add a check if vanessa is not in the wheel group.
(id -u vanessa > /dev/null 2>&1 && echo -e "${GREEN}vanessa already exists.") \
     || (echo -e "${YELLOW} Creating vanessa as an admin user..." && useradd -m -s "$(which zsh)" -g wheel vanessa)

# prevents password prompt when sudo'ing
(grep 'vanessa' /etc/sudoers > /dev/null 2>&1 && echo -e "${GREEN}vanessa exists in sudoers file already.") || \
    (echo -e "${YELLOW} Adding vanessa to sudoers file..." && echo "vanessa ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers)

# setup my SSH key
mkdir -p /home/vanessa/.ssh
(grep 'vanessa@louwagie.io' /home/vanessa/.ssh/authorized_keys > /dev/null 2>&1 \
    && echo -e "${GREEN}SSH key for vanessa already set up.") \
    || (echo -e "${YELLOW}Adding SSH public key for vanessa..." \
    && echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGtZ42pF4hbWQVnXxMbFWuShrYJZhcb2oKLrTeC61+XC vanessa@louwagie.io" \
    >> /home/vanessa/.ssh/authorized_keys)




