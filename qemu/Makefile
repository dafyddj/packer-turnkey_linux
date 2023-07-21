stages := $(shell cat ../stages)
stages := $(filter-out install, $(stages))
stages := $(addprefix ../, $(addsuffix /main.provision, $(stages)))

main.cat.pkr.hcl: main.build $(stages)
	$(info Making $@)
	@cat $^ > $@
	@echo } >> $@
	@packer init $@
	@packer validate $@
