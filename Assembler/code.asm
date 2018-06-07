ldi R3, 87
ldi R3, 1(R3)
ld R2, 66
ldi R2, -1(R2)
ldr R7, 61
str 60, R7
ld R1, 0(R2)
ldi R0, 1
nop
add R3, R2, R3
addi R7, R7, 2
neg R7, R7
not R7, R7
andi R7, R7, 15
ori R7, R1, 3
shr R2, R3, R0
st 56, R2
ror R1, R1, R0
rol R2, R2, R0
or R2, R3, R0
and R1, R2, R1
st 76(R1), R3
sub R3, R2, R3
shl R1, R2, R0
ldi R4, 5
ldi R5, 31
mul R5, R4
mfhi R7
mflo R6
div R5, R4
ldi R10, 0(R4)
ldi R11, 0(R5)
ldi R12, 0(R6)
ldi R13, 0(R7)
jal R12
ststk R4
ststk R8
ldstk R8
ldstk R4
halt