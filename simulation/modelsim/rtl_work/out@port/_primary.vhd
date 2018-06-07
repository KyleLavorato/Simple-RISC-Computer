library verilog;
use verilog.vl_types.all;
entity outPort is
    port(
        dataOut         : out    vl_logic_vector(31 downto 0);
        dataIn          : in     vl_logic_vector(31 downto 0);
        clr             : in     vl_logic;
        clk             : in     vl_logic;
        en              : in     vl_logic
    );
end outPort;
