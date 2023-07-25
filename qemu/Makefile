sp := $(subst ,, )
_walk = $(if $1,$(wildcard /$(subst $(sp),/,$1)/$2) $(call _walk,$(wordlist 2,$(words $1),x $1),$2))
_find = $(firstword $(call _walk,$(strip $(subst /, ,$1)),$2))
_ROOT ?= $(patsubst %/root.mk,%,$(call _find,$(CURDIR),root.mk))
_ROOT := $(_ROOT)

include $(_ROOT)/root.mk
include $(_ROOT)/pre.mk

srcs := main.cat.pkr.hcl
artifact_ext = $(boxext)

$(_module_name)_output := $(_ROOT)/box/qemu

include $(_ROOT)/post.mk

stages := $(shell cat $(_ROOT)/stages)
stages := $(filter-out install, $(stages))
stages := $(addprefix $(_ROOT)/, $(addsuffix /main.provision, $(stages)))

$(_ROOT)/qemu/main.cat.pkr.hcl: $(_ROOT)/qemu/main.build $(stages)
	$(info Making $@)
	@cat $^ > $@
	@echo } >> $@
	@$(PACKER) init $@
