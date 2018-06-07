library verilog;
use verilog.vl_types.all;
entity mdr is
    port(
        data_out        : out    vl_logic_vector(31 downto 0);
        mem_data_in     : in     vl_logic_vector(31 downto 0);
        bus_data_in     : in     vl_logic_vector(31 downto 0);
        en              : in     vl_logic;
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        read            : in     vl_logic
    );
end mdr;
