library verilog;
use verilog.vl_types.all;
entity stack32 is
    port(
        data_out        : out    vl_logic_vector(31 downto 0);
        data_in         : in     vl_logic_vector(31 downto 0);
        read            : in     vl_logic;
        write           : in     vl_logic
    );
end stack32;
