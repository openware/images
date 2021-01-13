# Electrum LTC server docker container

## Quick Start

```bash
WALLET_PASSPHRASE=$(pwgen -n 32 1)
ELECTRUM_USER=electrum
ELECTRUM_PASSWORD=$(pwgen -n 16 1)
docker run -it -p 7000:7000 -e WALLET_PASSPHRASE="${WALLET_PASSPHRASE}" -e ELECTRUM_USER="${ELECTRUM_USER}" -e ELECTRUM_PASSWORD="${ELECTRUM_PASSWORD}" quay.io/openware/electrum-ltc:3.3.8.1
```



## Configuration

You can configure Electrum with the following environment variables:

| Variable          | Example  | Description                                                  |
| ----------------- | -------- | ------------------------------------------------------------ |
| WALLET_PASSPHRASE |          | Passphrase used to encrypt the wallet                        |
| SEGWIT            | false    | Enable SegWit (Segregated Witness), detailed in the BIP141   |
| WALLET_SEED       |          | Provide the seed to restore the wallet on start              |
| GAP_LIMIT         | 200      | The **gap limit** is the **maximum** number of consecutive unused addresses in your deterministic sequence of addresses. **Electrum** uses it in order to stop looking for addresses. The default value is 20, so the client will load all addresses until 20 unused addresses are found. |
| TESTNET           | true     | Use testnet network instead of mainnet                       |
| ELECTRUM_USER     | electrum | Username to use to connect to RPC                            |
| ELECTRUM_PASSWORD |          | Password to use to connect to RPC                            |



## Example of RPC commands

### List all available commands

```bash
curl --data-binary '{"id":"curltext","method":"help","params":[]}' http://${ELECTRUM_USER}:${ELECTRUM_PASSWORD}@127.0.0.1:7000
```

### Get the wallet balance

```bash
curl --data-binary '{"id":"curltext","method":"getbalance","params":[]}' http://${ELECTRUM_USER}:${ELECTRUM_PASSWORD}@127.0.0.1:7000
```

### Get the wallet transactions history

```bash
curl --data-binary '{"id":"curltext","method":"history","params":[]}' http://${ELECTRUM_USER}:${ELECTRUM_PASSWORD}@127.0.0.1:7000
```

### Create a new wallet

```bash
curl --data-binary '{"id":"curltext","method":"create","params":[null,"YourSecurePassphrase",true]}' http://${ELECTRUM_USER}:${ELECTRUM_PASSWORD}@127.0.0.1:7000
```

### Create a new deposit address

```bash
curl --data-binary '{"id":"curltext","method":"createnewaddress","params":[]}' http://${ELECTRUM_USER}:${ELECTRUM_PASSWORD}@127.0.0.1:7000
```

