MAIN ?= article
LATEX = tectonic

.PHONY: all article example clean

all: article example

article:
	$(LATEX) article.tex

example:
	$(LATEX) example.tex

clean:
	rm -f *.aux *.log *.out *.toc *.bbl *.blg *.bcf *.run.xml *.xdv article.pdf
