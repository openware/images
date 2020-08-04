# Rippled

## Start the cryptonode

```shell
docker-compose up -Vd *mainnet or testnet*`
```

## Usage
### Check synchronization
To check if the node is currently synchronizing, :
To check if the node is currently synchronizing, :
To check if the node is currently synchronizing, you can fetch information about open-ledger requirements for the transaction cost:
```shell
curl -H "Content-Type: application/json" --data '{"method": "fee"}' localhost:51234/
```

The response should look like the following:
```json
{
    "result": {
        "current_ledger_size": "56",
        "current_queue_size": "11",
        "drops": {
            "base_fee": "10",
            "median_fee": "10000",
            "minimum_fee": "10",
            "open_ledger_fee": "2653937"
        },
        "expected_ledger_size": "55",
        "ledger_current_index": 26575101,
        "levels": {
            "median_level": "256000",
            "minimum_level": "256",
            "open_ledger_level": "67940792",
            "reference_level": "256"
        },
        "max_queue_size": "1100",
        "status": "success"
    }
}
```

Otherwise you need to wait up to 15 mins for node synchronization. In that case response will look like the following:
```json
{
  "result": {
    "error": "noNetwork",
    "error_code":17,
    "error_message":"Not synced to Ripple network.",
    "request": {
      "command":"fee"
    },
    "status":"error"
  }
}

```

### Create a new wallet

To generate a key pair and XRP Ledger you will use *wallet_propose* method. This command only generates key and address values, and does not affect the XRP Ledger itself in any way. To become a funded address stored in the ledger, the address must receive a Payment transaction that provides enough XRP to meet the reserve requirement.

Passphrase param is optional.
```shell
curl -H "Content-Type: application/json" --data '{"method": "wallet_propose", "params": [{"passphrase": "changeme"}]}' localhost:51234/
```

You can check if the account is present on the node and check basic information (activity, and its XRP balance):
```shell
curl -H "Content-Type: application/json" --data '{"method": "account_info", "params": [{"account": "rG1QQv2nh2gr7RCZ1P8YYcBUKCCN633jCn"}]}' localhost:51234/
```

Feel free to check [RIPPLE JSON RPC API](https://xrpl.org/rippled-api.html) for more calls.
