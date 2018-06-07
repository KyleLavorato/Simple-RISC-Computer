library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        z               : out    vl_logic_vector(63 downto 0);
        a_in            : in     vl_logic_vector(31 downto 0);
        b_in            : in     vl_logic_vector(31 downto 0);
        opcode          : in     vl_logic_vector(4 downto 0);
        incPC           : in     vl_logic
    );
end alu;
