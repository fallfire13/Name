#!/bin/bash
# broken-link.sh
# Автор Lee Bigelow <ligelowbee@yahoo.com>
# Используется с его разрешения.

#Сценарий поиска "битых" ссылок и их вывод в "окавыченном" виде
#таким образом они могут передаваться утилите xargs для дальнейшей обработки :)
#например. broken-link.sh /somedir /someotherdir|xargs rm
#
#На всякий случай приведу лучший метод:
#
#find "somedir" -type l -print0|\
#xargs -r0 file|\
#grep "broken symbolic"|
#sed -e 's/^\|: *broken symbolic.*$/"/g'
#
#но это не чисто BASH-евский метод, а теперь сам сценарий.
#Внимание! будьте осторожны с файловой системой /proc и циклическими ссылками!
##############################################################


#Если скрипт не получает входных аргументов,
#то каталогом поиска является текущая директория
#В противном случае, каталог поиска задается из командной строки
####################
[ $# -eq 0 ] && directorys=`pwd` || directorys=$@

#Функция linkchk проверяет каталог поиска
#на наличие в нем ссылок на несуществующие файлы, и выводит их имена.
#Если анализируемый файл является каталогом,
#то он передается функции linkcheck рекурсивно.
##########
linkchk () {
    for element in $1/*; do
    [ -h "$element" -a ! -e "$element" ] && echo \"$element\"
    [ -d "$element" ] && linkchk $element
    # Само собой, '-h' проверяет символические ссылки, '-d' -- каталоги.
    done
}

#Вызов функции linkchk для каждого аргумента командной строки,
#если он является каталогом.  Иначе выводится сообщение об ошибке
#и информация о порядке пользования скриптом.
################
for directory in $directorys; do
    if [ -d $directory ]
        then linkchk $directory
        else
            echo "$directory не является каталогом"
            echo "Порядок использования: $0 dir1 dir2 ..."
    fi
done

exit 0
