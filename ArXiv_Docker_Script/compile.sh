#!bin/sh

# $1 --> Bib file name
# $2 --> Latex file name

BIBFILE='./$1'

LATEXFILE='./$2'


docker run --rm --volume $PWD:/workdir --workdir /workdir makisyu/texlive-2016 latexmk $LATEXFILE

docker run --rm --volume $PWD:/workdir --workdir /workdir makisyu/texlive-2016 biber $BIBFILE

docker run --rm --volume $PWD:/workdir --workdir /workdir makisyu/texlive-2016 latexmk $LATEXFILE

docker run --rm --volume $PWD:/workdir --workdir /workdir makisyu/texlive-2016 latexmk $LATEXFILE