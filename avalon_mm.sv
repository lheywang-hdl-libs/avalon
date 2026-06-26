/**
 * @file    avalon_mm.sv
 * @brief   Define the standard Avalon-MM signals as an interface file.
 *
 * @details As always with me, the file implement the "complete" spec as referenced on the website.
 *          Not all signals are required and are driven, therefore depending on the synthesis tool, not
 *          all signals may be present.
 *
 * @author  l.heywang <leonard.heywang@proton.me>
 * @date    26/06/2026
 *
 * @copyright l.heywang, MIT License.
 */

interface avalon_mm #(
    parameter int                       ADDR_WIDTH = 32,
    parameter int                       DATA_WIDTH = 32,
    parameter int                       MAX_BURST = 32
);
    // Common signals
    logic [ADDR_WIDTH - 1 : 0]          address;

    // Data signals
    logic [(DATA_WIDTH / 8) - 1 : 0]    byteenable;
    logic                               read;
    logic                               write;
    logic [DATA_WIDTH - 1 : 0]          readdata;
    logic                               readdatavalid;
    logic [DATA_WIDTH - 1 : 0]          writedata;
    logic [1 : 0]                       response;
    logic                               writeresponsevalid;

    // Wait signals
    logic                               lock;
    logic                               waitrequest;

    // Bursts
    logic [$clog2(MAX_BURST) : 0]       burstcount;

    // Misc signals
    logic                               beginbursttransfer; // Legacy.
    logic                               debugaccess; // For NIOS II only.

    modport master (
        // Common signals
        output  address,

        // Data signals
        output  byteenable,
        output  read,
        output  write,
        input   readdata,
        input   readdatavalid,
        output  writedata,
        input   response,
        input   writeresponsevalid,

        // Wait signals
        output  lock,
        input   waitrequest,

        // Bursts signals
        output  burstcount,

        // Legacy signals
        output  beginbursttransfer,
        output  debugaccess
    );

    modport slave (
        // Common signals
        input   address,

        // Data signals
        input   byteenable,
        input   read,
        input   write,
        output  readdata,
        output  readdatavalid,
        input   writedata,
        output  response,
        output  writeresponsevalid,

        // Wait signals
        input   lock,
        output  waitrequest,

        // Bursts signals
        input   burstcount,

        // Legacy signals
        input   beginbursttransfer,
        input   debugaccess
    );

endinterface: avalon_mm
