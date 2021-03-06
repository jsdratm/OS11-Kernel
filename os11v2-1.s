* **********************************************
* OS11 Kernel
*
* Original kernal written by Andrew Mischock and Jonathan Dunder 
*	for CS384 - Operating Systems [2.14.2006]
*
* Modifications made by Andrew Mischock 
*	for CS391 - Embedded System Design [3.26.2006]
* **********************************************

#include "creg.s"
#include "mem.s"

P7stack	EQU	0xD8FF
P6stack	EQU	0xD9FF
P5stack	EQU	0xDAFF
P4stack	EQU	0xDBFF
P3stack	EQU	0xDCFF
P2stack	EQU	0xDDFF
P1stack	EQU	0xDEFF
P0stack	EQU	0xDFFF
RTIVEC	EQU	0x00EB

	ORG	DATA
PROCTBL:DS.B	48
SLEEPD1:DS.B	1
SLEEPD2:DS.B	1
BUFFER:	DS.B	20
BUFFPTR:DS.B	1
CONVR:	DS.B	1
DEB:	DS.B	1
KVAR:	DS.B	1
PROCNUM:DS.B	1
PSDAT:	DC.B	"PID STATE CPUTIME AGE PRIORITY", 0x0A
WLCM:	DC.B	"WELCOME TO OS11",0x0A
PSLCD1:	DC.B	"01234567    OS11"
SHUTDOW:DC.B	"SHUTTING DOWN"
ADCT1:	DC.B	"PE =    mV  OS11"
ADCT2:	DC.B	"             ADC"
SVAR:	DS.B	1
PSLCD2:	DS.B	16
SNDTMP:	DS.B	1
DTEMP:	DS.B	2
DTEMP2:	DS.B	2
ONES:	DS.B	1
TENS:	DS.B	1
HDRDS:	DS.B	1
THSDS:	DS.B	1

* **********
* Bootstrap
* **********

	ORG	RTIVEC
	JMP	ISR

	ORG	CODE

BOOT:	LDS	#STACK			;OS Boot sequence	
	SEI	
	LDAA	PACTL
	ORAA	#%00001001		;Set PA3 to O, 8MHz XTAL (8.192ms) 
	STAA	PACTL
	LDAA	TMSK2
	ORAA	#%01000000
	STAA	TMSK2
	;LDAA	#0	
	;STAA	DDRC			; PC1 used for reset button on Fox11
	LDAA	#0x30
	STAA	BAUD
	LDAA	#0x0C
	STAA	SCCR2

INITP0:	LDS	#P0stack
	LDX	#P0
	PSHX
	CLRA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	LDY	#PROCTBL
	TSX
	STX	0,Y
	LDAA	#0
	STAA	2,Y		;sleep state (1 is sleeping)
	STAA	3,Y		;CPU time
	LDAA	#0
	STAA	4,Y		;aging
	STAA	5,Y		;priority is on the end
	
INITP1:	LDS	#P1stack
	LDX	#P1
	PSHX
	CLRA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	LDY	#PROCTBL
	TSX
	STX	6,Y
	LDAA	#0
	STAA	8,Y
	STAA	9,Y
	LDAA	#0
	STAA	10,Y
	STAA	11,Y
	
INITP2:	LDS	#P2stack
	LDX	#P2
	PSHX
	CLRA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	LDY	#PROCTBL
	TSX
	STX	12,Y
	LDAA	#0
	STAA	14,Y
	STAA	15,Y
	LDAA	#0
	STAA	16,Y
	STAA	17,Y
	
INITP3:	LDS	#P3stack
	LDX	#P3
	PSHX
	CLRA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	LDY	#PROCTBL
	TSX
	STX	18,Y
	LDAA	#0
	STAA	20,Y
	STAA	21,Y
	LDAA	#0
	STAA	22,Y
	STAA	23,Y

INITP4:	LDS	#P4stack
	LDX	#P4
	PSHX
	CLRA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	LDY	#PROCTBL
	TSX
	STX	24,Y
	LDAA	#0
	STAA	26,Y
	STAA	27,Y
	LDAA	#0
	STAA	28,Y
	STAA	29,Y

INITP5:	LDS	#P5stack
	LDX	#P5
	PSHX
	CLRA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	LDY	#PROCTBL
	TSX
	STX	30,Y
	LDAA	#0
	STAA	32,Y
	STAA	33,Y
	LDAA	#0
	STAA	34,Y
	STAA	35,Y

INITP6:	LDS	#P6stack
	LDX	#P6
	PSHX
	CLRA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	LDY	#PROCTBL
	TSX
	STX	36,Y
	LDAA	#0
	STAA	38,Y
	STAA	39,Y
	LDAA	#0
	STAA	40,Y
	STAA	41,Y

