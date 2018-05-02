######
#
# Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib

######

all:: test00_dats
all:: test01_dats
all:: test02_dats

######

%_dats: \
%.dats; \
$(PATSCC) \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -latslib -lm

######

cleanall:: ; $(RMF) test00

######

RMF=rm -f

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; rm -f test00_dats
cleanall:: ; rm -f test01_dats
cleanall:: ; rm -f test02_dats

####### end of [Makefile] ######
