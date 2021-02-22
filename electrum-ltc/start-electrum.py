#!/usr/bin/env python
import os
import sys
import warnings
import aiohttp
import asyncio
from aiohttp import web, client_exceptions
from electrum_ltc.simple_config import SimpleConfig
from electrum_ltc import constants
from electrum_ltc import daemon
from electrum_ltc import logging
from electrum_ltc.logging import configure_logging
from electrum_ltc.util import create_and_start_event_loop
from electrum_ltc.network import filter_version, Network
from electrum_ltc.util import create_and_start_event_loop, log_exceptions
from electrum_ltc.wallet import create_new_wallet, restore_wallet_from_text
from electrum_ltc.logging import get_logger

def init_plugins(config, gui_name):
    from electrum_ltc.plugin import Plugins
    return Plugins(config, gui_name)

cmdline_options = {
    "testnet": os.getenv("TESTNET", "true") == "true",
    "rpcuser": os.getenv("ELECTRUM_USER", "electrum"),
    "rpcpassword": os.getenv("ELECTRUM_PASSWORD", "changeme"),
    "rpcport": 7000,
    "rpchost": "0.0.0.0",
    "cwd": os.getcwd(),
    "verbosity": 3,
    # "oneserver": True,
    "noonion": True,
}

_logger = get_logger(__name__)

if __name__ == '__main__':
    passphrase = os.getenv("WALLET_PASSPHRASE")
    segwit = os.getenv("SEGWIT") == "true"
    seed = os.getenv("WALLET_SEED")
    gap_limit = int(os.getenv("GAP_LIMIT", "20"))

    if passphrase is None:
        raise Exception("WALLET_PASSPHRASE unset")

    if cmdline_options["testnet"]:
        constants.set_testnet()

    config = SimpleConfig(cmdline_options)
    logging.configure_logging(config)
    fd, server = daemon.get_fd_or_server(config)

    if fd is not None:
        init_plugins(config, 'cmdline')
        d = daemon.Daemon(config, fd)
        path = config.get_wallet_path()
        if os.path.exists(path) is False:
            _logger.warn("Wallet doesn't exist, creating (segwit {segwit})".format(segwit=segwit))
            if seed is not None:
                restore_wallet_from_text(seed,
                                     path=path,
                                     password=passphrase,
                                     encrypt_file=True)
            else:
                create_new_wallet(path=path,
                                  password=passphrase,
                                  encrypt_file=True,
                                  segwit=segwit)
        wallet = d.load_wallet(path, passphrase)
        if wallet is None:
            raise Exception("Failed to load wallet")
        d.cmd_runner.wallet = wallet
        wallet.change_gap_limit( gap_limit )
        daemon.run_hook('load_wallet', wallet, None)
        d.server.register_function(lambda: wallet.get_local_height(), 'get_local_height')
        d.join()
        sys.exit(0)
    else:
        result = server.daemon(config)
