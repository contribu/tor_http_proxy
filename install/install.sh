#!/bin/bash

set -ex

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mv -f $script_dir/uncachable /etc/polipo/
mv -f $script_dir/* /root/
mkdir -p /root/tmp
chmod +x /root/boot.sh
