#!/usr/bin/env bash

install() {
  files=$(ls | grep -v install.sh | grep -v apps.sh | grep -v README.adoc)
  for file in ${files}
  do
	echo "Linking $file"
	ln -sf "$HOME/.dotfiles/${file}" "$HOME/.${file}"
  done
}

if [[ -d "$HOME/.dotfiles" ]]
then
  echo "$HOME/.dotfiles already exists, will attempt to update it"
  cd "$HOME/.dotfiles" || exit
  git pull
  install
else
  echo "Installing dotfiles"
  git clone https://github.com/mvillafuertem/dotfiles.git "$HOME/.dotfiles"
  cd "$HOME/.dotfiles" || exit
  install
fi

echo "Installing Apps"
echo ./apps

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
  && brew install bash \
  && echo $(brew --prefix)/bin/bash | sudo tee -a \
  && brew install vim \
  && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  && brew install node \
  && brew install yarn \
  && brew tap caskroom/fonts \
  && brew cask install font-hack-nerd-font

exit 0
