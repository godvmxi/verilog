source := testbench.v    fdivision.v  single_clk.v
top := testbench.v
target := top.o
$(target) : $(source)
	@iverilog -o $(target)  $(top)
	@echo "build over"
	@vvp $(target)  -lxt2

run : $(target)
	@vvp $(target)  -lxt2
.PHONY  : clean   scan
clean :
	@rm -rfv $(target)  *.o  *.vcd
scan :
	@find . -name "*.v" > files.lst
show : $(run)
	gtkwave wave.vcd &
