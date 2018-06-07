library verilog;
use verilog.vl_types.all;
entity neg32 is
    port(
        \out\           : out    vl_logic_vector(31 downto 0);
        in_a            : in     vl_logic_vector(31 downto 0)
    );
end neg32;
