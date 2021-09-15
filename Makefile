LEC = dataorg

FIGS=

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

all: docs/$(LEC).pdf docs/$(LEC)_notes.pdf

docs/%.pdf: %.pdf
	cp $^ $@

$(LEC).pdf: $(LEC).tex header.tex $(FIGS)
	xelatex $^

$(LEC)_notes.pdf: $(LEC)_notes.tex header.tex $(FIGS)
	xelatex $<
	pdfnup $@ --nup 1x2 --paper letterpaper --frame true --scale 0.9 --no-landscape
	mv $(LEC)_notes-nup.pdf $@

$(LEC)_notes.tex: $(LEC).tex Ruby/createVersionWithNotes.rb
	Ruby/createVersionWithNotes.rb $< $@

clean:
	rm *.aux *.log *.nav *.out *.snm *.toc *.vrb
