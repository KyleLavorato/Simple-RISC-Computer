library verilog;
use verilog.vl_types.all;
entity computer is
    port(
        clkOut          : out    vl_logic;
        conFF_Out       : out    vl_logic;
        MAR_test        : out    vl_logic_vector(31 downto 0);
        MDR_test        : out    vl_logic_vector(31 downto 0);
        outPort_test    : out    vl_logic_vector(31 downto 0);
        cSign_test      : out    vl_logic_vector(31 downto 0);
        r0_test         : out    vl_logic_vector(31 downto 0);
        r1_test         : out    vl_logic_vector(31 downto 0);
        r2_test         : out    vl_logic_vector(31 downto 0);
        r3_test         : out    vl_logic_vector(31 downto 0);
        r4_test         : out    vl_logic_vector(31 downto 0);
        r5_test         : out    vl_logic_vector(31 downto 0);
        r6_test         : out    vl_logic_vector(31 downto 0);
        r7_test         : out    vl_logic_vector(31 downto 0);
        r8_test         : out    vl_logic_vector(31 downto 0);
        r9_test         : out    vl_logic_vector(31 downto 0);
        r10_test        : out    vl_logic_vector(31 downto 0);
        r11_test        : out    vl_logic_vector(31 downto 0);
        r12_test        : out    vl_logic_vector(31 downto 0);
        r13_test        : out    vl_logic_vector(31 downto 0);
        r14_test        : out    vl_logic_vector(31 downto 0);
        SP_test         : out    vl_logic_vector(31 downto 0);
        HI_test         : out    vl_logic_vector(31 downto 0);
        LO_test         : out    vl_logic_vector(31 downto 0);
        PC_test         : out    vl_logic_vector(31 downto 0);
        Zhigh_test      : out    vl_logic_vector(31 downto 0);
        Zlow_test       : out    vl_logic_vector(31 downto 0);
        Y_test          : out    vl_logic_vector(31 downto 0);
        IR_test         : out    vl_logic_vector(31 downto 0);
        busDataOut      : out    vl_logic_vector(31 downto 0);
        stateOut        : out    vl_logic_vector(5 downto 0);
        reset           : in     vl_logic;
        InPort_dataIn   : in     vl_logic_vector(31 downto 0)
    );
end computer;
