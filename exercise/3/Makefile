source := testbench.v    fdivision.v
top := testbench.v
target := fdivision.o
$(target) : $(source)
	@iverilog -o $(target)  $(top)
	@echo "build over"

run : $(target)
	@vvp $(target)  -lxt2
.PHONY  : clean   scan
clean :
	@rm -rfv $(target)
scan :
	@find . -name "*.v" > files.lst
