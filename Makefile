#subdirs = boot install guestadd update provision export
subdirs = boot install kernel update export

include $(addsuffix /Makefile,$(subdirs))
