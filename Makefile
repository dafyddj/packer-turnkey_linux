#subdirs = boot install guestadd update provision export
subdirs = boot install kernel

include $(addsuffix /Makefile,$(subdirs))
