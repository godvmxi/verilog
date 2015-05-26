source := counter.v counter_tb.v
target := counter.o
$(target) : $(source)
	@iverilog -o $(target) $(source) 
	@echo "build over"

run : $(target)
	@vvp $(target)
.PHONY  : clean scan
clean :
	@rm -rfv $(target)
scan :
	@find . -name "*.v" > files.lst
