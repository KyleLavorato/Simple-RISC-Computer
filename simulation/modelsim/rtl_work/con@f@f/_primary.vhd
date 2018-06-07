library verilog;
use verilog.vl_types.all;
entity conFF is
    port(
        conOut          : out    vl_logic;
        bus_data        : in     vl_logic_vector(31 downto 0);
        IR_data         : in     vl_logic_vector(1 downto 0);
        clk             : in     vl_logic;
        conIn           : in     vl_logic
    );
end conFF;
