#!/bin/sh
#

#
# Configure the node.
#
setup() {
  echo "Intializing Sifchain node ..."
  sifnoded init "$MONIKER" --chain-id "$CHAIN_ID" --overwrite
  echo "done.."
  echo "Downloading Genesis from ${GENESIS_URL}"
  echo "${GENESIS_URL} > ${HOME}/.sifnoded/config/genesis.json"
  curl ${GENESIS_URL} > ${HOME}/.sifnoded/config/genesis.json
  echo "Genesis file copied to ${HOME}/.sifnoded/config/genesis.json"
}

#
# Run node
#
run() {
  echo "Startng Sifchain node"
  sifnoded start --p2p.persistent_peers "$PERSISTENT_PEERS" --p2p.seeds "$SEEDS" --rpc.laddr tcp://0.0.0.0:26657 --minimum-gas-prices "$GAS_PRICE"
}

setup
sleep 2
run
