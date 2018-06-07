library verilog;
use verilog.vl_types.all;
entity Bus32 is
    port(
        busDataOut      : out    vl_logic_vector(31 downto 0);
        BusMux_r0       : in     vl_logic_vector(31 downto 0);
        BusMux_r1       : in     vl_logic_vector(31 downto 0);
        BusMux_r2       : in     vl_logic_vector(31 downto 0);
        BusMux_r3       : in     vl_logic_vector(31 downto 0);
        BusMux_r4       : in     vl_logic_vector(31 downto 0);
        BusMux_r5       : in     vl_logic_vector(31 downto 0);
        BusMux_r6       : in     vl_logic_vector(31 downto 0);
        BusMux_r7       : in     vl_logic_vector(31 downto 0);
        BusMux_r8       : in     vl_logic_vector(31 downto 0);
        BusMux_r9       : in     vl_logic_vector(31 downto 0);
        BusMux_r10      : in     vl_logic_vector(31 downto 0);
        BusMux_r11      : in     vl_logic_vector(31 downto 0);
        BusMux_r12      : in     vl_logic_vector(31 downto 0);
        BusMux_r13      : in     vl_logic_vector(31 downto 0);
        BusMux_r14      : in     vl_logic_vector(31 downto 0);
        BusMux_r15      : in     vl_logic_vector(31 downto 0);
        BusMux_HI       : in     vl_logic_vector(31 downto 0);
        BusMux_LO       : in     vl_logic_vector(31 downto 0);
        BusMux_PC       : in     vl_logic_vector(31 downto 0);
        BusMux_MDR      : in     vl_logic_vector(31 downto 0);
        BusMux_InPort   : in     vl_logic_vector(31 downto 0);
        BusMux_Zhigh    : in     vl_logic_vector(31 downto 0);
        BusMux_Zlow     : in     vl_logic_vector(31 downto 0);
        c_sign_extended : in     vl_logic_vector(31 downto 0);
        \select\        : in     vl_logic_vector(4 downto 0)
    );
end Bus32;
