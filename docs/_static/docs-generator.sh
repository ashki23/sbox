#!/bin/bash

## Create an env for Sphinx and Pandoc
#conda create -n sphinx -c conda-forge sphinx pandoc 
source activate sphinx

## RST Docs
awk "/## Sbox/,/## Quick install/" ../../README.md | head -n -1 > sbox.md
pandoc -o ../sbox.rst -f markdown -t rst sbox.md

awk "/## Quick install/,0" ../../README.md > requirements.md
pandoc -o ../requirements.rst -f markdown -t rst requirements.md

## Man files
sed -i 's/Command line options$/COMMAND LINE OPTIONS/g' sbox.md

### sbox
awk "/## Sbox/,/## Interactive/" sbox.md | head -n -1 | tail -n +2 > sbox_1.md
echo '.TH SBOX "1" "'`date "+%B %Y"`'" "'`../../bin/sbox --version | tr [:lower:] [:upper:]`'"' > sbox.1
echo ".SH NAME
sbox \- a simple toolbox for Slurm
.SH SYNOPSIS" >> sbox.1
../../bin/sbox -h | sed "/toolbox for Slurm users/q" | head -n -2 | sed "s/usage: //g" | sed "s/[ ]\+/ /g" | tr -d '\n' >> sbox.1
echo "
.br
.SH DESCRIPTION" >>  sbox.1
pandoc -f markdown -t man sbox_1.md >> sbox.1
cat author.1 >> sbox.1
sed -i 's/.SS/.SH/g; 
s/.IP \\\[bu\] 2/.TP/g; 
s/\\f\[C\]-/.B -/g;
s/Note\\f\[R\]:/Note:/g;
s/\\f\[R\]: /\n/g;
s/\\f\[B\]//g;
s/\\f\[C\]//g;
s/\\f\[R\]//g;
/^[[:space:]]*$/d' sbox.1

mv sbox.1 ../../share/man/man1/. 

### interactive
awk "/## Interactive/,/## Quick install/" sbox.md | head -n -1 | tail -n +2 > interactive_1.md
echo '.TH SBOX "1" "'`date "+%B %Y"`'" "'`../../bin/sbox --version | tr [:lower:] [:upper:]`'"' > interactive.1
echo ".SH NAME
interactive \- an alias for using cluster interactively
.SH SYNOPSIS" >> interactive.1
../../bin/interactive jupyter -h | sed "/using cluster interactively/q" | head -n -2 | sed "s/usage: //g" | sed "s/[ ]\+/ /g" | tr -d '\n' >> interactive.1
echo "
.br
.SH DESCRIPTION" >>  interactive.1
pandoc -f markdown -t man interactive_1.md >> interactive.1
cat author.1 >> interactive.1
sed -i 's/.SS/.SH/g; 
s/.IP \\\[bu\] 2/.TP/g; 
s/\\f\[C\]-/.B -/g;
s/Note\\f\[R\]:/Note:/g;
s/\\f\[R\]: /\n/g;
s/\\f\[B\]//g;
s/\\f\[C\]//g;
s/\\f\[R\]//g
/^[[:space:]]*$/d' interactive.1

mv interactive.1 ../../share/man/man1/. 

## Remove extra md files
rm ./*.md
