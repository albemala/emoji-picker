#!/usr/bin/env bash

cd .. || exit

dart format -l 120 --fix lib/
