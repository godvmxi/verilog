source := testbench.v    P_S.v  S_P.v  practice.v
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
