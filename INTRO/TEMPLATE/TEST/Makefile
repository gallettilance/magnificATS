######
#
# Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: test00_dats

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

cleanall:: clean
cleanall:: ; rm -f test00_dats

######

%_dats: %.dats; $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<

####### end of [Makefile] ######
