#!/bin/bash
echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
    echo "You are using apt-get tool"
	sudo apt-get install -y vim vim-gnome ctags xclip astyle python-setuptools python-dev git
    sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
elif which yum >/dev/null; then
    echo "You are using yum tool"
	sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel
    sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
elif which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
    sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
fi

if which pacman >/dev/null; then
    echo -e
    echo "You are using pacman tool"
    echo -e
    #sudo pacman -S gcc vim git ctags xclip astyle python-setuptools python-evdev
    if which gcc >/dev/null; then
        echo -e "gcc is installed"
    else
        sudo pacman -S gcc
    fi

    if which vim >/dev/null; then
        echo -e "vim is installed"
    else
        sudo pacman -S vim
    fi

    if which git >/dev/null; then
        echo -e "git is installed"
    else
        sudo pacman -S git
    fi

    if which ctags >/dev/null; then
        echo -e "ctags is installed"
    else
        sudo pacman -S ctags
        sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
    fi

    if which astyle >/dev/null; then
        echo -e "astyle is installed"
    else
        sudo pacman -S astyle
    fi

    if pacman -Qi python-setuptools >/dev/null; then
        echo -e "python-setuptools is installed"
    else
        sudo pacman -S python-setuptools
    fi

    if pacman -Qi python-evdev >/dev/null; then
        echo -e "python-evdev is installed"
    else
        sudo pacman -S python-evdev
    fi
fi

#sudo easy_install -ZU autopep8
if which autopep8 >/dev/null; then
    echo -e "autopep8 is installed"
else
    sudo easy_install -ZU autopep8
fi

#sudo ln -s /usr/bin/ctags /usr/local/bin/ctags

mv ~/.vim ~/.vim_old
mv ~/.vimrc ~/.vimrc_old

cd ~/ && git clone git@github.com:elinuxboy/vim-deprecated.git ~/.vim
cp ~/.vim/.vimrc ~/

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo " " > ~/temp
echo "bundle程序正在努力为您安装plugin" >> ~/temp
echo " " >> ~/temp
echo "安装完毕将自动退出" >> ~/temp
echo " " >> ~/temp
echo "请耐心等待..." >> ~/temp
echo " " >> ~/temp
vim ~/temp -c "BundleInstall" -c "q" -c "q"
rm ~/temp
echo " " >> ~/temp
echo -e
echo "安装完成"
