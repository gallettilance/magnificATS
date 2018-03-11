######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: mul35_dats
regress:: mul35_dats; ./$<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

cleanall:: clean
cleanall:: ; rm -f mul35_dats

######

testall:: all
testall:: regress
testall:: cleanall

######

%_dats: %.dats; $(PATSCC) -o $@ $<

###### end of [Makefile] ######
