#!/bin/sh

url=$1
workdir=plugindl
tmp=plugins.txt

echo "Getting plugins from $url"

if [ ! -d "$workdir" ]; then
   mkdir "$workdir"
fi

wget -q $url -O "$workdir/$tmp"

pluginsFolder=/nxt/html/ui/plugins/
# if we passed a url describing the plugins to install
# we loop thru the file,
# download the plugins
# check the signatures
# install the plugins that have valid signatures
# the URL should point to a txt file with the following content
# <shasum256>  http://..../plugin.zip

while IFS=$'\t' read -r pluginChecksum pluginURL || [[ -n "$line" ]]; do
   #echo "shasum: $pluginChecksum   url: $pluginURL"
   filename=$(basename "$pluginURL")

   #echo -e "  url       : $pluginURL"
   #echo -e "  file      : $filename"
   #echo -e "  expected  : $pluginChecksum"

   wget -q "$pluginURL" -O "$workdir/$filename"

   checksum=`md5sum "$workdir/$filename" | head -c 32`
   echo -e "  checksum  : $checksum"

   if [ "$checksum" == "$pluginChecksum" ]; then
      echo -e "Checksum for $filename matched - Installing plugin"
      /nxt-boot/scripts/install-nxt-plugin.sh "$pluginsFolder" "$workdir/$filename"
   else
      echo -e "MD5 Checksum for $filename FAILED - Skipping install"
   fi;

   echo -e
done < "$workdir/$tmp"

rm -Rf "$workdir"
