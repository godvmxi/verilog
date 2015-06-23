/*
 -- ============================================================================
 -- FILE NAME	: bus.h
 -- DESCRIPTION : �������ݶ���
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 
 -- ============================================================================
*/

`ifndef __BUS_HEADER__
	`define __BUS_HEADER__			 // 

	/********** ������������ *********/
	`define BUS_MASTER_CH	   4	 // ����ͨ����
	`define BUS_MASTER_INDEX_W 2	 // ����ͨ���������

	/********** ���������߶��� *********/
	`define BusOwnerBus		   1:0	 // ���������߿��
	`define BUS_OWNER_MASTER_0 2'h0	 // ����������0
	`define BUS_OWNER_MASTER_1 2'h1	 // ����������1
	`define BUS_OWNER_MASTER_2 2'h2	 // ����������2
	`define BUS_OWNER_MASTER_3 2'h3	 // ����������3

	/********** ����slave���� *********/
	`define BUS_SLAVE_CH	   8	 // slave�豸����
	`define BUS_SLAVE_INDEX_W  3	 // slave�豸������ȶ���
	`define BusSlaveIndexBus   2:0	 // slave�豸������ȶ���
	`define BusSlaveIndexLoc   29:27 // salve�豸ռ�����ߵ�ַ��Χ

	`define BUS_SLAVE_0		   0	 // 
	`define BUS_SLAVE_1		   1	 // 
	`define BUS_SLAVE_2		   2	 // 
	`define BUS_SLAVE_3		   3	 // 
	`define BUS_SLAVE_4		   4	 // 
	`define BUS_SLAVE_5		   5	 // 
	`define BUS_SLAVE_6		   6	 // 
	`define BUS_SLAVE_7		   7	 // 

`endif
