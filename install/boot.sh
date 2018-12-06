#!/bin/bash -l

set -ex

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ruby $script_dir/boot.rb

