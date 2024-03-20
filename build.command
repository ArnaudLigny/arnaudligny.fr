#!/bin/bash
cd "$(cd "$(dirname "$0")" > /dev/null && pwd)"

php cecil.phar build -v
