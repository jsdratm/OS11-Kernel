* *****************************************************************
* * FILENAME:	creg.s                                            *
* * AUTHOR:     meier@msoe.edu <Dr. M.>                           *
* * PROVIDES:   number equates for each MC68HC11 control register *
* * DATE:       7 Dec 2005                                        *
* * PROJECT:    OS11                                              *
* *****************************************************************

PORTA		EQU	$1000
PIOC		EQU	$1002
PORTCL	EQU	$1005
DDRC		EQU	$1007
PORTD		EQU	$1008
DDRD		EQU	$1009
PORTE		EQU	$100A
CFORC		EQU	$100B
OC1M		EQU	$100C
OC1D		EQU	$100D
TCNTH		EQU	$100E
TCNTL		EQU	$100F
TIC1H		EQU	$1010
TIC1L		EQU	$1011
TIC2H		EQU	$1012
TIC2L		EQU	$1013
TIC3H		EQU	$1014
TIC3L		EQU	$1015
TOC1H		EQU	$1016
TOC1L		EQU	$1017
TOC2H		EQU	$1018
TOC2L		EQU	$1019
TOC3H		EQU	$101A
TOC3L		EQU	$101B
TOC4H		EQU	$101C
TOC4L		EQU	$101D
TI4O5H	EQU	$101E
TI4O5L	EQU	$101F
TCTL1		EQU	$1020
TCTL2		EQU	$1021
TMSK1		EQU	$1022
TFLG1		EQU	$1023
TMSK2		EQU	$1024
TFLG2		EQU	$1025
PACTL		EQU	$1026
PACNT		EQU	$1027
SPCR		EQU	$1028
SPSR		EQU	$1029
SPDR		EQU	$102A
BAUD		EQU	$102B
SCCR1		EQU	$102C
SCCR2		EQU	$102D
SCSR		EQU	$102E
SCDR		EQU	$102F
ADCTL		EQU	$1030
ADR1		EQU	$1031
ADR2		EQU	$1032
ADR3		EQU	$1033
ADR4		EQU	$1034
BPROT		EQU	$1035
EPROG		EQU	$1036
OPTION	EQU	$1039
COPRST	EQU	$103A
PPROG		EQU	$103B
HPRIO		EQU	$103C
INIT		EQU	$103D
CONFIG	EQU	$103F

* FOX11 BOARD OPERATES IN EXPANDED MODE 
*   - MC68HC11 PORTB AND PORTC PINS UNAVAILABLE IN EXPANDED MODE
*   - FOX11 BOARD PROVIDES REPLACEMENTS FOR PORTC AND PORTB
*   - FOX11 BOARD ADDS A MEMORY-MAPPED PORTF FOR LCD CONTROL  

PORTF		EQU	$1401		; LCD CONTROL
PORTC		EQU	$1403		; DIP SWITCH INPUT
PORTB		EQU	$7000		; LED OUTPUT