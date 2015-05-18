#!/bin/sh
#
# generated.sh - shell script fragment - not very useful on its own
#
# Machine generated for a CPU named "cpu" as defined in:
# D:\work\FPGA\quartus\nios_ii\LED\kernel.ptf
#
# Generated: 2015-05-19 00:52:08.965

# DO NOT MODIFY THIS FILE
#
#   Changing this file will have subtle consequences
#   which will almost certainly lead to a nonfunctioning
#   system. If you do modify this file, be aware that your
#   changes will be overwritten and lost when this file
#   is generated again.
#
# DO NOT MODIFY THIS FILE

# This variable indicates where the PTF file for this design is located
ptf=D:\work\FPGA\quartus\nios_ii\LED\kernel.ptf

# This variable indicates whether there is a CPU debug core
nios2_debug_core=yes

# This variable indicates how to connect to the CPU debug core
nios2_instance=0

# This variable indicates the CPU module name
nios2_cpu_name=cpu

# These variables indicate what the System ID peripheral should hold
sidp=0x00001810
id=12345678u
timestamp=1431967266u

# Include operating system specific parameters, if they are supplied.

if test -f /cygdrive/c/altera/11.0/nios2eds/components/altera_hal/build/os.sh ; then
   . /cygdrive/c/altera/11.0/nios2eds/components/altera_hal/build/os.sh
fi
