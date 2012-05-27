SOURCES = $(wildcard test-*.vala)

all: $(patsubst test-%.vala, %-test, $(SOURCES))

%-test: test-%.vala test-%.flags ../%.vapi
	valac -o $@ --vapidir .. --pkg $* $< --save-temps $(shell cat test-$*.flags)
