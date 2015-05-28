source := testbench.v    fdivision.v single_clk.v
top := testbench.v
target := fdivision.o
$(target) : $(source)
	@iverilog -o $(target)  $(top)
	@echo "build over"

run : $(target)
	@vvp $(target)  -lxt2
	gtkwave wave.vcd &
.PHONY  : clean   scan
clean :
	@rm -rfv $(target)
scan :
	@find . -name "*.v" > files.lst
