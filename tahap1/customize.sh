#!/bin/bash
for f in /tmp/scripts/*.sh; do echo ">> $f"; bash "$f" || exit 1; done
