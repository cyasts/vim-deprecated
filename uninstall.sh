#!/bin/sh
rm -f ${HOME}/.vimrc
rm -rf ${HOME}/.vim
mv -f ${HOME}/.vimrc_old ${HOME}/.vimrc
mv -f ${HOME}/.vim_old ${HOME}/.vim

echo "uninstall Done"
