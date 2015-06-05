target := hello.o
${target} : hello.v
	iverilog -o $(target) hello.v
	@echo "build over"
clean :
	@rm $(target)  *.o
run :
	@vvp $(target)
