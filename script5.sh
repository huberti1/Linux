#! /bin/bash

#Przyjecie argumentow
echo "Podaj sciezke:"
read src

echo "Podaj sposob sortowania (oldest/newest):"
read dat

percent=1
count=$(find $src | wc -l)

#Jesli liczba elementow w katalogu to 10 lub wiecej to oblicz 10% z liczby elementow
if [ "$count" -ge "10" ]
then
  percent=$(( count*10/100 ))
fi

#Jesli uzytkownik nie podal zadnych argumentow to wyswietl napis o bledzie
if [ -z "$src" ] && [ -z "$dat" ]
then
  echo "Blad - brak argumentow"

#Jesli uzytkownik podal sposob sortowania to wyswietl elementy wedlug wybranego sortowania
elif [ ! -z "$dat" ]
then
  if [ $dat == 'newest' ]
  then
    find $src | sort | tail -n $percent

  elif [ $dat == 'oldest' ]
  then
    find $src | sort | head -n $percent
  fi

#Jesli uzytkownik nie podal sposobu sortowania to wyswietl elementy od najnowszego
elif [ -z "$dat" ] && [ ! -z "$src" ]
then
  find $src | sort | tail -n $percent

#Jesli uzytkownik nie podal poprawnie sposobu sortowania to wyswietl komunikat o bledzie
else
  echo "Blad - zle podany argument"
fi