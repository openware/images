# Electrum Bitcoin server docker container

## Quick Start

```bash
WALLET_PASSPHRASE=$(pwgen -n 32 1)
ELECTRUM_USER=electrum
ELECTRUM_PASSWORD=$(pwgen -n 16 1)
docker run -it -p 7000:7000 -e WALLET_PASSPHRASE="${WALLET_PASSPHRASE}" -e ELECTRUM_USER="${ELECTRUM_USER}" -e ELECTRUM_PASSWORD="${ELECTRUM_PASSWORD}" quay.io/openware/electrum:3.3.8
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

## List of available RPC methods

| Method            | Description                                            |
| ----------------- | ------------------------------------------------------ |
| addrequest        | Create a payment request, using the first unused address of the wallet |
| addtransaction    | Add a transaction to the wallet history                |
| broadcast         | Broadcast a transaction to the network                 |
| clearrequests     | Remove all payment requests                            |
| commands          | List of commands                                       |
| convert_xkey      | Convert xtype of a master key                          |
| create            | Create a new wallet                                    |
| createmultisig    | Create multisig address                                |
| createnewaddress  | Create a new receiving address, beyond the gap limit of the wallet |
| decrypt           | Decrypt a message encrypted with a public key          |
| deserialize       | Deserialize a serialized transaction                   |
| dumpprivkeys      | Deprecated                                             |
| encrypt           | Encrypt a message with a public key                    |
| freeze            | Freeze address                                         |
| get               | Return item from wallet storage                        |
| get_tx_status     | Returns some information regarding the tx              |
| getaddressbalance | Return the balance of any address                      |
| getaddresshistory | Return the transaction history of any address          |
| getaddressunspent | Returns the UTXO list of any address                   |
| getalias          | Retrieve alias                                         |
| getbalance        | Return the balance of your wallet                      |
| getconfig         | Return a configuration variable                        |
| getfeerate        | Return current suggested fee rate (in sat/kvByte), according to config settings or supplied parameters |
| getmasterprivate  | Get master private key                                 |
| getmerkle         | Get Merkle branch of a transaction included in a block |
| getmpk            | Get master public key                                  |
| getprivatekeys    | Get private keys of addresses                          |
| getpubkeys        | Return the public keys for a wallet address            |
| getrequest        | Return a payment request                               |
| getseed           | Get seed phrase                                        |
| getservers        | Return the list of available servers                   |
| gettransaction    | Retrieve a transaction                                 |
| getunusedaddress  | Returns the first unused address of the wallet, or None if all addresses are used |
| help              | List all available methods                             |
| history           | Wallet history                                         |
| importprivkey     | Import a private key                                   |
| is_synchronized   | return wallet synchronization status                   |
| ismine            | Check if address is in wallet                          |
| listaddresses     | List wallet addresses                                  |
| listcontacts      | Show your list of contacts                             |
| listrequests      | List the payment requests you made                     |
| listunspent       | List unspent outputs                                   |
| make_seed         | Create a seed                                          |
| notify            | Watch an address                                       |
| password          | Change wallet password                                 |
| payto             | Create a transaction                                   |
| paytomany         | Create a multi-output transaction                      |
| removelocaltx     | Remove a 'local' transaction from the wallet, and its dependent transactions |
| restore           | Restore a wallet from text                             |
| rmrequest         | Remove a payment request                               |
| searchcontacts    | Search through contacts, return matching entries       |
| serialize         | Create a transaction from json inputs                  |
| setconfig         | Set a configuration variable                           |
| setlabel          | Assign a label to an item                              |
| signmessage       | Sign a message with a key                              |
| signrequest       | Sign payment request with an OpenAlias                 |
| signtransaction   | Sign a transaction                                     |
| sweep             | Sweep private keys                                     |
| unfreeze          | Unfreeze address                                       |
| validateaddress   | Check that an address is valid                         |
| verifymessage     | Verify a signature                                     |
| version           | Return the version of Electrum                         |
