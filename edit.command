#!/bin/bash
cd "$(cd "$(dirname "$0")" > /dev/null && pwd)"

open -a typora ./pages
export CECIL_SERVICEWORKER_ENABLED=false
php cecil.phar serve -v -o
