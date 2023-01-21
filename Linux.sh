!#/bin/bash
# Sprawdź czy są argumenty
if [ $# = 0 ]
then
    # Brak argumentów
    echo "Error: No arguments"
    exit
fi
foundVar=false
# Sprawdź czy jest jeden z używanych argumentów
for i in $@
do
    currArgName=${i%:*}
    if [ $currArgName = "dat" ] || [ $currArgName = "src" ]
    then
        foundVar=true
    fi
done
fi [ $foundVar = false ]
then
    # Brak używanych argumentów
    echo "Error: Incorrect parameters. You must include at least a dat: or src: parameter."
    exit
fi
argOneName=$(echo $1 | cut -d: -f 1)
argOneVal=$(echo $1 | cut -d: -f 2)
dat="NULL"
src="NULL"
# Ustawianie src albo dat w zależności od zawartości argumentu jeden
if [ $argOneName ]
then
    dat=$argOneVal
elif [ $argOneName = "src" ]
then
    src=$argOneVal
fi
if [ $# -gt 1 ]
then
    # Ustawianie dat albo src w zależności od zawartości argumentu dwa
    argTwoName=$(echo $2 | cut -d: -f 1)
    argTwoVal=$(echo $2 | cut -d: -f 2)
    if [ $argOneName = "src" ] && [ $argTwoName = "dat" ]
        dat=argTwoVal
    then
    elif [ $argOneName = "dat" ] && [ $argTwoName = "src" ]
        src=argTwoVal
    then
    fi
fi
# Jeśli nie ustawiony dat, przyjmij sort od najnowszego
if [ $dat = "NULL" ] || ! ([ $dat = "oldest" || $dat = "newest" ])
then
    dat="newest"
fi
# Jeśli nie ustawiony src, przyjmij katalog skryptu
if [ $src = "NULL" ]
then
    currDir=$(dirname -- $0) # ścieżka do skryptu
    src=$(cd -- $currDir && pwd) # ścieżka absolutna skryptu
fi
elemCount=$(ls $src | wc -w) # ilość elementów
elemTenPerc=$(($elemCount/10)) # ilość elementów / 10
if [ $elemTenPerc = 0 ]
then
    # Jeśli mniej niż 10 elementów, wyświetl jeden
    elemTenPerc=1
fi
if [ $dat = "newest" ]
then
    # Wyświetl od najnowszych
    ls $src -t --full-time | tail -n +2 | head $elemTenPerc
else
    # Wyświetl od najstarszych
    ls $src -tr --full-time | tail -n +2 | head $elemTenPerc
fi
exit