INITP7:	LDS	#P7stack
	LDX	#P7
	PSHX
	CLRA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	PSHA
	LDY	#PROCTBL
	TSX
	STX	42,Y
	LDAA	#0
	STAA	44,Y
	STAA	45,Y
	LDAA	#0
	STAA	46,Y
	STAA	47,Y

	LDAA	#0			;Initialize variables
	STAA	KVAR
	STAA	SVAR
	LDX	#OPTION
	BSET	0,X,%10000000
	LDAA	#%00000111
	STAA	ADCTL
	STAA	DDRC
	STAA	DEB
	STAA	BUFFPTR
	LDAA	#7
	STAA	PROCNUM

	JSR	LCD_INI			;Initialize the LCD
	
	LDX	#WLCM			;Intro Message to LCD
	LDAB	#15
	JSR	LCDOUT

	JSR	WSND

ENDB:	CLI				;Enable interrupts
	JMP	P7			;Start with P7

WSND:	LDAA	#30			;Welcome Sound
	LDAB	#30
	JSR	PLAYSND
	LDAA	#35
	LDAB	#28
	JSR	PLAYSND
	LDAA	#40
	LDAB	#26
	JSR	PLAYSND
	LDAA	#45
	LDAB	#24
	JSR	PLAYSND
	LDAA	#50
	LDAB	#22
	JSR	PLAYSND
	RTS

* **************************
* Interrupt Service Routine
* **************************
ISR:	LDY	#PROCTBL		;Increment process' CPU time
	LDAB	PROCNUM
	ADDB	PROCNUM
	ADDB	PROCNUM
	ADDB	PROCNUM
	ADDB	PROCNUM
	ADDB	PROCNUM
	ABY
	INC	3,Y
	TSX				;Store state of process
	STX	0,Y

ISR0:	LDAB	PROCNUM
	CMPB	#0x00
	BNE	ISR1			;Make sure process number doesn't go below 0
	LDAB	#8
ISR1:	DECB
	STAB	PROCNUM
	ADDB	PROCNUM
	ADDB	PROCNUM
	ADDB	PROCNUM
	ADDB	PROCNUM
	ADDB	PROCNUM
	LDY	#PROCTBL
	ABY
	LDAA	2,Y
	CMPA	#1			;Check if sleeping
	BEQ	ISR0
ISR2:	LDAA	4,Y
	BRCLR	4,Y,%11111111,ISR3
	DECA
	STAA	4,Y
	BRA	ISR0
ISR3:	LDAA	5,Y
	STAA	4,Y
ISR4:	LDX	0,Y			;If not sleeping, run process
	TXS
	LDAA	SVAR
	CMPA	#0xFF
	BEQ	INFL
	LDAA	#%01000000
	STAA	TFLG2
	RTI
INFL:	SEI
	BRA	INFL

* ***********
* Processes
* ***********

****************
* Sound Routine
*
PLAYSND:STAA	SNDTMP
RETSND:	LDAA	PORTA
	ORAA	#%00001000
	STAA	PORTA
	LDAA	SNDTMP
UP:	JSR	WAIT20THMS
	DECA
	CMPA	#0
	BEQ	DOWNS
	BRA	UP
DOWNS:	LDAA	PORTA
	ANDA	#%11110111
	STAA	PORTA
	LDAA	SNDTMP
DOWN:	JSR	WAIT20THMS
	DECA
	CMPA	#0
	BEQ	DOWNE
	BRA	DOWN
DOWNE:	DECB
	CMPB	#0
	BEQ	ENDSND
	BRA	RETSND
ENDSND:	RTS


************************
* P7: Serial Port Shell
*
P7:	LDX	#SCSR			
P70:	;LDAA	#0xF7
	;STAA	MOTOR
	BRSET	0,X,%00100000,P71
	BRA	P70
P71:	LDAA	SCDR
	LDX	#BUFFER
	LDAB	BUFFPTR
	ABX
	STAA	0,X
	INCB
	STAB	BUFFPTR
	LDX	#SCSR
	CMPA	#0x0D
	BEQ	P75
P72:	BRSET	0,X,%10000000,P73
	BRA	P72
P73:	STAA	SCDR
P74:	BRCLR	0,X,%01000000,P7
	BRA	P74
P75:	BRSET	0,X,%10000000,P7501
	BRA	P75
P7501:	LDAA	#0x0A
	STAA	SCDR
P76:	BRCLR	0,X,%01000000,P77
	BRA	P76
P77:	BRSET	0,X,%10000000,P770
	BRA	P77
P770:	LDAA	#0x3E
	STAA	SCDR
P78:	BRCLR	0,X,%01000000,INPT
	BRA	P78

