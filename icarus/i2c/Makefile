source := eeprom.v  eeprom_wr.v  signal.v  top.v
target := iic_eeprom.o
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
