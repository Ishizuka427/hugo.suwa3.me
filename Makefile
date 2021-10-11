HUGO_TAR_BALL := $(CURDIR)/hugo_0.85.0_Linux-64bit.tar.gz


.PHONY: hugo
hugo:
	PATH=$(CURDIR)/bin:$$PATH && hugo -D


.PHONY: vercel
vercel:
	mkdir $(CURDIR)/bin && cd $(CURDIR)/bin && tar zxvf $(HUGO_TAR_BALL)
