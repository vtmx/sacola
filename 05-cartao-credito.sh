#!/usr/bin/env bash
# https://replit.com/@NRZCode/dvcc#main.sh

shopt -s extglob

echo ----------------------

# Card number
card_number="4220 6193 1234 567X"
#            │     │╰─────────╯
#            ├─────╯  Identifica o portador
#            │  Identifica a bandeira do cartão
#            Começam com 3, 4, 5 e 6

# Remove spaces
card_number="${card_number// }"

# Check if is digit
if ! grep -Eq 'X$' <<< $card_number; then
  echo error: card need to have X
  exit 1
fi

# Get number of digits
number_of_digits=${#card_number}

# Get flag digit
flag_digit=${card_number:0:1}

# Get owner digit
owner_digit=${card_number:6:9}

# Check digit number
if [[ $number_of_digits -eq 14 ]]; then
  card_number="0$card_number"
elif [[ $number_of_digits -lt 14 || $number_of_digits -gt 16 ]]; then
  echo "error: number of digits must be 14 or 15" 
  exit 1
fi

# Get flag name
case "$flag_digit" in
  3) flag_name="Dinners Club" ;;
  4) flag_name="Visa" ;;
  @([34|37]*)) flag_name="American Express" ;; # Rever com o grupo
  @([5|51-55]*)) flag_name="Mastercard" ;; # Rever com o grupo
  6) flag_name="Discover" ;; # Rever com o grupo
  *) flag_name="Bandeira não encontrada" ;;
esac

# Loop for odd
for ((i=0; i <= ${number_of_digits}; i++ )); do
  n=${card_number:$i:1}

  if ((i % 2 == 0 )); then
    ((n *= 2))
    ((n > 9)) && { d=${n:0:1}; u=${n:1:1}; ((n = d + u)); }
  fi

  ((sum += n))
done

((mul10 = (sum / 10 + 1) * 10, dv = mul10 - sum))

echo Card: $card_number
echo Number of digits: $number_of_digits
echo Flag digit: $flag_digit
echo Flag name: $flag_name
echo Owner digit: $owner_digit
echo Sum: $sum
echo DV: $dv
echo


# multiple_odd=$((sum_odd * 3))
# echo "$sum_odd * 3 = $multiple_odd"
# echo
#
# # Loop for odd
# for ((i=1; i <= ${number_of_digits}; i++ )); do
#   if [[ $((i % 2)) -eq 0 ]]; then
#     sum_even=$((sum_even + i))
#   fi
# done
# echo SUM_EVEN = $sum_even
#
# sum_total=$((multiple_odd + sum_even))
# echo $multiple_odd + $sum_even = $sum_total
#
# echo
#
# sum_total_digit=${#sum_total}
#
# if [[ $sum_total_digit -eq 2 ]]; then
#   echo "oioi"
# elif [[ $sum_total_digit -eq 3 ]]; then
#   dv=${sum_total:2:1}
# fi
#
# echo DV: $dv
