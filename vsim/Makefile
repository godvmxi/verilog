EXECUTABLE := test_counter
MODULE := counter

CC := vlog
CFLAGS := -reportprogress 300 +incdir+./include -work work -incr # add more option here if you want to compile with some library
COMPILE := $(CC) $(CFLAGS)

SIM := vsim
VIEW := vsim
TIME := -all
#ACTION := “log -ports -internal $(EXECUTABLE)/*;log -r $(EXECUTABLE)/$(MODULE)/*;run $(TIME);quit”
ACTION := “do wave.do;quit”
SFLAGS := do wave.do  $(EXECUTABLE).wlf
SFLAGS := -do wave.do  -voptargs=+acc -wlf $(EXECUTABLE).wlf 
SIMULATE := $(SIM) $(SFLAGS)

SRCS := $(wildcard *.v )

all:$(EXECUTABLE)

$(EXECUTABLE):$(SRCS)
	$(COMPILE) $(SRCS)

#run this when you compile the code the first time
start:
	vlib work 
	vmap work work

sim:
	vsim -do wave.do -voptargs=+acc work.$(EXECUTABLE)
#	$(VIEW) $(EXECUTABLE).wlf

clean:
	rm -rf *.wlf  *.ini  work
	bg 
	pkill make 
	pkill vish

