library verilog;
use verilog.vl_types.all;
entity reg64 is
    port(
        HI              : out    vl_logic_vector(31 downto 0);
        LO              : out    vl_logic_vector(31 downto 0);
        data_in         : in     vl_logic_vector(63 downto 0);
        en              : in     vl_logic;
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        LO_en           : in     vl_logic;
        HI_en           : in     vl_logic
    );
end reg64;
