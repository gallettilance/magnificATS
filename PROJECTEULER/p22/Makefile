######
#
# Cleaning Makefile
#
######

NPM=npm

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib

######

all:: names_dats
regress:: names_dats; ./$<
cleanall:: ; rm -f names_dats

######

testall:: npm-install
testall:: all regress cleanall

######

%_dats: \
%.dats; \
$(PATSCC) -O2 \
-I./node_modules \
-DATS_MEMALLOC_GCBDW -o $@ $< -latslib -lgmp -lgc

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

cleanall:: clean
cleanall:: ; rm -f node_modules -r
cleanall:: ; rm -f package-lock.json

######

npm-update:: ; $(NPM) update
npm-install:: ; $(NPM) install

###### end of [Makefile] ######
