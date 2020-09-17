# EOS Docker Scripts

---

### Description
Building and configuring an EOSIO testnet requires one to take several steps in order to prepare the network to mimic that of the EOSIO mainnet. These actions consist of creating the system level accounts, building and deploying the system contracts (https://github.com/eosio/eosio.contracts : `eosio.bios`, `eosio.msig`, `eosio.system`, `eosio.token`, `eosio.wrap`), creating and issuing the EOS token, and staking enough of the token to activate the network.

### Getting Started
- Clone this repo
	- `git clone https://github.com/openware/images`
- Start docker services (will build all images)
	- `cd images/eos/scripts`
	- `docker-compose up -d --build --force-recreate && ./bootstrap.sh`
- View logs of running containers
	- `docker-compose logs -f`

### EOSIO Development KeyPairs *(DO NOT USE THESE KEYS IN PRODUCTION)*
- System Accounts: `eosio`, `eosio.token`, `eosio.msig`, `eosio.bpay`, `eosio.names`, `eosio.ram`, `eosio.ramfree`, `eosio.saving`, `eosio.stake`, `eosio.vpay`, `eosio.rex`
	- Private key: 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
	- Public key: EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
- Development Accounts: `testuser`, `producer1`, `producer2`
	- Private key: 5JUzsJi7rARZy2rT5eHhcdUKTyVPvaksnEKtNWzyiBbifJA1dUW
	- Public key: EOS6CRG7tXc9u2ySGqkH69JrwG4yXojkZBVUMLgUnKfM6uJpDUtKy

### Troubleshooting
Sometimes the testnet will get hung attempting to deploy the system contracts. If this happens, just exit out of the process (CTRL+C) and re-run the above command for building the containers and images.

