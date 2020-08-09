#!/usr/bin/env python
import asyncio
import os
import sys
import warnings

from electroncash import (networks, daemon)
from electroncash.simple_config import SimpleConfig
from electroncash.storage import WalletStorage
from electroncash.util import (InvalidPassword, json_decode, json_encode,
                               print_msg, print_stderr, set_verbosity)
from electroncash.wallet import create_new_wallet, restore_wallet_from_text


def init_plugins(config, gui_name):
    from electroncash.plugins import Plugins
    return Plugins(config, gui_name)


config_options = {
    'testnet': os.getenv("TESTNET", "true") == "true",
    "rpcuser": os.getenv("ELECTRUM_USER", "electrum"),
    "rpcpassword": os.getenv("ELECTRUM_PASSWORD", "changeme"),
    "rpcport": 7000,
    "rpchost": "0.0.0.0",
    'cwd': os.getcwd(),
    'auto_connect': True,
    'verbose': os.getenv("VERBOSE", "false") == "true",
    'wallet_password': os.getenv("WALLET_PASSPHRASE"),
    "noonion": True,
}

if __name__ == '__main__':
    set_verbosity(config_options.get('verbose'))
    if config_options.get('testnet'):
        networks.set_testnet()

    config = SimpleConfig(config_options)
    storage = WalletStorage(config.get_wallet_path())
    seed = os.getenv("WALLET_SEED")
    gap_limit = int(os.getenv("GAP_LIMIT", "20"))

    if not storage.file_exists():
        print_msg("Wallet doesn't exist, creating...")
        if seed is not None:
            restore_wallet_from_text(seed,
                                 path=storage.path,
                                 config=config,
                                 password=config_options['wallet_password'],
                                 encrypt_file=True)
        else:
            data = create_new_wallet(path=storage.path,
                                     config=config,
                                     password=config_options['wallet_password'],
                                     encrypt_file=True)
        storage = WalletStorage(storage.path)

    if storage.is_encrypted() is False:
        print_msg("Error: Wallet is unencrypted")
        sys.exit(1)

    fd, server = daemon.get_fd_or_server(config)
    if fd is not None:
        plugins = init_plugins(config, 'cmdline')
        d = daemon.Daemon(config, fd, False, plugins)

        d.server.register_function(lambda: wallet.get_local_height(), 'get_local_height')

        wallet = d.load_wallet(path=storage.path,
                               password=config_options['wallet_password'])

        if wallet is None:
            raise Exception("Failed to load wallet")

        d.cmd_runner.wallet = wallet

        wallet.change_gap_limit( gap_limit )

        if config.get('websocket_server'):
            from electroncash import websockets
            websockets.WebSocketServer(config, d.network).start()

        d.start()
        d.join()
        sys.exit(0)
    else:
        result = server.daemon(config)
