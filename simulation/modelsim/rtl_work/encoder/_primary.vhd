library verilog;
use verilog.vl_types.all;
entity encoder is
    port(
        \select\        : out    vl_logic_vector(4 downto 0);
        r0_en           : in     vl_logic;
        r1_en           : in     vl_logic;
        r2_en           : in     vl_logic;
        r3_en           : in     vl_logic;
        r4_en           : in     vl_logic;
        r5_en           : in     vl_logic;
        r6_en           : in     vl_logic;
        r7_en           : in     vl_logic;
        r8_en           : in     vl_logic;
        r9_en           : in     vl_logic;
        r10_en          : in     vl_logic;
        r11_en          : in     vl_logic;
        r12_en          : in     vl_logic;
        r13_en          : in     vl_logic;
        r14_en          : in     vl_logic;
        r15_en          : in     vl_logic;
        HI_en           : in     vl_logic;
        LO_en           : in     vl_logic;
        PC_en           : in     vl_logic;
        MDR_en          : in     vl_logic;
        InPort_en       : in     vl_logic;
        Zhigh_en        : in     vl_logic;
        Zlow_en         : in     vl_logic;
        C_en            : in     vl_logic
    );
end encoder;
