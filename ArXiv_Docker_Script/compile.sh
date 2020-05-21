#!bin/sh

# $1 --> Bib file name
# $2 --> Latex file name

BIBFILE="./$1"

LATEXFILE="./$2"

rm -f *.auxlock *.loa *.unq *.run.xml *.bbl *.blg *.log *.dvi *.fdb_latexmk *.aux *.fls *.lof *.bcf 

docker run --rm --volume $PWD:/workdir --workdir /workdir makisyu/texlive-2016 pdflatex $LATEXFILE

docker run --rm --volume $PWD:/workdir --workdir /workdir makisyu/texlive-2016 biber $BIBFILE

docker run --rm --volume $PWD:/workdir --workdir /workdir makisyu/texlive-2016 pdflatex $LATEXFILE

docker run --rm --volume $PWD:/workdir --workdir /workdir makisyu/texlive-2016 pdflatex $LATEXFILE