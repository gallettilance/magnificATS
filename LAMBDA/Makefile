######
#
# Cleaning Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

MAKE=make

######

compile:: \
fibo
fibo:: ; \
$(MAKE) -C Examples -f Makefile fibo

compile:: \
fact
fact:: ; \
$(MAKE) -C Examples -f Makefile fact

compile:: \
isprime
isprime:: ; \
$(MAKE) -C Examples -f Makefile isprime

compile:: \
numprime
numprime:: ; \
$(MAKE) -C Examples -f Makefile numprime

compile:: \
queens
queens:: ; \
$(MAKE) -C Examples -f Makefile queens

compile:: clean

######

all:: compile
all:: test_dats

regress_basic:: test_dats; ./$<

regress_fibo:: fibo
regress_fibo:: test_dats; ./$< Examples/fibo.txt

regress_fact:: fact
regress_fact:: test_dats; ./$< Examples/fact.txt

regress_isprime:: isprime
regress_isprime:: test_dats; ./$< Examples/isprime.txt

regress_numprime:: numprime
regress_numprime:: test_dats; ./$< Examples/numprime.txt

regress_queens:: queens
regress_queens:: test_dats; ./$< Examples/queens.txt

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c
clean:: ; rm -f test_dats
clean:: \
cleanex
cleanex:: ; \
$(MAKE) -C Examples -f Makefile clean


cleanall:: \
cleanallex
cleanallex:: ; \
$(MAKE) -C Examples -f Makefile cleanall

cleanall:: clean

######

%_dats: %.dats; $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<

###### end of [Makefile] ######
