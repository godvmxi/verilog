/* generated.x
 *
 * Machine generated for a CPU named "cpu" as defined in:
 * D:\work\FPGA\quartus\nios_ii\HELLO\kernel.ptf
 *
 * Generated: 2015-05-19 00:25:20.138
 *
 */

/*

DO NOT MODIFY THIS FILE

   Changing this file will have subtle consequences
   which will almost certainly lead to a nonfunctioning
   system. If you do modify this file, be aware that your
   changes will be overwritten and lost when this file
   is generated again.

DO NOT MODIFY THIS FILE

*/

MEMORY
{
    reset : ORIGIN = 0x00000000, LENGTH = 32
    sdram_UNUSED : ORIGIN = 0x04000000, LENGTH = 32
    sdram : ORIGIN = 0x04000020, LENGTH = 33554400
    epcs : ORIGIN = 0x00000020, LENGTH = 2016
}

    /* Define symbols for each memory base-address */
 __alt_mem_sdram = 0x04000000 ;
 __alt_mem_epcs = 0x00000000 ;



OUTPUT_FORMAT( "elf32-littlenios2",
               "elf32-littlenios2",
               "elf32-littlenios2" )
OUTPUT_ARCH( nios2 )
ENTRY( _start )

/* Do we need any of these for elf?
   __DYNAMIC = 0;
 */

