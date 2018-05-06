######
#
# Cleaning Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: queens_dats
all:: prime_dats
all:: fibo_dats

queens:: queens_dats; ./$<
isprime:: prime_dats; ./$<
numprime:: prime_dats; ./$<
fibo:: fibo_dats; ./$<
fact:: fact_dats; ./$<

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

clean:: ; rm -f queens_dats
clean:: ; rm -f prime_dats
clean:: ; rm -f fact_dats
clean:: ; rm -f fibo_dats

cleanall:: clean
cleanall:: ; rm -f queens.txt
cleanall:: ; rm -f numprime.txt
cleanall:: ; rm -f isprime.txt
cleanall:: ; rm -f fibo.txt
cleanall:: ; rm -f fact.txt
cleanall:: ; rm -f output.txt

######

%_dats: %.dats; $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<

###### end of [Makefile] ######
