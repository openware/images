# Bitcoind

## Start the cryptonode

```shell
docker-compose up -Vd *mainnet or testnet*`
```
## Usage
### Create a new account

```shell
curl -H "Content-Type: application/json" --data '{"method": "getnewaddress"}' rpcuser:rpcpassword@ip:port
```
Or, you can specify account and get this address assigned to new address

```shell
curl -H "Content-Type: application/json" --data '{"method": "getnewaddress", "params": ["billy"]}' rpcuser:rpcpassword@ip:port
```

Where 'billy' is your account name. You can check that address for account was created properly:

```shell
curl -H "Content-Type: application/json" --data '{"method": "validateaddress", "params": ["bitcoincash:qrf8qjayhg0cakja6e34hpwy6lyeuf2q9g3zpjy7ez"]}' rpcuser:rpcpassword@ip:port
```

### General Blockchain info
``` shell
curl -H "Content-Type: application/json" --data '{"method": "getblockchaininfo"}' rpcuser:rpcpassword@ip:port
```

More:
[BitcoinCash RPC API](https://www.bitcoincash.org/spec/JSON-RPC.html)
