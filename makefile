compiler=pdflatex -shell-escape
file=KBDDE
#file=adv
#file=first
viewer=evince
bib=bibtex


all:compile
	
compile: *
	$(compiler) $(file).tex
	$(compiler) $(file).tex
	$(viewer) $(file).pdf
	make clean

.PHONY:edit
edit:
	vim $(file).tex

old:$(file).tex
	$(compiler) $(file).tex
	$(bib) $(file)
	$(compiler) $(file).tex
	$(compiler) $(file).tex
	$(viewer) $(file).pdf
	make clean

.PHONY:push
push:
	make clean
	git add *
	git commit -m "$(mess)"
	git push origin master
	#Usage:
	#make push mess='update sth'

.PHONY: clean
clean:
	find -maxdepth 1 -type f|grep -e .aux -e .bbl -e .bcf -e .blg -e .dvi -e .lof -e .lot -e .toc -e blx.bib -e run.xml -e .log -e .lol -e '\/\.' |xargs rm -f
