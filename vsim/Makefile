EXECUTABLE := top_module #to be correct
MODULE := module_to_be_sim #to be correct

CC := vlog
CFLAGS := -reportprogress 300 +incdir+./include -work work -incr # add more option here if you want to compile with some library
COMPILE := $(CC) $(CFLAGS)

SIM := vsim
VIEW := vsim
TIME := -all
ACTION := “log -ports -internal $(EXECUTABLE)/*;log -r $(EXECUTABLE)/$(MODULE)/*;run $(TIME);quit”
SFLAGS := -c -do $(ACTION) -wlf $(EXECUTABLE).wlf
SIMULATE := $(SIM) $(SFLAGS)

SRCS := $(wildcard *.v )

all:$(EXECUTABLE)

$(EXECUTABLE):$(SRCS)
	$(COMPILE) $(SRCS)

#run this when you compile the code the first time
start:
	vlib work && vmap work work

sim:
	$(SIMULATE) work.$(EXECUTABLE)
	$(VIEW) $(EXECUTABLE).wlf

clean:
	rm -rf *.wlf && bg && pkill make && pkill vish

