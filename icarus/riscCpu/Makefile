source := accum.v  addr_decode.v  adr.v  alu.v  clk_gen.v  counter.v  cputop.v  cpu.v  datactl.v  machinectl.v  machine.v  ram.v  register.v  rom.v
top := cputop.v
target := cpu.o
$(target) : $(source)
	@iverilog -o $(target)  $(top)
	@echo "build over"

run : $(target)
	@vvp $(target)
.PHONY  : clean scan
clean :
	@rm -rfv $(target)
scan :
	@find . -name "*.v" > files.lst