P7B:	LDAA	#0		;Clear input buffer and return
	STAA	BUFFPTR
	BRA	P7

* Check input buffer
INPT:	LDAB	BUFFPTR
	CMPB	#3
	BEQ	INPT1
	CMPB	#5
	;BEQ	ADCF
	CMPB	#7
	;BEQ	REBOOT
	CMPB	#9
	;BEQ	SHDOWNJ
	CMPB	#10
	;BEQ	MD
	CMPB	#15
	;BEQ	MM
	BRA	P7B
INPT1:	LDX	#BUFFER
	LDAA	0,X
	CMPA	#0x70
	BEQ	PSJ
	CMPA	#0x73
	BEQ	SX1
	CMPA	#0x72
	BEQ	RX1
	BRA	P7B

* Jump Extentions
SX1:	JMP	SX		
RX1:	JMP	RX
PSJ:	JMP	PS


* Display PS
PS:	LDAB	#0
PS1:	LDX	#PSDAT
	CMPB	#31
	BEQ	PS2
	ABX
	LDAA	0,X
	JSR	SEND
	INCB
	BRA	PS1
PS2:	LDX	#PROCTBL
	LDAB	#0
	LDY	#PSLCD2
PS3:	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	STAB	CONVR		;PID
	JSR	CONV
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	2,X		;STATE
	ADDA	#0x52		;add 0x52 so: 0=>R & 1=>S
	STAA	0,Y		;store	in PSLCD2
	LDAA	2,X		;reload STATE
	STAA	CONVR
	JSR	CONV
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	3,X		;CPUTIME
	STAA	CONVR
	JSR	CONV
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	4,X		;AGE
	STAA	CONVR
	JSR	CONV
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	#0x20
	JSR	SEND
	LDAA	5,X		;PRIORITY
	STAA	CONVR
	JSR	CONV
	LDAA	#0x0A
	JSR	SEND
	INCB
	CMPB	#8
	BEQ	PSEX1
	INX
	INX
	INX
	INX
	INX
	INX
	INY
	JMP	PS3
PSEX1:	LDAA	KVAR
	CMPA	#0xF0
	BEQ	PSSD
PSEX:	JSR	LCDCLR		;PS to LCD
	LDX	#PSLCD1
	LDAB	#16
	JSR	LCDOUT		;PSLCD1
	JSR	LCDLINE2
	LDX	#PSLCD2
	LDAA	#0x20
	STAA	8,X
	STAA	9,X
	STAA	10,X
	STAA	11,X
	STAA	12,X
	STAA	13,X
	LDAA	#0x50
	STAA	14,X
	LDAA	#0x53
	STAA	15,X
	LDAB	#16
	JSR	LCDOUT		;PSLCD2
	JMP	P7B
PSSD:	LDAA	#0xFF
	STAA	SVAR
	JMP	P7B

* Sleep PX
SX:	LDX	#BUFFER	
	LDAB	1,X
	SUBB	#0x30
	LDX	#PROCTBL
	STAB	CONVR
	ADDB	CONVR
	ADDB	CONVR
	ADDB	CONVR
	ADDB	CONVR
	ADDB	CONVR
	ABX
	LDAA	#1
	STAA	2,X
	JMP	P7B

* Run PX
RX:	LDX	#BUFFER	
	LDAB	1,X
	SUBB	#0x30
	LDX	#PROCTBL
	STAB	CONVR
	ADDB	CONVR
	ADDB	CONVR
	ADDB	CONVR
	ADDB	CONVR
	ADDB	CONVR
	ABX
	LDAA	#0
	STAA	2,X
	JMP	P7B

* Sends an ASCII value
SEND:	PSHY
SEND0:	LDY	#SCSR
	BRSET	0,Y,%10000000,SEND1
	BRA	SEND0
SEND1:	STAA	SCDR
SEND2:	BRCLR	0,Y,%01000000,SEND3
	BRA	SEND2
SEND3:	PULY
	RTS

* Convert Binary to ASCII and send
CONV:	PSHY				
	LDY	#SCSR
	LDAA	CONVR
	LSRA
	LSRA
	LSRA
	LSRA
	ANDA	#%00001111
	CMPA	#9
	BLE	LT10
	ADDA	#0x61
	SUBA	#10
	BRA	CONVA
LT10:	ADDA	#0x30
CONVA:	BRSET	0,Y,%10000000,CONV0
	BRA	CONVA
CONV0:	STAA	SCDR
CONV1:	BRCLR	0,Y,%01000000,CONV2
	BRA	CONV1
CONV2:	LDAA	CONVR
	ANDA	#%00001111
	CMPA	#9
	BLE	LT102
	ADDA	#0x61
	SUBA	#10
	BRA	CONVB
