#!/bin/bash
# AA 110927: forked from generalPrinter 
# AA 120817: added sed to convert _ to . (prevents caption from messing up)

if [ $# -eq 0 ] ; then
	echo "captainPrinter < -p | -l > [ -n filename ] < fig1 fig2... fign >"
else

	if [ "$1" = '-l' ] ; then
		orientation='landscape'
	elif [ "$1" = '-p' ] ; then
		orientation='portrait'
	fi

	if [ "$2" = '-n' ] ; then
		figfile=$3
		shift
		shift
		shift
	else
		figfile=$(date +"%y%m%d%H%M%S")
		shift
	fi

	echo "\documentclass["$orientation"]{book}" > $figfile.tex
	echo "\usepackage{graphicx}" >> $figfile.tex
	echo "\usepackage{forloop}" >> $figfile.tex
	echo "\usepackage[margin=3.0cm,noheadfoot]{geometry}" >> $figfile.tex
	echo "\begin{document}" >> $figfile.tex

	for ARG in "$@" 
		do
		    echo $ARG
#			name=$(echo $ARG|sed 's/\_/\./g')

			echo "\begin{figure}" >> $figfile.tex
			echo "\centering" >> $figfile.tex
			if [ "$orientation" = 'landscape' ]; then
				echo "\includegraphics[width=8.0in]{"$ARG"}" >> $figfile.tex
				echo "\caption{"$(echo $ARG|sed 's/\_/\./g')"}" >> $figfile.tex
			else
				echo "\includegraphics[width=5in]{"$ARG"}" >> $figfile.tex
				echo "\caption{"$(echo $ARG|sed 's/\_/\./g')"}" >> $figfile.tex
			fi
			echo "\end{figure}" >> $figfile.tex
		done
	echo "\end{document}" >> $figfile.tex

	latex $figfile.tex
	latex $figfile.tex
	dvips -Ppdf -t $orientation -o $figfile.ps $figfile.dvi
	ps2pdf $figfile.ps $figfile.pdf

	cp $figfile.pdf ~/Desktop
	rm $figfile.aux $figfile.dvi $figfile.log $figfile.ps $figfile.tex

fi
