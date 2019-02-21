#!/bin/bash

a=4
b=5

#  Здесь переменные "a" и "b" могут быть как целыми числами, так и строками.
#  Здесь наблюдается некоторое размывание границ
#+ между целочисленными и строковыми переменными,
#+ поскольку переменные в Bash не имеют типов.

#  Bash выполняет целочисленные операции над теми переменными,
#+ которые содержат только цифры
#  Будьте внимательны!

echo

if [ "$a" -ne "$b" ]
then
  echo "$a не равно $b"
  echo "(целочисленное сравнение)"
fi

echo

if [ "$a" != "$b" ]
then
  echo "$a не равно $b."
  echo "(сравнение строк)"
  #     "4"  != "5"
  # ASCII 52 != ASCII 53
fi

# Оба варианта, "-ne" и "!=", работают правильно.

echo

exit 0
