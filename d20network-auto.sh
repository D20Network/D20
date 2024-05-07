#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y

cd $HOME

wget "https://dl.walletbuilders.com/download?customer=76c3a31aaf131d2f91df88414d71c0b8bd21a6f29aa93da681&filename=d20network-qt-linux.tar.gz" -O d20network-qt-linux.tar.gz

mkdir $HOME/Desktop/D20Network

tar -xzvf d20network-qt-linux.tar.gz --directory $HOME/Desktop/D20Network

mkdir $HOME/.d20network

cat << EOF > $HOME/.d20network/d20network.conf
rpcuser=rpc_d20network
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node3.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/D20Network/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./d20network-qt
EOF

chmod +x $HOME/Desktop/D20Network/start_wallet.sh

cat << EOF > $HOME/Desktop/D20Network/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
while :
do
./d20network-cli generatetoaddress 1 \$(./d20network-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/D20Network/mine.sh
    
exec $HOME/Desktop/D20Network/d20network-qt &

sleep 15

exec $HOME/Desktop/D20Network/d20network-cli -named createwallet wallet_name="" &
    
sleep 15

cd $HOME/Desktop/D20Network/

clear

exec $HOME/Desktop/D20Network/mine.sh