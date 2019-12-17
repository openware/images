# Monero

## Start the cryptonode

```shell
docker-compose up -Vd stagenet-monerod stagenet-wallet
```

## Daemon API Usage
### Get general blockchain info

```shell
curl -X POST -H "Content-Type: application/json" --data '{"method": "get_info"}' -u rpcuser:rpcpassword --digest ip:monerod_port/json_rpc
```
### Get blockchain synchronization status

```shell
curl -X POST -H "Content-Type: application/json" --data '{"method": "sync_info"}' -u rpcuser:rpcpassword --digest ip:monerod_port/json_rpc
```

### Get block count

```shell
curl -X POST -H "Content-Type: application/json" --data '{"method": "get_block_count"}' -u rpcuser:rpcpassword --digest ip:monerod_port/json_rpc
```

More:

[Daemon RPC API](https://web.getmonero.org/resources/developer-guides/daemon-rpc.html)

### Wallet API Usage

1. Create wallet:
```shell
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":"1","method":"create_wallet","params":{"filename":"mytestwallet2","password":"mytestpassword","language":"English"}}' -u rpcuser:rpcpassword --digest ip:wallet_port/json_rpc
```
2. Open wallet:

```shell
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":"1","method":"open_wallet","params":{"filename":"mytestwallet2","password":"mytestpassword","language":"English"}}' -u rpcuser:rpcpassword --digest ip:wallet_port/json_rpc
```

3. Create account:

```shell
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":"0","method":"create_account","params":{"label":"Secondary account"}}' -u rpcuser:rpcpassword --digest ip:wallet_port/json_rpc
```
3. Generate account's address:

```shell
curl -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","id":"0","method":"create_address","params":{"account_index":0,"label":"new-sub"}}' -u rpcuser:rpcpassword --digest ip:wallet_port/json_rpc
```

More:

[Wallet RPC API](https://web.getmonero.org/resources/developer-guides/wallet-rpc.html)
