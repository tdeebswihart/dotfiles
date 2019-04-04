#!/bin/bash

test -f "$1" && which skimnotes &>/dev/null && skimnotes get -format rtf "$1"
