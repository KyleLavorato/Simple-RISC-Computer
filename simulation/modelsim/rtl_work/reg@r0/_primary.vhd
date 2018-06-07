library verilog;
use verilog.vl_types.all;
entity regR0 is
    port(
        q               : out    vl_logic_vector(31 downto 0);
        d               : in     vl_logic_vector(31 downto 0);
        en              : in     vl_logic;
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        BAout           : in     vl_logic
    );
end regR0;
