######
#
# Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

#######

MYLIBIES :=
MYLIBIES += ./../mylibies.sats
MYLIBIES += ./../mylibies.dats

######
#
all:: \
test00
regress:: \
test00; $(CAT) test00.dats | ./$<
test00: \
test00.dats ; $(PATSCC) -O2 -o $@ $<
#
cleanall:: ; $(RMF) test00
#
######
#
all:: \
test01
regress:: \
test01; $(CAT) test01.dats | ./$<
test01: \
test01.dats ; \
$(PATSCC) -O2 \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES) -lm
#
cleanall:: ; $(RMF) test01
#
######

CAT=cat
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

####### end of [Makefile] ######
