#!/bin/sh

yum check-update \
    && yum install -y epel-release git zsh bash net-tools wireless-tools \
    && yum update -y