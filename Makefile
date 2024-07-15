outdir=./public
srcdir=./content

.PHONY: all clean

all: $(outdir)/favicon.ico $(outdir)/css $(outdir)/images $(outdir)/js $(outdir)/index.html $(outdir)/Publications.bib

$(outdir)/favicon.ico: $(srcdir)/favicon.ico
	cp $< $@

$(outdir)/css: $(srcdir)/css $(srcdir)/css/*
	cp -r $< $(outdir)

$(outdir)/images: $(srcdir)/images $(srcdir)/images/*
	cp -r $< $(outdir)

$(outdir)/js: $(srcdir)/js $(srcdir)/js/*
	cp -r $< $(outdir)

$(outdir)/Publications.bib: $(srcdir)/Publications.bib
	cp $< $@

$(outdir)/index.html: $(srcdir)/*.org $(srcdir)/theme.setup ./build-site.el
	emacs -Q --script build-site.el

clean:
	rm -rf $(outdir)/*

