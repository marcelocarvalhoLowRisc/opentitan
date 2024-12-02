// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

class cip_base_virtual_sequencer #(type CFG_T = cip_base_env_cfg,
                                   type COV_T = cip_base_env_cov)
                                   extends dv_base_virtual_sequencer #(CFG_T, COV_T);
  `uvm_component_param_utils(cip_base_virtual_sequencer #(CFG_T, COV_T))

  // similar to (ral, ral_models) and (m_tl_agent_cfg, m_tl_agent_cfgs)
  // if the block supports only one RAL, just use tl_sequencer_h
  // if there are multiple RALs, `tl_sequencer_h` is the default one for RAL with type `RAL_T`
  tl_sequencer        tl_sequencer_h;
  tl_sequencer        tl_sequencer_hs[string];

  alert_esc_sequencer alert_esc_sequencer_h[string];
  push_pull_sequencer#(.DeviceDataWidth(EDN_DATA_WIDTH)) edn_pull_sequencer_h;

  `uvm_component_new

  bit rnd_rst_started;
  

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
      monitor_reset();
    join_none
  endtask

  // Method to get the current running sequence
  virtual task kill_running_sequence();
    dv_base_vseq  running_seq;

    // Get the current sequence (if any)
    
    $cast(running_seq, get_current_item());

    if (running_seq != null) begin
        // Cast to the specific sequence type if needed
        running_seq.kill();
        `uvm_info(get_type_name(), "sequence is killed", UVM_MEDIUM)
    end
endtask


  virtual task monitor_reset();
    forever begin
        @(rnd_rst_started)    
        `uvm_info(`gfn, "Sequencer - reset occurred", UVM_HIGH)
        tl_sequencer_h.m_last_req_buffer.delete();
        tl_sequencer_h.m_last_rsp_buffer.delete();

        foreach(tl_sequencer_hs[i]) begin
          tl_sequencer_hs[i].m_last_req_buffer.delete();
          tl_sequencer_hs[i].m_last_rsp_buffer.delete();
        end

        if(!m_req_fifo.is_empty()) begin
          m_req_fifo.flush();
        end

        kill_running_sequence();

        //stop_sequences();

        rnd_rst_started = 0;
        `uvm_info(`gfn, "Sequencer - out of handle the pos reset", UVM_HIGH)
    end
  endtask

endclass
