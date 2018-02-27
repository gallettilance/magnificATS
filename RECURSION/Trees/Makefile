######
#
# Cleaning Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

dfs:: dfs_dats
bfs:: bfs_dats
checkbst:: checkbst_dats

######

clean:: ; rm -f *~
clean:: ; rm -f *_dats.o
clean:: ; rm -f *_dats.c

cleanall:: clean
cleanall:: ; rm -f tree_dats
cleanall:: ; rm -f bfs_dats
cleanall:: ; rm -f dfs_dats
cleanall:: ; rm -f checkbst_dats

######

%_dats: %.dats; $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<

###### end of [Makefile] ######
