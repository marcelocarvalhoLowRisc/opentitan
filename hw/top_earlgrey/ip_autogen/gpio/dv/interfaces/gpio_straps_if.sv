// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
// interface : gpio_straps_if

import gpio_pkg::*;

// Interface definition
interface gpio_straps_if(input logic clk, input logic rst_n);

  logic          strap_en;       // Signal to enable straps
  gpio_straps_t  sampled_straps; // Sampled gpio_i snapshot data from GPIO (DUT)

  modport dut_port(input strap_en, output sampled_straps);
  modport tb_port(output strap_en, input sampled_straps);

endinterface
