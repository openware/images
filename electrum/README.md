# Electrum server container

Here are some examples of useful commands:

## List all available commands
```bash
curl --data-binary '{"id":"curltext","method":"help","params":[]}' http://electrum:changeme@127.0.0.1:7000
```

## Get the wallet balance
```bash
curl --data-binary '{"id":"curltext","method":"getbalance","params":[]}' http://electrum:changeme@127.0.0.1:7000
```

## Create a new wallet
```bash
curl --data-binary '{"id":"curltext","method":"create","params":[null,"YourSecurePassphrase",true]}' http://electrum:changeme@127.0.0.1:7000
```

## Create a new deposit address
```bash
curl --data-binary '{"id":"curltext","method":"createnewaddress","params":[]}' http://electrum:changeme@127.0.0.1:7000
```

Here are the environment config

## WALLET_PASSPHRASE

Passphrase of the wallet, this will encrypt the wallet

## SEGWIT

Enable segwit. Provide boolean.

## WALLET_SEED

This can be used to restore wallet

## GAP_LIMIT

Increase the Gap limit of your receiving wallets, by default only 20 wallets will be loaded this is bad if you have 100s of receiving wallets.

## TESTNET

Enable testnet?, provide boolean

## ELECTRUM_USER

Username for RPC

## ELECTRUM_PASSWORD

Password for RPC
