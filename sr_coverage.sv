
class sr_coverage extends uvm_subscriber #(sr_sequence_item);

  //----------------------------------------------------------------------------
  `uvm_component_utils(sr_coverage)

  sr_sequence_item txn;
  real cov;
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  covergroup cg;
    option.per_instance= 1;
    option.comment     = "sr_cov";
    option.name        = "functional cov";
    option.auto_bin_max= 4;
    
    S:coverpoint txn.s { 
        bins s_1={1};
        bins s_0 ={0};
    }

    R:coverpoint txn.r { 
        bins r_1={1};
        bins r_0 ={0};
    }

    SXR:cross S,R;
  endgroup:cg;

  //----------------------------------------------------------------------------
   function new(string name="sr_coverage",uvm_component parent);
    super.new(name,parent);
    cg=new();
  endfunction

  //---------------------  write method ----------------------------------------
  function void write(sr_sequence_item t);
    txn=t;
    cg.sample();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=cg.get_coverage();
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_MEDIUM)
  endfunction
  //----------------------------------------------------------------------------
  
endclass:sr_coverage

