outdir=./public
srcdir=./content

.PHONY: all build-site clean

all: build-site

build-site: ./build-site.el
	@echo "Building Site..."
	emacs -Q --script build-site.el

clean:
	@echo "Cleaning..."
	@rm -rvf $(outdir)/*

