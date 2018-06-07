import shlex, sys

# Table to reference command name to opcode
opcode_table = {
    "ld" : "00000",
    "ldi" : "00001",
    "st" : "00010",
    "ldr" : "ERROR",
    "str" : "ERROR",
    "add" : "00011",
    "sub" : "00100",
    "and" : "00101",
    "or" : "00110",
    "shr" : "00111",
	"shra" : "01000",
    "shl" : "01001",
    "ror" : "01010",
    "rol" : "01011",
    "addi" : "01100",
    "andi" : "01101",
    "ori" : "01110",
    "mul" : "01111",
    "div" : "10000",
    "neg" : "10001",
    "not" : "10010",
    "brzr" : "10011",
    "brnz" : "10011",
    "brmi" : "10011",
    "brpl" : "10011",
    "jr" : "10100",
    "jal" : "10101",
    "in" : "10110",
    "out" : "10111",
    "mfhi" : "11000",
    "mflo" : "11001",
    "nop" : "11010",
    "halt" : "11011",
}

# IR[22:19] for branch instructions with sign extend bit
branch = {
    "brzr" : "0000",
    "brnz" : "0001",
    "brpl" : "0010",
    "brmi" : "0011"
}

# Table to reference register name to ID bitstring
reg_table = {
    "r0" : "0000",
    "r1" : "0001",
    "r2" : "0010",
    "r3" : "0011",
    "r4" : "0100",
    "r5" : "0101",
    "r6" : "0110",
    "r7" : "0111",
    "r8" : "1000",
    "r9" : "1001",
    "r10" : "1010",
    "r11" : "1011",
    "r12" : "1100",
    "r13" : "1101",
    "r14" : "1110",
    "r15" : "1111"
}


def parse_instream(txt):
    """Parse the current instruction by stripping unecessary
    characters and separating C + RX notation into two elements"""
    seq = []  # Container to hold parsed instruction
    for i in range(0, len(txt)):
        s = txt.pop(0).replace(",", "").lower()  # Strip commas and make lowercase for detection
        if s[-1] == ")":  # Strip constant(reg) notation into two parts
            start = s.find("(")
            end = s.find(")")
            a = s[:start]
            b = s[start + 1:end]
            seq.append(a)
            seq.append(b)
        else:
            seq.append(s)
    return seq


def twos_comp(val, bits=8):
    """Compute the 2's compliment of int value val in 8 bit form"""
    if (val & (1 << (bits - 1))) != 0:  # If sign bit is set
        val -= (1 << bits)  # Compute negative value
    return val


def binary(x):
    """Convert int x into a bitstring"""
    if x[0] == "-":  # Negative number
        num = '{0:08b}'.format(int(x[1:]))  # Convert to binary and strip '-' sign
        num = bin(int(''.join('1' if x == '0' else '0' for x in num), 2) + 1)[2:]  # Do a 2's compliment
    else:
        num = '{0:08b}'.format(int(x))  # Positive number; Convert to binary
    return num


def c_sign_extend(ir, c):
    """Sign extend constant c and add to instruction ir so far
    giving a 32 bit instruction"""
    size = len(ir) - ir.count("_")  # Total bits used so far
    extend = 32 - size - len(c)  # How many times to extend
    c_sign = extend * c[0] + c
    code = ir + c_sign
    return code


def parse_instruction(txt):
    """Accept an instruction, txt in list form and parse
    it into a 32 bit string IR code"""
    ir = ""  # String to hold the instruction
    c_immediate = "0"  # Default constant of 0 if no replacement is found

    opcode = txt.pop(0)  # Remove opcode from list to parse
    if opcode in opcode_table:
        if opcode == "jal":  # jal has a custom r15 for rb
            element = txt.pop(0)
            ir = opcode_table[opcode] + "_" + reg_table[element] + "_" + "1111_0000000000000000100" # R15_4
        else:  # General case
            ir += opcode_table[opcode] + "_"  # Add opcode to the instruction
            for i in range(0, len(txt)):  # Parse remaining elements
                element = txt.pop(0)
                if element[0] == "r":  # Check for register (rX)
                    ir += reg_table[element] + "_"  # Add register to the instruction
                elif element[0].isdigit() or element[0] == "-":  # Check for positive or negative immediate
                    c_immediate = binary(element)
            if opcode in branch:  # Add C2 as if it was a register for branches
                ir += branch[opcode] + "_" # Set branch immediate from branch type
            if opcode == "st" and len(ir) > 11:  # Store has rb first in instruction so swap when using both reg
                rb = ir[6:10]
                ra = ir[11:15]
                ir = ir[:6] + ra + ir[10] + rb + ir[15:]
            ir = c_sign_extend(ir, c_immediate)  # Add immediate when all registers are parsed
    else:
        sys.exit("ERROR: Unknown instruction found; Aborting")
    return ir


## MAINLINE ##

bitstring = True  # True for bitstring output; False for verilog output

print("Parsing Begin\n...")
instructions = []
with open("../../code.asm", "r") as f:
    for line in f:
        txt = parse_instream(shlex.split(str.strip(line)))
        instructions.append(parse_instruction(txt))
print("Parsing Complete\n...")

with open("../../assembled.asm", "w") as f:
    i = 0
    for code in instructions:
        if bitstring:
            output = code + "\n"
        else:
            output = "ram[" + str(i) + "] <= 32'b" + code + ";\n"
            i += 1
        f.write(output)
print("Output Available in 'assembled.asm'")
