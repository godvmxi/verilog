source := testbench.v    alu.v
top := testbench.v
target := tb.o
$(target) : $(source)
	@iverilog -o $(target)  $(top)
	@echo "build over"

run : $(target)
	@vvp $(target)  -lxt2
.PHONY  : clean  show
clean :
	@rm -rfv $(target)   *.o *.vcd
show :
	gtkwave wave.vcd &
