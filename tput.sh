#!/usr/bin/env bash

tput clear

# Hidden cursor
tput civis

chars=(▄)
maxchars=30
lines=$(tput lines)
cols=$(tput cols)

blink() {
  while true; do
    for ((i=0; i<=$maxchars; i++)); do
      tput cup $((RANDOM % lines)) $((RANDOM % cols)) # Go to random position
      tput setaf $((RANDOM % 6 + 1))                  # Set random color
      echo ${chars[(( RANDOM % ${#chars[@]} ))]}      # Print random number of string
    done
    sleep 0.5
    tput clear
  done
}

fill() {
  while true; do
    for ((i=0; i<=$maxchars; i++)); do
      tput cup $((RANDOM % lines)) $((RANDOM % cols)) # Go to random position
      tput setaf $((RANDOM % 6 + 1))                  # Set random color
      echo ${chars[(( RANDOM % ${#chars[@]} ))]}      # Print random number of string
    done
    sleep 0.5
  done
}

snake() {
  while true; do
    for ((l=0; l<=$lines; l++)) do
      for ((c=0; c<=$cols; c++)); do
        for ((i=0; i<=$maxchars; i++)); do
          tput cup $l $c                             # Go to random position
          tput setaf $((RANDOM % 6 + 1))             # Set random color
          echo ${chars[(( RANDOM % ${#chars[@]} ))]} # Print random number of string
          echo TIGER AND DRAGON 
        done
        sleep 0.5
      done
    done
  done
}

linesdow() {
  while true; do
    for ((l=0; l<=$lines; l++)) do
        for ((i=0; i<=$maxchars; i++)); do
          tput cup $l $((RANDOM % cols))                             # Go to random position
          tput setaf $((RANDOM % 6 + 1))             # Set random color
          echo ${chars[(( RANDOM % ${#chars[@]} ))]} # Print random number of string
        done
        sleep 0.5
    done
  done
}

colsright() {
  while true; do
    for ((c=0; c<=$lines; c++)) do
        for ((i=0; i<=$maxchars; i++)); do
          tput cup $((RANDOM % lines)) $c            # Go to random position
          tput setaf $((RANDOM % 6 + 1))             # Set random color
          echo ${chars[(( RANDOM % ${#chars[@]} ))]} # Print random number of string
        done
        sleep 0.5
    done
  done
}

# fill
# blink
# snake
# linesdow
# colsright
