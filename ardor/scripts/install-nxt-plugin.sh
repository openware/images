#!/bin/sh

# usage
# ./install-nxt-plugin.sh plugin1.zip plugin2.zip ...

target=/nxt/html/ui/plugins/

for plugin in "$@"
do
	echo -e "Installing $plugin into $target"
	unzip -o "$plugin"  -x "__MACOSX*" -d "$target"
done
