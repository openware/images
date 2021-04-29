# Parity

## Start the cryptonode

```shell
docker-compose up -Vd *mainnet or testnet*`
```

## Usage
### Check synchronization
To check if the node is currently synchronizing:
```shell
curl --data '{"method":"eth_syncing","params":[],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545
```

The response should look like the following:
```json
{
  "id": 1,
  "jsonrpc": "2.0",
  "result": {
    "startingBlock": "0x384", // 900
    "currentBlock": "0x386", // 902
    "highestBlock": "0x454" // 1108
  } // Or `false` when not syncing
}
```

To simply check the number of the most recent block, run:
```shell
curl --data '{"method":"eth_blockNumber","params":[],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545
```

The response should look like the following:
```json
{
  "id": 1,
  "jsonrpc": "2.0",
  "result": "0x4b7" // 1207
}
```
### Create a new account

To create a new account you'd only need to come up with a `passphrase` which would be later used to access account information

```shell
curl -H "Content-Type: application/json" -X POST --data '{"jsonrpc":"2.0","method":"personal_newAccount","params":["pretty_safe_passphrase"],"id":42}' localhost:8545
```

You can check if the account is present on the node and if the passphrase you've used works:
```shell
curl --data '{"method":"parity_testPassword","params":["*account address*","*account_passphrase*"],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545
```

### Account info

To get all accounts present on the node:

```shell
curl --data '{"method":"parity_allAccountsInfo","params":[],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545
```

To get account balance:
```shell
curl --data '{"method":"eth_getBalance","params":["*account_address*"],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545
```

Feel free to check [Parity JSON RPC API](https://openethereum.github.io/JSONRPC) for more calls.
