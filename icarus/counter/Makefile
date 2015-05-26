source := counter.v counter_tb.v
target := counter.o
$(target) : $(source)
	@iverilog -o $(target)  $(source)
	@echo "build over"
clean :
	@rm $(target)
run :
	@vvp $(target)
