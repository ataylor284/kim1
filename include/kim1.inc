; -----------------------------------------------------------------------------
; zero page addresses

PCL    := $EF                   ; monitor register storage
PCH    := $F0
PREG   := $F1
SPUSER := $F2
ACC    := $F3
YREG   := $F4
XREG   := $F5

CHKHI  := $F6                   ; CHKSUM: checksum for load/save operations
CHKSUM := $F7
INL    := $F8                   ; IN: input buffer
INH    := $F9
POINTL := $FA                   ; POINT: pointer to "open cell"
POINTH := $FB
TEMP   := $FC
TMPX   := $FD
CHAR   := $FE
MODE   := $FF

; -----------------------------------------------------------------------------
; RAM addresses

APPRAM := $1780                 ; start of application RAM spanning 6530-003, 6530-002 RAM
KIMRAM := $17E7                 ; start of kim  RAM on 6530-002
SAL    := $17F5                 ; SA: starting address of program (nb: DUMP uses POINT, not SA)
SAH    := $17F6
EAL    := $17F7                 ; EA: ending address of program
EAH    := $17F8
NMIL   := $17FA                 ; NMI vector
NMIH   := $17FB
RSTL   := $17FC                 ; RESET vector
RSTH   := $17FD
IRQL   := $17FE                 ; IRQ vector
IRQH   := $17FF

; -----------------------------------------------------------------------------
; ROM addresses

LOAD   := $1CE7                 ; load from paper tape
DUMP   := $1D42                 ; dump to paper tape format, memory from POINT to EA
PRTBYT := $1E3B                 ; print value in A as two hex digits to TTY
GETCH  := $1E5A                 ; get one character from TTY, return in A
OUTSP  := $1E9E                 ; print space character to TTY
OUTCH  := $1EA0                 ; print character in A to TTY
SCAND  := $1F19                 ; load *POINT into INH, display POINT:INH on 7-segment display
SCANDS := $1F1F                 ; display POINT:INH on 7-segment display
INCPT  := $1F63                 ; increment POINT
GETBYT := $1F9D                 ; get two hex digits from TTY, decode into INL and A

NMIENT := $1FFA                 ; actual 6502 NMI address (vectored through NMIL/NMIH in RAM)
RSTENT := $1FFC                 ; actual 6502 RST address (vectored through RSTL/RSTH in RAM)
IRQENT := $1FFE                 ; actual 6502 IRQ address (vectored through IRQL/IRQH in RAM)

; -----------------------------------------------------------------------------
; I/O addresses

SAD    := $1740                 ; 6530-002 a data
PADD   := $1741                 ; 6530-002 a data direction
SBD    := $1742                 ; 6530-002 b data
PBDD   := $1743                 ; 6530-002 b data direction
CLK1T  := $1744                 ; 6530-002 div by 1 time
CLK8T  := $1745                 ; 6530-002 div by 8 time
CLK64T := $1746                 ; 6530-002 div by 64 time
CLKKT  := $1747                 ; 6530-002 div by 1024 time
CLKRDI := $1747                 ; 6530-002 read time out bit
CLKRDT := $1746                 ; 6530-002 read time              
