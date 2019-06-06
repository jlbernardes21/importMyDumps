#!/bin/bash
dirname="/data/backup/mysql/dumps/tomig/"
bdmaxval=`ls -1 $dirname | wc -l`
bdcurval=1

run-imp(){
  for i in `ls -1 $dirname`; do
     name=$(echo $i|awk -F. '{ print $1 }')
     mysql -e "drop database if exists $name"
     mysql -e "create database $name" && echo "Banco $name criado [$bdcurval de $bdmaxval]..."
     mysql $name < $dirname/$i && echo -e "Import do dump $name concluido.. \n"
     ((bdcurval+=1))
  done
}

dryrun(){
  for i in `ls -1 $dirname`; do 
     name=$(echo $i|awk -F. '{ print $1 }')
     echo "mysql -e \"drop database if exists $name\""
     echo "mysql -e \"create database $name\" && echo \"Banco $name criado [$bdcurval de $bdmaxval]...\""
     echo "mysql $name < $dirname/$i && echo -e \"Import do dump $name concluido.. \n\""
     ((bdcurval+=1))
  done 
}

case $1 in
"run-imp") run-imp && exit 0 ;;
"dryrun") dryrun && exit 0 ;;
*) echo -e "Invalid option! Try one of these: \n  $0 run-imp \n  $0 dryrun";;
esac

exit 0
#EOF
