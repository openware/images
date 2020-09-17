# Openware docker images

This repository contains docker images maintained by openware team. Mostly blockchain cryptonodes.
You can find the list of available images and tag here: https://quay.io/organization/openware

## Development guidelines

We are focusing our efforts to keep a high level of trust and security on those images.
Please follow the following principles when developing an image:

1. Use official images as source (ex: debian:buster, alpine, python), don't use sources from third parties
2. Install dependencies by downloading from official repositories (do not add them to the git reposity)
3.  Use recent versions.
4. The target application should be downloaded from well identified sources (ex: github official repository releases)
5. Store the checksums of the binaries you install and check them during the build in the Dockerfile
   see the following example: [electrum/Dockerfile](./electrum/Dockerfile) and [electrum/checksum.sha256](./electrum/checksum.sha256)
6. The application version must be stored in VERSION file, the content is passed as argument during the build and it's used to tag the image.
   It **must be used to download the application binaries or sources**
   You can build manually with the following command: ```docker build --build-arg VERSION=1.2.3```
7. The image should contain a README.md with instructions to do basic operations
8. Include a docker-compose.yml file with example how to deploy a testnet and mainnet node (add configuration files if necessary)
9. Create volumes for data directories (blockchain storage and wallets)
