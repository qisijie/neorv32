`define RESET               1'b0
`define BITWIDTH            6'h20

`define INST_NOP              32'h0x00000013

`define INST_TYPE_L         7'h03
`define INST_LB             3'h0    // Load Byte
`define INST_LH             3'h1    // Load Halfword
`define INST_LW             3'h2    // Load Word
`define INST_LBU            3'h4    // Load Halfword Unsigned
`define INST_HLU            3'h5    // Load Word Unsigned


`define INST_TYPE_F         7'h0F
`define INST_FENCE          3'h0    // Synch thread
`define INST_FENCE_I        3'h1    // Synch Instr & Data

`define INST_TYPE_I         7'h13
`define INST_ADDI           3'h0    // ADD Immediate
`define INST_SLLI           3'h1    // Shift Left Immediate
`define INST_SLTI           3'h2    // Set Less Than Immediate
`define INST_SLTIU          3'h3    // Set Less Than Immediate Unsigned
`define INST_XORI           3'h4    // XOR Immediate
`define INST_SRLI_SRAI      3'h5    // Shift Right Immediate & Shift Right Arithmetic Immediate
`define INST_ORI            3'h6    // OR Immediate
`define INST_ANDI           3'h7    // AND Immediate
`define INST_SRAI_F7        7'20    // func7 of Shift Right Arithmetic Immediate

`define INST_TYPE_S         7'h23
`define INST_SB             3'h0    // Store Byte
`define INST_SH             3'h1    // Store Halfword
`define INST_SW             3'h2    // Store Word

`define INST_TYPE_R         7'h33
`define INST_ADD_SUB        3'h0    // ADD & SUBtract
`define INST_SLL            3'h1    // Shift Left 
`define INST_SLT            3'h2    // Set Less Than 
`define INST_SLTU           3'h3    // Set Less Than Unsigned
`define INST_XOR            3'h4    // XOR 
`define INST_SRL_SRA        3'h5    // Shift Right Immediate & Shift Right Arithmetic 
`define INST_OR             3'h6    // OR 
`define INST_AND            3'h7    // AND 
`define INST_SUB_F7         7'20    // func7 of SUBtract
`define INST_SRA_F7         7'20    // func7 of Shift Right Arithmetic

`define INST_TYPE_B         7'h63
`define INST_BEQ            3'h0    // Branch EQual
`define INST_BNE            3'h1    // Branch Not Equal
`define INST_BLT            3'h4    // Branch Less Than
`define INST_BGE            3'h5    // Branch Greater than or Equal
`define INST_BLTU           3'h6    // Branch Less Than Unsigned
`define INST_BGEU           3'h7    // Branch Greater than or Equal Unsigned

`define INST_TYPE_JI        7'h67
`define INST_JALR           3'h0    // Jump & Link Register

`define INST_TYPE_E         7'h0F
`define INST_ECALL          12'h0   // Environment CALL
`define INST_EBREAK         12'h1   // Environment BREAK

`define INST_TYPE_C         7'h73
`define INST_CSRRW          3'h1    // Cont./Stat.RegRead&Write
`define INST_CSRRS          3'h2    // Cont./Stat.RegRead&Set
`define INST_CSRRC          3'h3    // Cont./Stat.RegRead&Clear
`define INST_CSRRWI         3'h5    // Cont./Stat.RegRead&Write Immediate
`define INST_CSRRSI         3'h6    // Cont./Stat.RegRead&Set Immediate
`define INST_CSRRCI         3'h7    // Cont./Stat.RegRead&Clear Immediate

`define INST_JAL            7'h6F   // Jump & Link
`define INST_AUIPC          7'h17   // Add Upper Immediate to PC
`define INST_LUI            7'h37   // Load Upper Immediate