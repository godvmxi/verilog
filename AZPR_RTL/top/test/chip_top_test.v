/*
 -- ============================================================================
 -- FILE NAME	: chip_top_test.v
 -- DESCRIPTION : �e�X�g�x���`
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2012/04/02  suito		 �V�K�쐬
 -- ============================================================================
*/

/********** time  define **********/
`timescale 1ns/1ps					 //

/********** common include  **********/
`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

/********** include  **********/
`include "bus.h"
`include "cpu.h"
`include "gpio.h"

/********** chip top test **********/
module chip_top_test;
	/********** ���o�͐M�� **********/
	// �N���b�N & ���Z�b�g
	reg						clk_ref;	   // �����N���b�N
	reg						reset_sw;	   // �O���[�o�����Z�b�g
	// UART
`ifdef IMPLEMENT_UART // UART����
	wire					uart_rx;	   // UART���M�M��
	wire					uart_tx;	   // UART���M�M��
`endif
	// �ėp���o�̓|�[�g
`ifdef IMPLEMENT_GPIO // GPIO����
`ifdef GPIO_IN_CH	 // ���̓|�[�g�̎���
	wire [`GPIO_IN_CH-1:0]	gpio_in = {`GPIO_IN_CH{1'b0}}; // ���̓|�[�g
`endif
`ifdef GPIO_OUT_CH	 // �o�̓|�[�g�̎���
	wire [`GPIO_OUT_CH-1:0] gpio_out;					   // �o�̓|�[�g
`endif
`ifdef GPIO_IO_CH	 // ���o�̓|�[�g�̎���
	wire [`GPIO_IO_CH-1:0]	gpio_io = {`GPIO_IO_CH{1'bz}}; // ���o�̓|�[�g
`endif
`endif

	/********** UART���f�� **********/
`ifdef IMPLEMENT_UART // UART����
	wire					 rx_busy;		  // ���M���t���O
	wire					 rx_end;		  // ���M�����M��
	wire [`ByteDataBus]		 rx_data;		  // ���M�f�[�^
`endif

	/********** �V�~�����[�V�����T�C�N�� **********/
	parameter				 STEP = 100.0000; // 10 M

	/********** �N���b�N���� **********/
	always #( STEP / 2 ) begin
		clk_ref <= ~clk_ref;
	end

	/********** chip_top�̃C���X�^���X�� **********/
	chip_top chip_top (
		/********** �N���b�N & ���Z�b�g **********/
		.clk_ref	(clk_ref), // �����N���b�N
		.reset_sw	(reset_sw) // �O���[�o�����Z�b�g
		/********** UART **********/
`ifdef IMPLEMENT_UART // UART����
		, .uart_rx	(uart_rx)  // UART���M�M��
		, .uart_tx	(uart_tx)  // UART���M�M��
`endif
	/********** �ėp���o�̓|�[�g **********/
`ifdef IMPLEMENT_GPIO // GPIO����
`ifdef GPIO_IN_CH			   // ���̓|�[�g�̎���
		, .gpio_in	(gpio_in)  // ���̓|�[�g
`endif
`ifdef GPIO_OUT_CH	 // �o�̓|�[�g�̎���
		, .gpio_out (gpio_out) // �o�̓|�[�g
`endif
`ifdef GPIO_IO_CH	 // ���o�̓|�[�g�̎���
		, .gpio_io	(gpio_io)  // ���o�̓|�[�g
`endif
`endif
);

	/********** GPIO **********/
`ifdef IMPLEMENT_GPIO // GPIO
`ifdef GPIO_IN_CH	 //
	always @(gpio_in) begin	 // gpio_in monitor
		$display($time, " gpio_in changed  : %b", gpio_in);
	end
`endif
`ifdef GPIO_OUT_CH	 //
	always @(gpio_out) begin // gpio_out monitor
		$display($time, " gpio_out changed : %b", gpio_out);
	end
`endif
`ifdef GPIO_IO_CH	 //
	always @(gpio_io) begin // gpio_io monitor
		$display($time, " gpio_io changed  : %b", gpio_io);
	end
`endif
`endif

	/********** UART���f���̃C���X�^���X�� **********/
`ifdef IMPLEMENT_UART // UART����
	/********** ���M�M�� **********/
	assign uart_rx = `HIGH;		// �A�C�h��
//	  assign uart_rx = uart_tx; // ���[�v�o�b�N

	/********** UART���f�� **********/
	uart_rx uart_model (
		/********** �N���b�N & ���Z�b�g **********/
		.clk	  (chip_top.clk),		 // �N���b�N
		.reset	  (chip_top.chip_reset), // �񓯊����Z�b�g
		/********** �����M�� **********/
		.rx_busy  (rx_busy),			 // ���M���t���O
		.rx_end	  (rx_end),				 // ���M�����M��
		.rx_data  (rx_data),			 // ���M�f�[�^
		/********** Receive Signal **********/
		.rx		  (uart_tx)				 // UART���M�M��
	);

	/********** ���M�M���̃��j�^�����O **********/
	always @(posedge chip_top.clk) begin
		if (rx_end == `ENABLE) begin // ���M�����當�����o��
			$write("%c", rx_data);
		end
	end
`endif

	/********** �e�X�g�V�[�P���X **********/
	initial begin
		# 0 begin
			clk_ref	 <= `HIGH;
			reset_sw <= `RESET_ENABLE;
		end
		# ( STEP / 2 )
		# ( STEP / 4 ) begin		  // �������C���[�W�̓ǂݍ���
			$readmemh(`ROM_PRG, chip_top.chip.rom.x_s3e_sprom.mem);
			$readmemh(`SPM_PRG, chip_top.chip.cpu.spm.x_s3e_dpram.mem);
		end
		# ( STEP * 20 ) begin		  // ���Z�b�g�̉���
			reset_sw <= `RESET_DISABLE;
		end
		# ( STEP * `SIM_CYCLE ) begin // �V�~�����[�V�����̎��s
			$finish;
		end
	end

	/********** �g�`�̏o�� **********/
	initial begin
		$dumpfile("chip_top.vcd");
		$dumpvars(0, chip_top);
	end

endmodule