SECTIONS
{
    .entry :
    {
        KEEP (*(.entry))
    } > reset

    .exceptions :
    {
        PROVIDE (__ram_exceptions_start = ABSOLUTE(.));
        . = ALIGN(0x20);
        *(.irq)
        KEEP (*(.exceptions.entry.label));
        KEEP (*(.exceptions.entry.user));
        KEEP (*(.exceptions.entry));
        KEEP (*(.exceptions.irqtest.user));
        KEEP (*(.exceptions.irqtest));
        KEEP (*(.exceptions.irqhandler.user));
        KEEP (*(.exceptions.irqhandler));
        KEEP (*(.exceptions.irqreturn.user));
        KEEP (*(.exceptions.irqreturn));
        KEEP (*(.exceptions.notirq.label));
        KEEP (*(.exceptions.notirq.user));
        KEEP (*(.exceptions.notirq));
        KEEP (*(.exceptions.soft.user));
        KEEP (*(.exceptions.soft));
        KEEP (*(.exceptions.unknown.user));
        KEEP (*(.exceptions.unknown));
        KEEP (*(.exceptions.exit.label));
        KEEP (*(.exceptions.exit.user));
        KEEP (*(.exceptions.exit));
        KEEP (*(.exceptions));
        PROVIDE (__ram_exceptions_end = ABSOLUTE(.));
    } > sdram

    PROVIDE (__flash_exceptions_start = LOADADDR(.exceptions));

    .text :
    {
        /*
         * All code sections are merged into the text output section, along with
         * the read only data sections.
         *
         */

        PROVIDE (stext = ABSOLUTE(.));

        *(.interp)
        *(.hash)
        *(.dynsym)
        *(.dynstr)
        *(.gnu.version)
        *(.gnu.version_d)
        *(.gnu.version_r)
        *(.rel.init)
        *(.rela.init)
        *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*)
        *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*)
        *(.rel.fini)
        *(.rela.fini)
        *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*)
        *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*)
        *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*)
        *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*)
        *(.rel.tdata .rel.tdata.* .rel.gnu.linkonce.td.*)
        *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*)
        *(.rel.tbss .rel.tbss.* .rel.gnu.linkonce.tb.*)
        *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*)
        *(.rel.ctors)
        *(.rela.ctors)
        *(.rel.dtors)
        *(.rela.dtors)
        *(.rel.got)
        *(.rela.got)
        *(.rel.sdata .rel.sdata.* .rel.gnu.linkonce.s.*)
        *(.rela.sdata .rela.sdata.* .rela.gnu.linkonce.s.*)
        *(.rel.sbss .rel.sbss.* .rel.gnu.linkonce.sb.*)
        *(.rela.sbss .rela.sbss.* .rela.gnu.linkonce.sb.*)
        *(.rel.sdata2 .rel.sdata2.* .rel.gnu.linkonce.s2.*)
        *(.rela.sdata2 .rela.sdata2.* .rela.gnu.linkonce.s2.*)
        *(.rel.sbss2 .rel.sbss2.* .rel.gnu.linkonce.sb2.*)
        *(.rela.sbss2 .rela.sbss2.* .rela.gnu.linkonce.sb2.*)
        *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*)
        *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*)
        *(.rel.plt)
        *(.rela.plt)

        KEEP (*(.init))
        *(.plt)
        *(.text .stub .text.* .gnu.linkonce.t.*)

        /* .gnu.warning sections are handled specially by elf32.em.  */

        *(.gnu.warning.*)
        KEEP (*(.fini))
        PROVIDE (__etext = ABSOLUTE(.));
        PROVIDE (_etext = ABSOLUTE(.));
        PROVIDE (etext = ABSOLUTE(.));

        *(.eh_frame_hdr)
        /* Ensure the __preinit_array_start label is properly aligned.  We
           could instead move the label definition inside the section, but
           the linker would then create the section even if it turns out to
           be empty, which isn't pretty.  */
        . = ALIGN(32 / 8);
        PROVIDE (__preinit_array_start = ABSOLUTE(.));
        *(.preinit_array)
        PROVIDE (__preinit_array_end = ABSOLUTE(.));
        PROVIDE (__init_array_start = ABSOLUTE(.));
        *(.init_array)
        PROVIDE (__init_array_end = ABSOLUTE(.));
        PROVIDE (__fini_array_start = ABSOLUTE(.));
        *(.fini_array)
        PROVIDE (__fini_array_end = ABSOLUTE(.));
        SORT(CONSTRUCTORS)
        KEEP (*(.eh_frame))
        *(.gcc_except_table)
        *(.dynamic)
        PROVIDE (__CTOR_LIST__ = ABSOLUTE(.));
        KEEP (*(.ctors))
        KEEP (*(SORT(.ctors.*)))
        PROVIDE (__CTOR_END__ = ABSOLUTE(.));
        PROVIDE (__DTOR_LIST__ = ABSOLUTE(.));
        KEEP (*(.dtors))
        KEEP (*(SORT(.dtors.*)))
        PROVIDE (__DTOR_END__ = ABSOLUTE(.));
        KEEP (*(.jcr))
        . = ALIGN(32 / 8);
    } >  sdram =0x3a880100 /* NOP on Nios2 (big endian) */

    .rodata :
    {
        PROVIDE (__ram_rodata_start = ABSOLUTE(.));
        . = ALIGN(32 / 8);
        *(.rodata .rodata.* .gnu.linkonce.r.*)
        *(.rodata1)
        . = ALIGN(32 / 8);
        PROVIDE (__ram_rodata_end = ABSOLUTE(.));
    } > sdram

    PROVIDE (__flash_rodata_start = LOADADDR(.rodata));

    .rwdata  :
    {
        PROVIDE (__ram_rwdata_start = ABSOLUTE(.));
        . = ALIGN(32 / 8);
        *(.got.plt) *(.got)
        *(.data1)
        *(.data .data.* .gnu.linkonce.d.*)

        _gp = ABSOLUTE(. + 0x8000);
        PROVIDE(gp = _gp);

        *(.sdata .sdata.* .gnu.linkonce.s.*)
        *(.sdata2 .sdata2.* .gnu.linkonce.s2.*)

        . = ALIGN(32 / 8);
        _edata = ABSOLUTE(.);
        PROVIDE (edata = ABSOLUTE(.));
        PROVIDE (__ram_rwdata_end = ABSOLUTE(.));
    } > sdram

    PROVIDE (__flash_rwdata_start = LOADADDR(.rwdata));

    .bss :
    {
        __bss_start = ABSOLUTE(.);
        PROVIDE (__sbss_start = ABSOLUTE(.));
        PROVIDE (___sbss_start = ABSOLUTE(.));

        *(.dynsbss)
        *(.sbss .sbss.* .gnu.linkonce.sb.*)
        *(.sbss2 .sbss2.* .gnu.linkonce.sb2.*)
        *(.scommon)

        PROVIDE (__sbss_end = ABSOLUTE(.));
        PROVIDE (___sbss_end = ABSOLUTE(.));

        *(.dynbss)
        *(.bss .bss.* .gnu.linkonce.b.*)
        *(COMMON)

        . = ALIGN(32 / 8);
        __bss_end = ABSOLUTE(.);
    } > sdram

    /*
     * One output section for each of the available partitions. These are not
     * used by default, but can be used by users applications using the .section
     * directive.
     *
     * The memory partition used for the heap is treated in  special way, i.e. a
     * symbol is added to point to the heap start.
     *
     * Note that when running from flash, these sections are not loaded by the
     * HAL.
     *
     */

    .sdram :
    {
        PROVIDE (_alt_partition_sdram_start = ABSOLUTE(.));
        *(.sdram .sdram.*)
        . = ALIGN(32 / 8);
        PROVIDE (_alt_partition_sdram_end = ABSOLUTE(.));
        _end = ABSOLUTE(.);
        end = ABSOLUTE(.);
        __alt_stack_base = ABSOLUTE(.);
    } > sdram

    PROVIDE (_alt_partition_sdram_load_addr = LOADADDR(.sdram));

    .epcs :
    {
        PROVIDE (_alt_partition_epcs_start = ABSOLUTE(.));
        *(.epcs .epcs.*)
        . = ALIGN(32 / 8);
        PROVIDE (_alt_partition_epcs_end = ABSOLUTE(.));
    } > epcs

    PROVIDE (_alt_partition_epcs_load_addr = LOADADDR(.epcs));

    /*
     * Stabs debugging sections.
     *
     */

    .stab          0 : { *(.stab) }
    .stabstr       0 : { *(.stabstr) }
    .stab.excl     0 : { *(.stab.excl) }
    .stab.exclstr  0 : { *(.stab.exclstr) }
    .stab.index    0 : { *(.stab.index) }
    .stab.indexstr 0 : { *(.stab.indexstr) }
    .comment       0 : { *(.comment) }
    /* DWARF debug sections.
       Symbols in the DWARF debugging sections are relative to the beginning
       of the section so we begin them at 0.  */
    /* DWARF 1 */
    .debug          0 : { *(.debug) }
    .line           0 : { *(.line) }
    /* GNU DWARF 1 extensions */
    .debug_srcinfo  0 : { *(.debug_srcinfo) }
    .debug_sfnames  0 : { *(.debug_sfnames) }
    /* DWARF 1.1 and DWARF 2 */
    .debug_aranges  0 : { *(.debug_aranges) }
    .debug_pubnames 0 : { *(.debug_pubnames) }
    /* DWARF 2 */
    .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
    .debug_abbrev   0 : { *(.debug_abbrev) }
    .debug_line     0 : { *(.debug_line) }
    .debug_frame    0 : { *(.debug_frame) }
    .debug_str      0 : { *(.debug_str) }
    .debug_loc      0 : { *(.debug_loc) }
    .debug_macinfo  0 : { *(.debug_macinfo) }
    /* SGI/MIPS DWARF 2 extensions */
    .debug_weaknames 0 : { *(.debug_weaknames) }
    .debug_funcnames 0 : { *(.debug_funcnames) }
    .debug_typenames 0 : { *(.debug_typenames) }
    .debug_varnames  0 : { *(.debug_varnames) }

    /* Altera debug extensions */
    .debug_alt_sim_info 0 : { *(.debug_alt_sim_info) }
}
/* provide a pointer for the stack */

/*
 * Don't override this, override the __alt_stack_* symbols instead.
 */
__alt_data_end = 0x06000000;

/*
 * The next two symbols define the location of the default stack.  You can
 * override them to move the stack to a different memory.
 */
PROVIDE( __alt_stack_pointer = __alt_data_end );
PROVIDE( __alt_stack_limit   = __alt_stack_base );

/*
 * This symbol controls where the start of the heap is.  If the stack is
 * contiguous with the heap then the stack will contract as memory is
 * allocated to the heap.
 * Override this symbol to put the heap in a different memory.
 */
PROVIDE( __alt_heap_start    = end );
PROVIDE( __alt_heap_limit    = 0x06000000 );
