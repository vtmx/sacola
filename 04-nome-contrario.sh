#!/usr/bin/env bash

read str; for ((i=${#str}; i>=0; i--)); do echo -n "${str:i:1}"; done 
