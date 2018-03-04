######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib

######

all:: nats2_dats
regress:: nats2_dats; ./$<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

cleanall:: clean
cleanall:: ; rm -f nats2_dats

######

testall:: all
testall:: regress
testall:: cleanall

######

%_dats: %.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -latslib

###### end of [Makefile] ######
