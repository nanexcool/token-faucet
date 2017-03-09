export SOLC_FLAGS=--optimize

all:; dapp build
test:; dapp test
deploy: all; seth send --create 0x"`cat out/Faucet.bin`" -G 3000000
