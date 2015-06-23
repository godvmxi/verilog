/*
 -- ============================================================================
 -- FILE NAME	: bus.h
 -- DESCRIPTION : 总线数据定义
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 
 -- ============================================================================
*/

`ifndef __BUS_HEADER__
	`define __BUS_HEADER__			 // 

	/********** 总线索引定义 *********/
	`define BUS_MASTER_CH	   4	 // 主控通道数
	`define BUS_MASTER_INDEX_W 2	 // 主控通道索引宽度

	/********** 总线所有者定义 *********/
	`define BusOwnerBus		   1:0	 // 总线所有者宽度
	`define BUS_OWNER_MASTER_0 2'h0	 // 总线所有者0
	`define BUS_OWNER_MASTER_1 2'h1	 // 总线所有者1
	`define BUS_OWNER_MASTER_2 2'h2	 // 总线所有者2
	`define BUS_OWNER_MASTER_3 2'h3	 // 总线所有者3

	/********** 总线slave定义 *********/
	`define BUS_SLAVE_CH	   8	 // slave设备数量
	`define BUS_SLAVE_INDEX_W  3	 // slave设备数量宽度定义
	`define BusSlaveIndexBus   2:0	 // slave设备数量宽度定义
	`define BusSlaveIndexLoc   29:27 // salve设备占据总线地址范围

	`define BUS_SLAVE_0		   0	 // 
	`define BUS_SLAVE_1		   1	 // 
	`define BUS_SLAVE_2		   2	 // 
	`define BUS_SLAVE_3		   3	 // 
	`define BUS_SLAVE_4		   4	 // 
	`define BUS_SLAVE_5		   5	 // 
	`define BUS_SLAVE_6		   6	 // 
	`define BUS_SLAVE_7		   7	 // 

`endif
