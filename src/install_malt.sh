#!/bin/bash
VERSION_NUMBER=1.7.2
PACKAGE=maltparser-${VERSION_NUMBER}.tar.gz

wget http://maltparser.org/dist/${PACKAGE}
tar -xf ${PACKAGE}
cd $(basename ${PACKAGE} .tar.gz)
ant jar
if [ -d ~/.local/share/malt/ ]; then
    rm -rfv ~/.local/share/malt/
fi
mkdir -p ~/.local/share/malt/
cp -Rfv dist/$(basename ${PACKAGE} .tar.gz)/* ~/.local/share/malt/
#if [ -z "$(grep -o 'alias malt=' ~/.bashrc)" ]; then
#    echo "alias malt='java -jar ~/.local/share/malt/maltparser-${VERSION_NUMBER}.jar '" >> ~/.bashrc
#fi
#source ~/.bashrc
cd ..

mkdir -p ~/.local/bin/
if [ -f ~/.local/bin/ ]; then
    rm ~/.local/bin/malt
fi
cp malt ~/.local/bin/malt

if [ $(basename $(hostname) uio.no) == $(hostname) ]; then
    echo "Make file executable, need sudo account"
    sudo chmod u+x ~/.local/bin/malt
else
    chmod u+x ~/.local/bin/malt
fi

if [ -z "$(grep -o -P '^export PATH=.*\.local/bin.*$' ~/.bashrc)" ]; then
    echo "export PATH=${HOME}/.local/bin/:${PATH}" >> ~/.bashrc
fi 
source ~/.bashrc  

rm -rf $(basename ${PACKAGE} .tar.gz)
rm ${PACKAGE}