#!/bin/sh

# I like ZSH as my default shell, so let's install it before we add my user. Then
# create my user, and give me all the conviences!
yum install zsh

# wheel is the admin group
id -u vanessa > /dev/null 2>&1 \
     || useradd -m -s "$(which zsh)" -g wheel vanessa 

# prevents password prompt when sudo'ing
grep 'vanessa' /etc/sudoers > /dev/null 2>&1 || echo "vanessa ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 

# setup my SSH key
mkdir -p /home/vanessa/.ssh
grep 'vanessa@louwagie.io' /home/vanessa/.ssh/authorized_keys > /dev/null 2>&1 \
    || echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGtZ42pF4hbWQVnXxMbFWuShrYJZhcb2oKLrTeC61+XC vanessa@louwagie.io" \
    >> /home/vanessa/.ssh/authorized_keys

