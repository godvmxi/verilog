source := compare.v  testbench.v  practice.v
top := testbench.v
target := tb.o
$(target) : $(source)
	@iverilog -o $(target)  $(top)
	@echo "build over"
	@vvp $(target)  -lxt2
	@echo "build wave over"


run : $(target)
	@vvp $(target)
.PHONY  : clean scan
clean :
	@rm -rfv $(target)
scan :
	@find . -name "*.v" > files.lst
