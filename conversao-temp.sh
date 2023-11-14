#!/usr/bin/env bash

echo_err() {
  echo erro: digite uma unidade válida [dhms]
}

min2() {
  local v=${1%%[dhs]} u=${1##*[!dhs]}
  local s=0 h=0 d=0

  case $u in
    d|'') # Converte minutos para dias
      d=$(( v / 60 / 24 ))d
      h=$(( v / 60 ))h
      s=$(( v * 60 ))s
      ;;
    h) # Converte minutos para horas
      h=$(( v / 60 ))h
      s=$(( v * 60 ))s
      ;;
    s) # Converte minutos para segundos
      s=$(( v * 60 ))s
      ;;
    *) echo_err ;;
  esac

  echo $d $h $s
}

hour2() {
  local v=${1%%[dms]} u=${1##*[!dms]}
  local s=0 m=0 d=0

  case $u in
    d|'') # Converte horas para dias
      d=$(( v / 24 ))d
      m=$(( v * 60 ))m
      s=$(( v * 60 * 60 ))s
      ;;
    m) # Converte horas para minutos
      m=$(( v * 60 ))m
      s=$(( v * 60 * 60 ))s
      ;;
    s) # Converte horas para segundos
      s=$(( v * 60 * 60 ))s
      ;;
    *) echo_err ;;
  esac

  echo $d $m $s
}

day2() {
  local v=${1%%[hms]} u=${1##*[!hms]}
  local s=0 m=0 h=0

  case $u in
    h|'') # Converte dias para horas
      h=$(( v * 24 ))h
      m=$(( v * 60 * 24 ))m
      s=$(( v * 60 * 60 * 24 ))s
      ;;
    m) # Converte dias para minutos
      m=$(( v * 60 * 24 ))m
      s=$(( v * 60 * 60 * 24 ))s
      ;;
    s) # Converte dias para segundos
      s=$(( v * 60 * 60 * 24 ))s
      ;;
    *) echo_err ;;
  esac

  echo $h $m $s
}

upt() {
  # Coleta somente os segundos do arquivo uptime
  local v=$(grep -Eo '^[[:digit:]]*\b' /proc/uptime)

  # Semanas
  local se=$(( v / 86400 * 7))

  if [[ $se -le 0 ]]; then
    se=''
  elif [[ $se -eq 1 ]]; then
    se="$se semana"
  else
    se="$se semanas"
  fi

  # Dias

  local d=$(( v / 86400 ))

  if [[ $d -le 0 ]]; then
    d=''
  elif [[ $d -eq 1 ]]; then
    d="$d dia"
  else
    d="$d dias"
  fi

  # Horas
  local h=$(( v / 3600 % 24 ))

  if [[ $h -le 0 ]]; then
    h=''
  elif [[ $h -eq 1 ]]; then
    h="$h hora"
  else
    h="$h horas"
  fi

  # Minutos
  local m=$(( v / 60 % 60 ))

  if [[ $m -le 0 ]]; then
    m=''
  elif [[ $m -eq 1 ]]; then
    m="$m minuto"
  else
    m="$m minutos"
  fi

  # Segundos
  local s=$(( v % 60 ))

  if [[ $s -le 0 ]]; then
    s=''
  elif [[ $s -eq 1 ]]; then
    s="$s segundo"
  else
    s="$s segundos"
  fi

  echo $d $h $m $s
}

day2 1h
hour2 1m
min2 1s
upt
