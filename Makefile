outdir=./public
srcdir=./content

.PHONY: all build-site clean

all: build-site

build-site: ./build-site.el
	@echo "=========================Building Site========================="
	emacs -Q --script build-site.el
	@echo "=============================Done=============================="

publish: $(outdir)/index.html
	@echo "====================Copying files to remote===================="
	rsync -rv public ae:~/
	@echo "=================Changing permissions in remote================"
	ssh ae 'chmod -R 755 ~/public'
	@echo "=============================Done=============================="

clean:
	@echo "============================Cleaning============================"
	@rm -rvf $(outdir)/*

