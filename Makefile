SUBDIRS = examples supermon msbasic btploader

.PHONY: all subdirs $(SUBDIRS) clean

all: bin subdirs

bin:
	mkdir bin

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	@for dir in $(SUBDIRS); do $(MAKE) -C "$$dir" $@; done
	rm -rf bin *~
