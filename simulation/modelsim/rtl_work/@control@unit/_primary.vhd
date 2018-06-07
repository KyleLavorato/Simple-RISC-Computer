library verilog;
use verilog.vl_types.all;
entity ControlUnit is
    generic(
        fetch0          : integer := 0;
        fetch1          : integer := 1;
        fetch2          : integer := 2;
        add3            : integer := 3;
        add4            : integer := 4;
        add5            : integer := 5;
        addi4           : integer := 6;
        mul3            : integer := 7;
        mul4            : integer := 8;
        mul5            : integer := 9;
        mul6            : integer := 10;
        neg3            : integer := 11;
        neg4            : integer := 12;
        neg5            : integer := 13;
        ld3             : integer := 14;
        ld4             : integer := 15;
        ld5             : integer := 16;
        ld6             : integer := 17;
        ld7             : integer := 18;
        ldi5            : integer := 19;
        ldr3            : integer := 20;
        ldr4            : integer := 21;
        ldr5            : integer := 22;
        ldr6            : integer := 23;
        ldr7            : integer := 24;
        st6             : integer := 25;
        st7             : integer := 26;
        br3             : integer := 27;
        br4             : integer := 28;
        jp3             : integer := 29;
        jal3            : integer := 30;
        jal4            : integer := 31;
        jal5            : integer := 32;
        mfhi3           : integer := 33;
        mflo3           : integer := 34;
        out3            : integer := 35;
        in3             : integer := 36;
        nop3            : integer := 37;
        halt3           : integer := 38;
        inc3            : integer := 39;
        inc4            : integer := 40;
        ldstk3          : integer := 41;
        ldstk4          : integer := 42;
        ststk3          : integer := 43;
        ststk4          : integer := 44;
        end_state       : vl_logic_vector(0 to 6) := (Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0);
        reset_state     : vl_logic_vector(0 to 6) := (Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        Rin             : out    vl_logic;
        Rout            : out    vl_logic;
        Gra             : out    vl_logic;
        Grb             : out    vl_logic;
        Grc             : out    vl_logic;
        HIin            : out    vl_logic;
        LOin            : out    vl_logic;
        CONin           : out    vl_logic;
        PCin            : out    vl_logic;
        IRin            : out    vl_logic;
        Yin             : out    vl_logic;
        Zin             : out    vl_logic;
        MARin           : out    vl_logic;
        MDRin           : out    vl_logic;
        OutPortin       : out    vl_logic;
        Cout            : out    vl_logic;
        InPortout       : out    vl_logic;
        BAout           : out    vl_logic;
        PCout           : out    vl_logic;
        MDRout          : out    vl_logic;
        Zhighout        : out    vl_logic;
        Zlowout         : out    vl_logic;
        HIout           : out    vl_logic;
        LOout           : out    vl_logic;
        incPC           : out    vl_logic;
        opcode_data     : out    vl_logic_vector(4 downto 0);
        read            : out    vl_logic;
        write           : out    vl_logic;
        sread           : out    vl_logic;
        swrite          : out    vl_logic;
        run             : out    vl_logic;
        clr             : out    vl_logic;
        stateOut        : out    vl_logic_vector(5 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        stop            : in     vl_logic;
        conFF           : in     vl_logic;
        IR              : in     vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of fetch0 : constant is 1;
    attribute mti_svvh_generic_type of fetch1 : constant is 1;
    attribute mti_svvh_generic_type of fetch2 : constant is 1;
    attribute mti_svvh_generic_type of add3 : constant is 1;
    attribute mti_svvh_generic_type of add4 : constant is 1;
    attribute mti_svvh_generic_type of add5 : constant is 1;
    attribute mti_svvh_generic_type of addi4 : constant is 1;
    attribute mti_svvh_generic_type of mul3 : constant is 1;
    attribute mti_svvh_generic_type of mul4 : constant is 1;
    attribute mti_svvh_generic_type of mul5 : constant is 1;
    attribute mti_svvh_generic_type of mul6 : constant is 1;
    attribute mti_svvh_generic_type of neg3 : constant is 1;
    attribute mti_svvh_generic_type of neg4 : constant is 1;
    attribute mti_svvh_generic_type of neg5 : constant is 1;
    attribute mti_svvh_generic_type of ld3 : constant is 1;
    attribute mti_svvh_generic_type of ld4 : constant is 1;
    attribute mti_svvh_generic_type of ld5 : constant is 1;
    attribute mti_svvh_generic_type of ld6 : constant is 1;
    attribute mti_svvh_generic_type of ld7 : constant is 1;
    attribute mti_svvh_generic_type of ldi5 : constant is 1;
    attribute mti_svvh_generic_type of ldr3 : constant is 1;
    attribute mti_svvh_generic_type of ldr4 : constant is 1;
    attribute mti_svvh_generic_type of ldr5 : constant is 1;
    attribute mti_svvh_generic_type of ldr6 : constant is 1;
    attribute mti_svvh_generic_type of ldr7 : constant is 1;
    attribute mti_svvh_generic_type of st6 : constant is 1;
    attribute mti_svvh_generic_type of st7 : constant is 1;
    attribute mti_svvh_generic_type of br3 : constant is 1;
    attribute mti_svvh_generic_type of br4 : constant is 1;
    attribute mti_svvh_generic_type of jp3 : constant is 1;
    attribute mti_svvh_generic_type of jal3 : constant is 1;
    attribute mti_svvh_generic_type of jal4 : constant is 1;
    attribute mti_svvh_generic_type of jal5 : constant is 1;
    attribute mti_svvh_generic_type of mfhi3 : constant is 1;
    attribute mti_svvh_generic_type of mflo3 : constant is 1;
    attribute mti_svvh_generic_type of out3 : constant is 1;
    attribute mti_svvh_generic_type of in3 : constant is 1;
    attribute mti_svvh_generic_type of nop3 : constant is 1;
    attribute mti_svvh_generic_type of halt3 : constant is 1;
    attribute mti_svvh_generic_type of inc3 : constant is 1;
    attribute mti_svvh_generic_type of inc4 : constant is 1;
    attribute mti_svvh_generic_type of ldstk3 : constant is 1;
    attribute mti_svvh_generic_type of ldstk4 : constant is 1;
    attribute mti_svvh_generic_type of ststk3 : constant is 1;
    attribute mti_svvh_generic_type of ststk4 : constant is 1;
    attribute mti_svvh_generic_type of end_state : constant is 1;
    attribute mti_svvh_generic_type of reset_state : constant is 1;
end ControlUnit;