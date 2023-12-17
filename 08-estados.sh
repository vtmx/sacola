#!/usr/bin/env bash

# str=$(lynx -dump https://weather.codes/brazil)

str='Country
Brazil
Region
Rio de Janeiro
City
Rio de Janeiro'

let count=3
th=$(head -n$count <<< $str)
td=$(tail -n$count <<< $str)

line="$(paste <(echo "$th") <(echo "$td") -d '-')"
sed 's/-/\t-\t/' <<< $line
