source := compare.v  testbench.v
top := testbench.v
target := compare.o
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
