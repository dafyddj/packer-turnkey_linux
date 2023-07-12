#subdirs = boot install guestadd update provision export
subdirs = boot install guestadd

include $(addsuffix /Makefile,$(subdirs))
