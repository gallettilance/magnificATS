######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: fibo
all:: fibopf
all:: fiboprop

fibo:: fibo_dats
fibopf:: fibopf_dats
fiboprop:: fiboprop_dats

regress:: fibo_dats; ./$<
regress:: fibopf_dats; ./$<
regress:: fiboprop_dats; ./$<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

cleanall:: clean
cleanall:: ; rm -f fibo_dats
cleanall:: ; rm -f fibopf_dats
cleanall:: ; rm -f fiboprop_dats

######

testall:: all
testall:: regress
testall:: cleanall

######

%_dats: %.dats; $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<

###### end of [Makefile] ######
