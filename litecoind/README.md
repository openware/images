# Litecoind

## Start the cryptonode

```shell
docker-compose up -Vd *mainnet or testnet*`
```

## Usage
### Create a new account

Note: rpcuser => 'parity', rpcpassword => 'changeme', ip => '127.0.0.1',  port: 19332 [testnet], 9332 [mainnet].

```shell
curl -H "Content-Type: application/json" --data '{"method": "getnewaddress"}' rpcuser:rpcpassword@ip:port
```
Or, you can specify account and get this address assigned to new address

```shell
curl -H "Content-Type: application/json" --data '{"method": "getnewaddress", "params": ["billy"]}' rpcuser:rpcpassword@ip:port
```

Where 'billy' is your account name. You can check that your account was created properly:

```shell
curl -H "Content-Type: application/json" --data '{"method": "getaddressesbyaccount", "params": ["billy"]}' rpcuser:rpcpassword@ip:port
```

### General Blockchain info

``` shell
curl -H "Content-Type: application/json" --data '{"method": "getinfo"}' rpcuser:rpcpassword@ip:port
```

### Account info

To get account by address:

```shell
curl -H "Content-Type: application/json" --data '{"method": "getaccount", "params": ["bchtest:qpkgrpazps220qtnzvlvlcm62urtnq0edv7ufjr95n"]}' rpcuser:rpcpassword@ip:port
```

To get addresses associated with account:

```shell
curl -H "Content-Type: application/json" --data '{"method": "getaddressesbyaccount", "params": ["billy"]}' rpcuser:rpcpassword@ip:port
```

To get account balance:

```shell
curl -H "Content-Type: application/json" --data '{"method": "getbalance", "params": ["billy"]}' rpcuser:rpcpassword@ip:port
```

More:

- [Litecoin RPC API](https://www.kompulsa.com/litecoin-cli-commands/#litecoin_rpc_api)
- [Litecoind configuration docs](https://manpages.debian.org/testing/litecoind/litecoind.1)