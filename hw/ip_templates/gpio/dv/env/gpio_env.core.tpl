CAPI=2:
# Copyright lowRISC contributors (OpenTitan project).
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
name: ${instance_vlnv(f"lowrisc:dv:{module_instance_name}_env:0.1")}
description: "GPIO DV UVM environmnt"
filesets:
  files_dv:
    depend:
      - lowrisc:dv:ralgen
      - lowrisc:dv:cip_lib
      - lowrisc:opentitan:top_${topname}_gpio:0.1
    files:
      - gpio_env_pkg.sv
      - gpio_env_cfg.sv: {is_include_file: true}
      - gpio_env_cov.sv: {is_include_file: true}
      - gpio_virtual_sequencer.sv: {is_include_file: true}
      - gpio_agent/gpio_strap_agent_cfg.sv: {is_include_file: true}
      - gpio_agent/gpio_strap_driver.sv: {is_include_file: true}
      - gpio_agent/gpio_strap_monitor.sv: {is_include_file: true}
      - gpio_agent/gpio_strap_agent.sv: {is_include_file: true}
      - gpio_scoreboard.sv: {is_include_file: true}
      - gpio_env.sv: {is_include_file: true}
      - seq_lib/gpio_vseq_list.sv: {is_include_file: true}
      - seq_lib/gpio_base_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_common_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_smoke_vseq.sv: {is_include_file: true}
% if num_inp_period_counters > 0:
      - seq_lib/gpio_inp_prd_cnt_vseq.sv: {is_include_file: true}
% endif
      - seq_lib/gpio_rand_intr_trigger_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_random_dout_din_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_dout_din_regs_random_rw_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_random_long_reg_writes_reg_reads_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_filter_stress_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_full_random_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_stress_all_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_intr_rand_pgm_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_intr_with_filter_rand_intr_event_vseq.sv: {is_include_file: true}
      - seq_lib/gpio_rand_straps_vseq.sv : {is_include_file: true}
      - seq_lib/gpio_seq_item.sv: {is_include_file: true}
      - seq_lib/gpio_strap_en_vseq.sv: {is_include_file: true}
    file_type: systemVerilogSource

generate:
  ral:
    generator: ralgen
    parameters:
      name: ${module_instance_name}
      ip_hjson: ../../data/${module_instance_name}.hjson

targets:
  default:
    filesets:
      - files_dv
    generate:
      - ral
