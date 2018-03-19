FROM ubuntu
RUN  apt-get -y update \
  && apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:ethereum/ethereum \
  && apt-get -y update \
  && apt-get install -y ethereum wget git vim

EXPOSE 8545 8546 30303 30303/udp 30304/udp
VOLUME /root/.rinkeby

RUN  wget https://www.rinkeby.io/rinkeby.json -O $HOME/rinkeby.json \
  && geth --datadir=$HOME/.rinkeby init $HOME/rinkeby.json

# To run a rinkeby full node:
CMD geth --datadir=$HOME/.rinkeby --cache=64 --rinkeby --networkid=4 \
  --rpc --rpcaddr "0.0.0.0" --rpcapi="personal,eth,network,web3" \
  --rpccorsdomain "http://localhost:3000,http://localhost:3001,http://localhost:3002,http://localhost,http://test.thistoken.rocks,https://thistoken.rocks" 

