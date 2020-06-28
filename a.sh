#!/bin/bash
# TODO README.md
# TODO rm extra files after finish
# TODO many record have names only
    #   Curl | extract | awk | cp | strfile
    # $1: Drugbank Email
    # $2: Drugbank Password
curl -Lfv -o database.zip -u $1:$2 https://www.drugbank.ca/releases/5-1-6/downloads/all-full-database
unzip database.zip
awk -F '[<>]' '
     /^\s{2}<name>.+<\/name>/                               {print "%\n\/\/\*\*NAME\*\*\/\/\n"               $3}
     /^\s{2}<description>.+<\/description>/                 {print "\n\/\/\*\*DESCRIPTION\*\*\/\/\n"         $3}
     /^\s{2}<indication>.+<\/indication>/                   {print "\n\/\/\*\*INDICATION\*\*\/\/\n"          $3}
     /^\s{2}<pharmacodynamics>.+<\/pharmacodynamics>/       {print "\n\/\/\*\*PHARMACODYNAMICS\*\*\/\/\n"    $3}
     /^\s{2}<mechanism-of-action>.+<\/mechanism-of-action>/ {print "\n\/\/\*\*MECHANISM OF ACTION\*\*\/\/\n" $3}
     /^\s{2}<metabolism>.+<\/metabolism>/                   {print "\n\/\/\*\*METABOLISM\*\*\/\/\n"          $3}
    ' full\ database.xml > DrugBank
mv ./DrugBank /usr/share/fortune/DrugBank
strfile /usr/share/fortune/DrugBank
