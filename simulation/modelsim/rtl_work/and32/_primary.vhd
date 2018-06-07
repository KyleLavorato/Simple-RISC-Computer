library verilog;
use verilog.vl_types.all;
entity and32 is
    port(
        \out\           : out    vl_logic_vector(31 downto 0);
        in_a            : in     vl_logic_vector(31 downto 0);
        in_b            : in     vl_logic_vector(31 downto 0)
    );
end and32;