LT102:	ADDA	#0x30
CONVB:	BRSET	0,Y,%10000000,CONV01
	BRA	CONVB
CONV01:	STAA	SCDR
CONV3:	BRCLR	0,Y,%01000000,CONV4
	BRA	CONV3
CONV4:	PULY
	RTS

************************
* P6
*
P6:	LDAA	#0xF6		;Dummy
	;STAA	MOTOR
	BRA	P6

P5:	LDAA	#0xF5		;Dummy
	;STAA	MOTOR
	BRA	P5

P4:	LDAA	#0xF4
	;STAA	MOTOR
	BRA	P4

P3:	LDAA	#0xF3		;Dummy
	;STAA	MOTOR
	BRA	P3

P2:	LDAA	#0xF2		;Dummy
	;STAA	MOTOR
	BRA	P2

P1:	LDAA	#0xF1		;Dummy
	;STAA	MOTOR
	BRA	P1

P0:	LDAA	#0xF0		;Dummy
	;STAA	MOTOR
	BRA	P0

* **************
* Wait Routines
*
WAIT:	PSHA			;Wait 15 ms
	TPA
	PSHA
	PSHX
	LDX	#15
WAIT1:	BSR	WAIT1MS
	DEX
	BNE	WAIT1
	PULX
	PULA
	TAP
	PULA
	RTS

WAIT1MS:PSHA			;Wait 1 ms
	TPA
	PSHA
	PSHX
	LDX	#200
WAIT1MS1:DEX
	NOP
	NOP
	BNE	WAIT1MS1
	PULX
	PULA
	TAP
	PULA
	RTS

WAIT2MS:PSHA			;Wait 2ms
	TPA
	PSHA
	PSHX
	LDX	#400
WAIT2MS1:DEX
	NOP
	NOP
	BNE	WAIT2MS1
	PULX
	PULA
	TAP
	PULA
	RTS

WAIT20THMS:PSHA			;Wait 1/20th ms
	TPA
	PSHA
	PSHX
	LDX	#10
WAIT20THMS1:DEX
	NOP
	NOP
	BNE	WAIT20THMS1
	PULX
	PULA
	TAP
	PULA
	RTS

* **************
* LCD Rountines
*
LCD_INI:;JSR	WAIT		;LCD Initialization Sequence
	;LDAA	#%00110010
	;JSR	LCDWR
	;JSR	WAIT2MS
	;JSR	WAIT2MS
	;JSR	WAIT2MS
	;LDAA	#%00110010
	;JSR	LCDWR
	;JSR	WAIT1MS
	;LDAA	#%00110010
	;JSR	LCDWR
	;JSR	WAIT1MS
	;LDAA	#%00100010
	;JSR	LCDWR
	;JSR	WAIT1MS
	;LDAA	#%00100010	;Now in 4-bit mode
	;JSR	LCDWR
	;LDAA	#%10000010
	;JSR	LCDWR
	;LDAA	#%00000010	;Display Off
	;JSR	LCDWR
	;LDAA	#%10000010
	;JSR	LCDWR
	;LDAA	#%00000010	;Return home
	;JSR	LCDWR
	;LDAA	#%00100010
	;JSR	LCDWR
	;LDAA	#%00000010	;Entry mode set
	;JSR	LCDWR
	;LDAA	#%01100010
	;JSR	LCDWR
	;LDAA	#%00000010	;turn display on
	;JSR	LCDWR
	;LDAA	#%11110010
	;JSR	LCDWR
	;JSR	LCDCLR
	RTS

LCDLINE2:;LDAA	#%11000010	;Jump to line 2
	;JSR	LCDWR
	;LDAA	#%00010010
	;JSR	LCDWR

	;LDAA	#%00010010	;Shift left
	;JSR	LCDWR
	;LDAA	#%00000010
	;JSR	LCDWR
	RTS

LCDCLR:	;LDAA	#%00000010	;Clear display
	;JSR	LCDWR
	;LDAA	#%00010010
	;JSR	LCDWR
	RTS

LCDWR:	;STAA	PORTF		;Write value in A to LCD
	;JSR	WAIT1MS
	;ANDA	#%11111101
	;STAA	PORTF
	;JSR	WAIT1MS
	RTS

LCDOUT:	;CMPB	#0		;Load address of string into X and length into B before calling
	;BEQ	LCOEX
	;LDAA	0,X
	;ANDA	#%11110000
	;ORAA	#%00000011
	;JSR	LCDWR
	;LDAA	0,X
	;LSLA
	;LSLA
	;LSLA
	;LSLA
	;ANDA	#%11110000
	;ORAA	#%00000011
	;JSR	LCDWR
	;INX
	;DECB
	;BRA	LCDOUT
LCOEX:	RTS