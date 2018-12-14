#!/bin/bash

# 打印logo
function print_logo()
{
    color="$(tput setaf 6)"
    normal="$(tput sgr0)"
    printf "${color}"
    echo '        __                         '
    echo '__   __/_/___ ___ '
    echo '\ \ / / / __ `__ \'
    echo ' \ V / / / / / / /  '
    echo '  \_/_/_/ /_/ /_/  '
    echo '                                    '
    echo ''
    echo ''
    echo 'Just enjoy it!'
    echo 'p.s. Follow me at https://github.com/elinuxboy/vim-deprecated.'
    echo ''
    printf "${normal}"
}

# 备份旧文件
function backup_old_files()
{
    echo "backup old files"
    mv ${HOME}/.vim ${HOME}/.vim_old
    mv ${HOME}/.vimrc ${HOME}/.vimrc_old
}

# 下载vim 和 vundle插件
function download_vim_and_plug()
{
    echo "download vim-deprecated"
    git clone git@github.com:elinuxboy/vim-deprecated.git ${HOME}/.vim

    cp ${HOME}/.vim/.vimrc ${HOME}/

    echo "download vundle"
    git clone https://github.com/gmarik/vundle.git ${HOME}/.vim/bundle/vundle
}

# 安装插件
function bundle_install_vim_plugin()
{
    echo " " > ${HOME}/temp
    echo "插件管理软件正在努力为您安装插件" >> ${HOME}/temp
    echo " " >> ${HOME}/temp
    echo "安装完毕将自动退出" >> ${HOME}/temp
    echo " " >> ${HOME}/temp
    echo "请耐心等待..." >> ${HOME}/temp
    echo " " >> ${HOME}/temp
    vim ${HOME}/temp -c "BundleInstall" -c "q" -c "q"
}

# 完成安装
function end_install()
{
    rm ${HOME}/temp
    echo -e
    echo "安装完成"
}

# 安装archlinux发行版必要软件
function install_prepare_software_on_archlinux()
{
    echo "install_prepare_software_on_archlinux"
    #sudo pacman -S --noconfirm gcc vim git ctags xclip astyle python-setuptools python-evdev
    if which gcc >/dev/null; then
        echo -e "gcc is installed"
    else
        sudo pacman -S --noconfirm gcc
    fi

    if which vim >/dev/null; then
        echo -e "vim is installed"
    else
        sudo pacman -S --noconfirm vim
    fi

    if which git >/dev/null; then
        echo -e "git is installed"
    else
        sudo pacman -S --noconfirm git
    fi

    if which ctags >/dev/null; then
        echo -e "ctags is installed"
    else
        sudo pacman -S --noconfirm ctags
        sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
    fi

    if which astyle >/dev/null; then
        echo -e "astyle is installed"
    else
        sudo pacman -S --noconfirm astyle
    fi

    if pacman -Qi python-setuptools >/dev/null; then
        echo -e "python-setuptools is installed"
    else
        sudo pacman -S --noconfirm python-setuptools
    fi

    if pacman -Qi python-evdev >/dev/null; then
        echo -e "python-evdev is installed"
    else
        sudo pacman -S --noconfirm python-evdev
    fi

    if which autopep8 >/dev/null; then
        echo -e "autopep8 is installed"
    else
        sudo easy_install -ZU autopep8
    fi
}

# 在archlinux上开始安装vim
function begin_install_vim_on_archlinux()
{
    echo "begin_install_vim_on_archlinux"
    backup_old_files
    download_vim_and_plug
    bundle_install_vim_plugin
    end_install
    print_logo
}

# 在archlinux发行版安装vim
function install_vim_on_archlinux()
{
    echo "install_vim_on_archlinux"
    install_prepare_software_on_archlinux
    begin_install_vim_on_archlinux
}

# 在linux平台安装vim
function install_vim_on_linux()
{
    type=`get_linux_platform_type`
    echo "linux platform type: "${type}

    echo "install_vim_on_linux"

    if [ ${type} == "debain" ]; then
        install_vim_on_ubuntu
    elif [ ${type} == "redhat" ]; then
        install_vim_on_centos
    elif [ ${type} == "archlinux" ]; then
        install_vim_on_archlinux
    else
        echo "not support this linux platform type: "${type}
    fi
}

# 获取平台类型，mac还是linux平台
function get_platform_type()
{
    echo $(uname)
}

# 获取linux平台类型
function get_linux_platform_type()
{
    if which apt-fast > /dev/null ; then
        echo "debian" # debian ubuntu系列
    elif which yum > /dev/null ; then
        echo "redhat" # redhat centos系列
    elif which pacman > /dev/null; then
        echo "archlinux" # archlinux系列
    else
        echo "invaild"
    fi
}

# main函数
function main()
{
    type=`get_platform_type`
    echo "platform type: "${type}

    if [ ${type} == "Darwin" ]; then
        install_vim_on_mac
    elif [ ${type} == "Linux" ]; then
        install_vim_on_linux
    else
        echo "not support platform type: "${type}
    fi
}

# 调用main函数
main