export SOLC_FLAGS=--optimize

all:; dapp build
test:; dapp test
deploy:; dapp create Faucet -G 3000000 -F `seth coinbase`
token: all; dapp create DSTokenBase 1000 -G 3000000 -F `seth coinbase`
