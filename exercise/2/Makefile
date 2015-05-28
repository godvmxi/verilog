source := testbench.v    half_clk.v  thinking.v practice.v
top := testbench.v
target := tb.o
$(target) : $(source)
	@iverilog -o $(target)  $(top)
	@echo "build over"

run : $(target)
	@vvp $(target)  -lxt2
.PHONY  : clean   scan
clean :
	@rm -rfv $(target)  *.o *.vcd
scan :
	@find . -name "*.v" > files.lst
