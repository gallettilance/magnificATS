######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: fact
all:: factpf
all:: factprop

fact:: fact_dats
factpf:: factpf_dats
factprop:: factprop_dats

regress:: fact_dats; ./$<
regress:: factpf_dats; ./$<
regress:: factprop_dats; ./$<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

cleanall:: clean
cleanall:: ; rm -f fact_dats
cleanall:: ; rm -f factpf_dats
cleanall:: ; rm -f factprop_dats

######

testall:: all
testall:: regress
testall:: cleanall

######

%_dats: %.dats; $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<

###### end of [Makefile] ######
