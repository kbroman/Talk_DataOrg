LEC = dataorg

FIGS=Figs/spreadsheet_ugly.pdf \
	 Figs/data_dict.pdf \
	 Figs/spreadsheet_colnames1.pdf \
	 Figs/dates.pdf \
	 Figs/no_highlighting.pdf \
	 Figs/skipping_cells.pdf \
	 Figs/consistent_cats.pdf \
	 Figs/rectangle.pdf

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

all: docs/$(LEC).pdf docs/$(LEC)_notes.pdf

docs/%.pdf: %.pdf
	cp $< $@

Figs/%.pdf: R/%.R
	cd $(<D);R CMD BATCH $(R_OPTS) $(<F)

Figs/spreadsheet_ugly.pdf: R/make_spreadsheet_figs.R R/example_ugly.csv R/example_tidy.csv
	cd $(<D);R CMD BATCH $(R_OPTS) $(<F)

Figs/spreadsheet_colnames1.pdf: R/consistent_columns.R
	cd $(<D);R CMD BATCH $(R_OPTS) $(<F)

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
