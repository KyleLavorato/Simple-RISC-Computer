library verilog;
use verilog.vl_types.all;
entity conFFCompare is
    port(
        dataa           : in     vl_logic_vector(31 downto 0);
        aeb             : out    vl_logic;
        ageb            : out    vl_logic;
        alb             : out    vl_logic;
        aneb            : out    vl_logic
    );
end conFFCompare;
