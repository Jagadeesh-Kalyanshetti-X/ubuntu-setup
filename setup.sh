#!/bin/bash

# Update and upgrade
echo "Updating package lists..."
sudo apt-get update -y
echo "Upgrading installed packages..."
sudo apt-get upgrade -y

# Line 10-25 & fusuma Multi-touch gestures for trackpad credit: Lucciffer (Nikhil Akalwadi) @github
echo "Installing essentials..."
echo "Installing nvtop..."
sudo apt install nvtop -y
echo "Installing tmux..."
sudo apt install tmux -y
echo "Installing net-tools..."
sudo apt install net-tools -y
echo "Installing SSH..."
sudo apt install openssh-server -y
echo "Installing VSCode..."
sudo snap install code --classic 
echo "Installing Gnome Tweaks..."
sudo apt install gnome-tweak-tool -y
echo "Installing gnome shell extensions..."
sudo apt install gnome-shell-extensions -y
sudo apt install chrome-gnome-shell -y

# Nvidia drivers installation
echo "Do you want to install nvidia drivers for ubuntu desktop (Y/n)?"
read -r ans
if [["$ans" == "y" || "$ans" == Y]]; then
    sudo ubuntu-drivers install
fi

echo "Do you want to install Multi-touch gestures for trackpad?"
read -r ans 
if [["$ans" == "y" || "$ans" == Y]]; then 
    sh ./fusuma-config.sh
    sh ./fusuma-config2.sh 
fi

# Git installation
echo "Do you want to install Git (Y/n)?"
read -r ans
if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
    echo "Installing Git..."
    sudo apt-get install -y git
    
    echo "Do you want to install additional Git dependencies (Y/n)?"
    read -r dep_ans
    if [[ "$dep_ans" == "y" || "$dep_ans" == "Y" ]]; then
        echo "Installing additional dependencies..."
        sudo apt-get install -y libz-dev libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext cmake gcc
    fi
    
    # Configure Git
    echo "Enter your GitHub username:"
    read -r username
    git config --global user.name "$username"
    
    echo "Enter your GitHub email:"
    read -r email
    git config --global user.email "$email"
    
    echo "Git has been installed and configured!"
fi

echo "Do you want to install miniconda (Y/n)?"
read -r ans
if [ "$ans" = "Y" ] || [ "$ans" = "y" ]
then 
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh --no-check-certificate
    sh ./Miniconda3-latest-Linux-x86_64.sh
    echo "Miniconda installed!!"
    
    echo "Do you want to create a conda environment (Y/n)?"
    read -r ans
    if [ "$ans" = "Y" ] || [ "$ans" = "y" ]
    then
        echo "Enter conda environment name:"
        read -r env_name
        source ~/miniconda3/bin/activate
        conda create --name "$env_name"
        conda activate "$env_name"
        
        echo "These are the list of 2D-Computer-Vision-Libraries that will be installed in the $env_name: conda environment"
        grep -oP 'pip install \K.*' 2D-cv-libraries.sh
        echo "Any additional libraries other than these need to be manually installed. Do you want to proceed with the installation? (Y/n)"
        read -r ans
        if [ "$ans" = "Y" ] || [ "$ans" = "y" ]
        then
            sh 2D-cv-libraries.sh
        fi

        echo "These are the list of 3D-Computer-Vision-Libraries that will be installed in the $env_name: conda environment"
        grep -oP 'pip install \K.*' 3D-cv-libraries.sh
        echo "Any additional libraries other than these need to be manually installed. Do you want to proceed with the installation? (Y/n)"
        read -r ans
        if [ "$ans" = "Y" ] || [ "$ans" = "y" ]
        then
            sh 3D-cv-libraries.sh
    fi
fi

echo "Do you want to install Chrome (Y/n)?"
read -r ans
if [ "$ans" = "Y" ] || [ "$ans" = "y" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --no-check-certificate
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
fi

echo "Do you want to install Discord (Y/n)?"
read -r ans
if [ "$ans" = "Y" ] || [ "$ans" = "y" ]; then
    sudo snap install discord
fi

echo "Do you want to install VLC media player (Y/n)?"
read -r ans
if [ "$ans" = "Y" ] || [ "$ans" = "y" ]; then
    sudo snap install vlc
fi

sudo apt autoremove -y 
sudo apt autoclean -y

echo "Set-up finished! All selected applications and configurations have been installed successfully. It is recommended to restart your system to apply all changes."