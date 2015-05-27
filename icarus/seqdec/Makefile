source := detector110.v testbench.v
target := detector110.o

object := $(target).o
wave := $(target).vcd
$(target) : $(source)
	@iverilog -o $(target) $(source) 
	@echo "build over"

run : $(target)
	@vvp $(target) -lxt2
.PHONY  : clean scan wave
clean :
	@rm -rfv $(target) *.vcd
scan :
	@find . -name "*.v" > files.lst
wave :
	@gtkwave *.vcd  &
