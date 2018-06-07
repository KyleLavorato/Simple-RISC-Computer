library verilog;
use verilog.vl_types.all;
entity ror32 is
    port(
        data            : in     vl_logic_vector(31 downto 0);
        distance        : in     vl_logic_vector(4 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end ror32;
