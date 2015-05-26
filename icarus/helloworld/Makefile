target := hello.o
$target : hello.v
	@./build.sh
	@echo "build over"
clean :
	@rm $(target)
run :
	@vvp $(target)
