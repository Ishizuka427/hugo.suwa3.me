HUGO_TAR_BALL := $(CURDIR)/hugo_0.76.3_Linux-64bit.tar.gz


.PHONY: hugo
hugo:
	PATH=$(CURDIR)/bin:$$PATH && cd hugo && hugo -D


.PHONY: netlify
netlify:
	mkdir $(CURDIR)/bin && cd $(CURDIR)/bin && tar zxvf $(HUGO_TAR_BALL)
