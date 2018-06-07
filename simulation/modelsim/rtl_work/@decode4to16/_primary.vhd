library verilog;
use verilog.vl_types.all;
entity Decode4to16 is
    port(
        data            : in     vl_logic_vector(3 downto 0);
        eq0             : out    vl_logic;
        eq1             : out    vl_logic;
        eq10            : out    vl_logic;
        eq11            : out    vl_logic;
        eq12            : out    vl_logic;
        eq13            : out    vl_logic;
        eq14            : out    vl_logic;
        eq15            : out    vl_logic;
        eq2             : out    vl_logic;
        eq3             : out    vl_logic;
        eq4             : out    vl_logic;
        eq5             : out    vl_logic;
        eq6             : out    vl_logic;
        eq7             : out    vl_logic;
        eq8             : out    vl_logic;
        eq9             : out    vl_logic
    );
end Decode4to16;
