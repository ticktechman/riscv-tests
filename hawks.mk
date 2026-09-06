###############################################################################
##
##       filename: hawks.mk
##    description:
##        created: 2026/09/06
##         author: ticktechman
##
###############################################################################
.PHONY: all build test install doc

hex_dir     := hawks
isa_dir     := isa
rv64_suites := ui um ua uf ud uc mi si
elf_dumps   := $(foreach b,$(rv64_suites),$(wildcard $(isa_dir)/rv64$(b)-p-*.dump))
rv64_hex    := $(patsubst %.dump,$(hex_dir)/%.hex,$(notdir $(elf_dumps)))

all: $(rv64_hex)

$(hex_dir)/%.hex:$(isa_dir)/%
	@printf "%40s : %s\n" $@ $<
	@$(eval hex_data := $(@:.hex=.data))
	@[[ -d $(hex_dir) ]] || mkdir $(hex_dir)
	@riscv-none-elf-objcopy -O verilog --verilog-data-width=1 -j .text.init --change-section-address .text.init=0 $< $@ >/dev/null
	@riscv-none-elf-objcopy -O verilog --verilog-data-width=1 -j .data --change-section-address .data=0 --no-change-warnings $< $(hex_data) >/dev/null
	@[[ -s $(hex_data) ]] || rm -f $(hex_data)

clean:
	rm -rf hawks

###############################################################################
