######
#
# Cleaning Makefile
#
######

MYATSCC=$(PATSHOME)/bin/myatscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: Simple_database_dats

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

cleanall:: clean
cleanall:: ; rm -f Simple_database_dats

######

%_dats: %.dats; $(MYATSCC) $<

###### end of [Makefile] ######
