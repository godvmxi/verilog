/*
 -- ============================================================================
 -- FILE	 : bus_arbiter.v
 -- SYNOPSIS : ×ÜÏßÖÙ²ÃÆ÷
 -- ----------------------------------------------------------------------------
 -- Revision  Date		  Coding_by	 Comment
 -- 1.0.0	  2011/06/27  suito		 V‹Kì¬
 -- ============================================================================
*/

/********** ‹¤’Êƒwƒbƒ_ƒtƒ@ƒCƒ‹ **********/
`include "nettype.h"
`include "stddef.h"
`include "global_config.h"

/********** ŒÂ•Êƒwƒbƒ_ƒtƒ@ƒCƒ‹ **********/
`include "bus.h"

/********** ƒ‚ƒWƒ…[ƒ‹ **********/
module bus_arbiter (
	/********** ƒNƒƒbƒN & ƒŠƒZƒbƒg **********/
	input  wire		   clk,		 // ƒNƒƒbƒN
	input  wire		   reset,	 // ”ñ“¯ŠúƒŠƒZƒbƒg
	/********** ƒA[ƒrƒgƒŒ[ƒVƒ‡ƒ“M† **********/
	// ƒoƒXƒ}ƒXƒ^0”Ô
	input  wire		   m0_req_,	 // ƒoƒXƒŠƒNƒGƒXƒg
	output reg		   m0_grnt_, // ƒoƒXƒOƒ‰ƒ“ƒg
	// ƒoƒXƒ}ƒXƒ^1”Ô
	input  wire		   m1_req_,	 // ƒoƒXƒŠƒNƒGƒXƒg
	output reg		   m1_grnt_, // ƒoƒXƒOƒ‰ƒ“ƒg
	// ƒoƒXƒ}ƒXƒ^2”Ô
	input  wire		   m2_req_,	 // ƒoƒXƒŠƒNƒGƒXƒg
	output reg		   m2_grnt_, // ƒoƒXƒOƒ‰ƒ“ƒg
	// ƒoƒXƒ}ƒXƒ^3”Ô
	input  wire		   m3_req_,	 // ƒoƒXƒŠƒNƒGƒXƒg
	output reg		   m3_grnt_	 // ƒoƒXƒOƒ‰ƒ“ƒg
);

	/********** “à•”M† **********/
	reg [`BusOwnerBus] owner;	 // ƒoƒXŒ ‚ÌŠ—LÒ
   
	/********** ƒoƒXƒOƒ‰ƒ“ƒg‚Ì¶¬ **********/
	always @(*) begin
		/* ƒoƒXƒOƒ‰ƒ“ƒg‚Ì‰Šú‰» */
		m0_grnt_ = `DISABLE_;
		m1_grnt_ = `DISABLE_;
		m2_grnt_ = `DISABLE_;
		m3_grnt_ = `DISABLE_;
		/* ƒoƒXƒOƒ‰ƒ“ƒg‚Ì¶¬ */
		case (owner)
			`BUS_OWNER_MASTER_0 : begin // ƒoƒXƒ}ƒXƒ^0”Ô
				m0_grnt_ = `ENABLE_;
			end
			`BUS_OWNER_MASTER_1 : begin // ƒoƒXƒ}ƒXƒ^1”Ô
				m1_grnt_ = `ENABLE_;
			end
			`BUS_OWNER_MASTER_2 : begin // ƒoƒXƒ}ƒXƒ^2”Ô
				m2_grnt_ = `ENABLE_;
			end
			`BUS_OWNER_MASTER_3 : begin // ƒoƒXƒ}ƒXƒ^3”Ô
				m3_grnt_ = `ENABLE_;
			end
		endcase
	end
   
	/********** ƒoƒXŒ ‚ÌƒA[ƒrƒgƒŒ[ƒVƒ‡ƒ“ **********/
	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			/* ”ñ“¯ŠúƒŠƒZƒbƒg */
			owner <= #1 `BUS_OWNER_MASTER_0;
		end else begin
			/* ƒA[ƒrƒgƒŒ[ƒVƒ‡ƒ“ */
			case (owner)
				`BUS_OWNER_MASTER_0 : begin // ƒoƒXŒ Š—LÒFƒoƒXƒ}ƒXƒ^0”Ô
					/* Ÿ‚ÉƒoƒXŒ ‚ğŠl“¾‚·‚éƒ}ƒXƒ^ */
					if (m0_req_ == `ENABLE_) begin			// ƒoƒXƒ}ƒXƒ^0”Ô
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^1”Ô
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^2”Ô
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^3”Ô
						owner <= #1 `BUS_OWNER_MASTER_3;
					end
				end
				`BUS_OWNER_MASTER_1 : begin // ƒoƒXŒ Š—LÒFƒoƒXƒ}ƒXƒ^1”Ô
					/* Ÿ‚ÉƒoƒXŒ ‚ğŠl“¾‚·‚éƒ}ƒXƒ^ */
					if (m1_req_ == `ENABLE_) begin			// ƒoƒXƒ}ƒXƒ^1”Ô
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^2”Ô
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^3”Ô
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^0”Ô
						owner <= #1 `BUS_OWNER_MASTER_0;
					end
				end
				`BUS_OWNER_MASTER_2 : begin // ƒoƒXŒ Š—LÒFƒoƒXƒ}ƒXƒ^2”Ô
					/* Ÿ‚ÉƒoƒXŒ ‚ğŠl“¾‚·‚éƒ}ƒXƒ^ */
					if (m2_req_ == `ENABLE_) begin			// ƒoƒXƒ}ƒXƒ^2”Ô
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^3”Ô
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^0”Ô
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^1”Ô
						owner <= #1 `BUS_OWNER_MASTER_1;
					end
				end
				`BUS_OWNER_MASTER_3 : begin // ƒoƒXŒ Š—LÒFƒoƒXƒ}ƒXƒ^3”Ô
					/* Ÿ‚ÉƒoƒXŒ ‚ğŠl“¾‚·‚éƒ}ƒXƒ^ */
					if (m3_req_ == `ENABLE_) begin			// ƒoƒXƒ}ƒXƒ^3”Ô
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^0”Ô
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^1”Ô
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin // ƒoƒXƒ}ƒXƒ^2”Ô
						owner <= #1 `BUS_OWNER_MASTER_2;
					end
				end
			endcase
		end
	end

endmodule
