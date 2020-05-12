# Electrum-DASH container

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
