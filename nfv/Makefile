%.tar: %/vnfd.json %/Metadata.yaml %/scripts
	@tar -C $(<D) -chvf $@ $(^F)

.PHONY: all
all: oaihss oaimme oaispgw oaiepc

.PHONY: oaihss oaimme oaispgw oaiepc
oaihss: oaihss.tar
oaimme: oaimme.tar
oaispgw: oaispgw.tar
oaiepc: oaiepc.tar

.PHONY: clean
clean:
	@rm -f *.tar
