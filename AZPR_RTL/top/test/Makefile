target=chip_top.out 

${target} : test.dat
	./sim.sh rom.dat spm.dat  100
clean :
	rm -rf ${target}  *.vcd
