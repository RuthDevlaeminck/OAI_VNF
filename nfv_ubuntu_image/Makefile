%.tar: %/vnfd.json %/Metadata.yaml %/scripts
	@tar -C $(<D) -chvf $@ $(^F)

.PHONY: all
all: oaihss oaimme oaispgw

.PHONY: oaihss oaimme oaispgw
oaihss: oaihss.tar
oaimme: oaimme.tar
oaispgw: oaispgw.tar

.PHONY: clean
clean:
	@rm -f *.tar
