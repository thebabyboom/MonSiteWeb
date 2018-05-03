;***************************************************************************
;* project         : MAHPONG 	                                           *
;*-------------------------------------------------------------------------*
;* program         : mainfile AVR firmware				   *
;***************************************************************************
;* file            : MAHPONG.asm                              		   *
;* version         : 1.0a                                                  *
;*-------------------------------------------------------------------------*
;* original Date   : 02.12.23    Author: M. Hasenstab JK(consultant)	   *
;*                 :                     marcus.hasenstab@jkdesign.de      *
;*-------------------------------------------------------------------------*
;* last change     : 03.05.14    Author: MAH		                   *
;***************************************************************************
;* destination HW  : 8515 plus 2bitvideo DAC	                           *
;* destination SW  : 						           *
;* assembler       : wavrasm					           *
;* language        : assembler for AVR		                           *
;***************************************************************************
;*                      COPYRIGHT (c)  				           *
;***************************************************************************
;*
;*
;*
;* PINOUT AVR AT90S8515 PDIP
;*
;* Nr	Port	Port2	Prog	Dir	Pull	Usage
;*
;* 1	PB0	T0	-	O	Y	free
;* 2	PB1	T1	-	O	Y	free
;* 3	PB2	AIN0	-	O	Y	free
;* 4	PB3	AIN1	-	O	Y	free
;* 5	PB4	#SS	-	O	N	free
;* 6	PB5	-	MOSI	O	N	free
;* 7 	PB6	-	MISO	O	N	free
;* 8	PB7	-	SCK	O	N	free
;* 9	/Reset	-	/Reset	-	-	-
;* 10	PD0	RXD	-	I	N	free
;* 11	PD1	TXD	-	O	N	free
;* 12	PD2	INT0	-	I	N	free
;* 13	PD3	INT1	-	O	N	free
;* 14	PD4	-	-	O	N	SyncOut
;* 15	PD5	OC1A	-	O	N	SoundOut
;* 16	PD6	#WR	-	O	N	free
;* 17	PD7	#RD	-	O	N	free
;* 18	XTAL1	-	-	-	-	-
;* 19	XTAL2	-	-	-	-	-
;* 20	GND	-	-	-	-	-	
;* 21	PC0	A8	-	I	-	free
;* 22	PC1	A9	-	I	-	free
;* 23	PC2	A10	-	I	-	free
;* 24	PC3	A11	-	I	-	Pixel less bright
;* 25	PC4	A12	-	I	-	free
;* 26	PC5	A13	-	I	-	free
;* 27	PC6	A14	-	I	-	free
;* 28	PC7	A15	-	I	-	Pixel bright
;* 29	OC1B	-	-	O	-	free
;* 30	ALE	-	-	O	-	free
;* 31	ICP	-	-	I	-	free
;* 32	PA7	AD7	-	I	-	Joystick Input	up1
;* 33	PA6	AD6	-	I	-	Joystick Input	down1
;* 34	PA5	AD5	-	I	-	Joystick Input	left1
;* 35	PA4	AD4	-	I	-	Joystick Input	right1
;* 36	PA3	AD3	-	I	-	Joystick Input	up2
;* 37	PA2	AD2	-	I	-	Joystick Input	down2
;* 38	PA1	AD1	-	I	-	Joystick Input	left2
;* 39	PA0	AD0	-	I	-	Joystick Input	right2
;* 40	VCC	-	-	-	-      -
;*
;***************************************************************************
;***************************************************************************/
;*
;*
;*
;* Register usage AVR AT90S8515
;*
			;* Hex	Nr	Com		
			;*
.def	LPMREG	= r0	;* 0	0		
			;* 1	1		
.def	ZEROREG = r2	;* 2	2
.def	SREG_SV = r3	;* 3	3	
.def	TICKL = r4	;* 4	4	vsync tick counter
			;* 5	5		
			;* 6	6	
			;* 7	7	
.def	LREG1 = r8	;* 8	8		
.def	LREG2 = r9	;* 9	9	
.def	LREG3 = r10	;* A	10		
.def	LREG4 = r11	;* B	11
.def	LREG5 = r12	;* C	12		
.def	LREG6 = r13	;* D	13
			;* E	14
			;* F	15		
.def	TMP_I  = r16	;* 10	16	LDI	Interrupt temp register
.def	TMPL_I = r17	;* 11	17	LDI
.def	TMPH_I = r18	;* 12	18	LDI
.def	TMP 	= r19	;* 13	19	LDI	temp register
.def	TMPL 	= r20	;* 14	20	LDI
.def	TMPH 	= r21	;* 15	21	LDI
.def	VREG1	= r22	;* 16	22	LDI     
.def	VREG2	= r23	;* 17	23	LDI
.def	HCOUNT	= r24	;* 18 	24	LDI	horizontal byte counter
.def	FLAG_I = r25	;* 19	25	LDI	Flag register for interrupt handler
			;			0: 
			;			1: 
			;			2: 
			;			3: 
			;			
			;			
			;			6: BAT 2D Flag
			;			7: VSYNC flag, set by isr, cleared by playpong
.def	VRPOINTL = r26	;* 1A	26	XL      LineCounter/VideoRAM pointer
.def	VRPOINTH = r27	;* 1B	27	XH
.def	DRPOINTL = r28	;* 1C	28	YL	
.def	DRPOINTH = r29	;* 1D	29	YH
			;* 1E	30	ZL     	
			;* 1F	31	ZH
;*
;***************************************************************************

; ******* includes *********************************************************
.include "8515def.inc"
; ******* End of includes **************************************************

; ******* Defines **********************************************************

.equ	PIXELPORT	= PORTC
.equ	PIXELPINL	= 3
.equ	PIXELPINH 	= 7

.equ	SYNCPORT	= PORTD
.equ	SYNCPIN 	= 4
.equ	TESTPIN		= 0

.equ	HSHIFT		= 8		; sets horizontal picture shift

;* 32	PA7	AD7	-	I	-	Joystick Input	up1
;* 33	PA6	AD6	-	I	-	Joystick Input	down1
;* 34	PA5	AD5	-	I	-	Joystick Input	left1
;* 35	PA4	AD4	-	I	-	Joystick Input	right1
;* 36	PA3	AD3	-	I	-	Joystick Input	up2
;* 37	PA2	AD2	-	I	-	Joystick Input	down2
;* 38	PA1	AD1	-	I	-	Joystick Input	left2
;* 39	PA0	AD0	-	I	-	Joystick Input	right2

.equ	PADDLEPIN	= PINA
.equ	PADDLE1UP	= 7
.equ	PADDLE1DOWN	= 6
.equ	PADDLE1LEFT	= 5
.equ	PADDLE1RIGHT	= 4
.equ	PADDLE2UP	= 3
.equ	PADDLE2DOWN	= 2
.equ	PADDLE2LEFT	= 1
.equ	PADDLE2RIGHT	= 0

.equ	SPEED_SOCCER	= 1
.equ	SPEED_TENNIS	= 3
.equ	GOAL1X	= 0
.equ	GOAL2X	= 39
.equ	SCOREWIN =21

.equ	BATX1	= 3;
.equ	BATX2	= 40-4;
.equ	BATYMIN	= 0+3;
.equ	BATYMAX	= 29-4;
.equ	BATXMIN	= 0+3;
.equ	BATXMAX	= 40-4;


; **** Sound definitions **************************************************
.equ	fREF	= 50000000	; 8MHz at prescaler 8
; offset into tone table
.equ	tC1	= 0	;	(fREF/26163)
.equ	tCIS1	= 1	;	(fREF/27718)
.equ	tDES1	= 2	;	(fREF/27718)
.equ	tD1	= 3	;	(fREF/29367)
.equ	tDIS1	= 4	;	(fREF/31113)
.equ	tES1	= 5	;	(fREF/31113)
.equ	tE1	= 6	;	(fREF/32963)
.equ	tF1	= 7	;	(fREF/34923)
.equ	tFIS1	= 8	;	(fREF/36999)
.equ	tGES1	= 9	;	(fREF/36999)
.equ	tG1	= 10	;	(fREF/39200)
.equ	tGIS1	= 11	;	(fREF/41530)
.equ	tAS1	= 12	;	(fREF/41530)
.equ	tA1	= 13	;	(fREF/44000)
.equ	tAIS1	= 14	;	(fREF/46616)
.equ	tB1	= 15	;	(fREF/46616)
.equ	tH1	= 16	;	(fREF/49388)
.equ	tC2	= 17	;	(fREF/52325)
.equ	tPAUSE 	= 18	; 	0xFFFF		; no tone!

.equ	tC0	= 19	;	one octave below c-dur
.equ	tCIS0	= 20	;	
.equ	tDES0	= 21	;	
.equ	tD0	= 22	;	
.equ	tDIS0	= 23	;	
.equ	tES0	= 24	;	
.equ	tE0	= 25	;	
.equ	tF0	= 26	;	
.equ	tFIS0	= 27	;	
.equ	tGES0	= 28	;	
.equ	tG0	= 29	;	
.equ	tGIS0	= 30	;	
.equ	tAS0	= 31	;	
.equ	tA0	= 32	;	
.equ	tAIS0	= 33	;	
.equ	tB0	= 34	;	
.equ	tCES1	= 35	;	

;duration factor
.equ	dREF	= 4

; tone duration table
.equ	d1	= 32*dREF
.equ	d2p	= 24*dREF
.equ	d2	= 16*dREF
.equ	d4p	= 12*dREF
.equ	d4	=  8*dREF
.equ	d8p	=  6*dREF
.equ	d8	=  4*dREF
.equ	d16p	=  3*dREF
.equ	d16	=  2*dREF
.equ	d32	=  1*dREF

; **** END Sound definitions **********************************************

; ******* End of Defines ***************************************************

; ******* SRAM **********************************************************

; RAMSTART 	= 0x60
.equ VIDEOBASE	= 0x60
; VIDEOTOP	= 0x1C7		0x60 + 0x7D (360Bytes 96x30)


.equ BALL_X	= 0x200
.equ BALL_Y	= 0x201
.equ BALLSPEED_X =0x202
.equ BALLSPEED_Y =0x203

.equ BAT1_Y	= 0x210
.equ BAT2_Y	= 0x211
.equ BAT1_X	= 0x212
.equ BAT2_X	= 0x213

.equ SCORE1	= 0x214
.equ SCORE2	= 0x215

.equ SOUNDSOURCEL = 0x218	; must follow each other
.equ SOUNDSOURCEH = 0x219
.equ SOUNDDURATION = 0x21A

; STACKSTART	= 0x25F
; RAMEND 	= 0x25F


; ******* End of SRAM ***************************************************


; ******* Macros ***********************************************************
; ******* End of Macros ****************************************************



;****************************************************************************
;*
;* interrupt vector table
;*
;****************************************************************************
; first operation
.CSEG
.ORG	0x00
	rjmp	RESET		; Reset Handler
.ORG INT0addr
	rjmp	EXT_INT0	; IRQ0 Handler 	
.ORG INT1addr
	rjmp	EXT_INT1	; IRQ1 Handler
.ORG ICP1addr
	rjmp	TIM1_CAPT	; Timer 1 Capture Handler
.ORG OC1Aaddr
	rjmp	TIM1_COMPA	; Timer 1 Compare A Handler
.ORG OC1Baddr
	rjmp	TIM1_COMPB	; Timer 1 Compare B Handler
.ORG OVF1addr
	rjmp	TIM1_OVF	; Timer 1 Overflow Handler
.ORG OVF0addr
	rjmp	TIM0_OVF	; Timer 0 Overflow Handler
.ORG SPIaddr
	rjmp	SPI_STC		; SPI transfer complete handler
.ORG URXCaddr
	rjmp	UART_RXC	; UART RX Complete Handler
.ORG UDREaddr
	rjmp	UART_DRE	; UART UDR Empty Handler
.ORG UTXCaddr
	rjmp	UART_TXC	; UART TX Complete Handler
.ORG ACIaddr
	rjmp	ANA_COMP	; Analog Comparator Handler	


EXT_INT0:	; IRQ0 Handler 	
EXT_INT1:	; IRQ1 Handler
TIM1_CAPT:	; Timer 1 Capture Handler
TIM1_OVF:	; Timer 1 Overflow Handler
TIM1_COMPB:	; Timer 1 Compare B Handler
SPI_STC:	; SPI transfer complete handler
UART_RXC:	; UART RX Complete Handler
UART_DRE:	; UART UDR Empty Handler
UART_TXC:	; UART TX Complete Handler
ANA_COMP:	; Analog Comparator Handler	
TIM1_COMPA:	; Timer 1 Compare A Handler						; 4
	reti	; DEFAULT HANDLER !!!


; the T1 compare interrupt handles the video output
TIM0_OVF:	; Timer 0 Overflow Handler
	in	SREG_SV, SREG			; 6 to get here, plus 2 for in

TIM0_OVF_SYNC:
	cbi	SYNCPORT, SYNCPIN		; 2 here starts the 4.8탎 sync pulse = 38,4cyc

SELECT_HALFPIC:
	ldi	TMP_I,   high(313)		;  delay time is only 38 cycles, therefore 
	cpi	VRPOINTL, low(313)		;   the select list mustn't take longer than ~30cycles
	cpc	VRPOINTH, TMP_I			;   so we do two branches -> divide et impera;)
	brsh	SCAN_313			; 7 if branch

;halfpic1
SCAN_1_2:
	ldi	TMP_I,   high(1+2)		;->6	
	cpi	VRPOINTL, low(1+2)
	cpc	VRPOINTH, TMP_I
	brsh	SCAN_3				; 10 if branch
	rjmp	TIM0_OVF_END			;   2 -> just leave the sync on
SCAN_3:
	ldi	TMP_I,   high(1+3)
	cpi	VRPOINTL, low(1+3)
	cpc	VRPOINTH, TMP_I
	brsh	SCAN_4_46			; 15 if branch
	rjmp	VSYNC_3				; -> 16
SCAN_4_46:	
	ldi	TMP_I,   high(1+46)
	cpi	VRPOINTL, low(1+46)
	cpc	VRPOINTH, TMP_I
	brsh	SCAN_47_286			; 20 if branch
	ldi	TMP_I, 5			; delay for rest of sync time
	nop
	rjmp	NORMALSYNC			; (38-22)/3 = 16/3 = 5r1
SCAN_47_286:	
	ldi	TMP_I,   high(1+286)
	cpi	VRPOINTL, low(1+286)
	cpc	VRPOINTH, TMP_I
	brsh	SCAN_286_312			; 25 if branch
	ldi	TMP_I, 3			; delay for rest of sync time
	nop
	nop
	rjmp	STREAMLINE			; (38-27)/3 = 11/3 = 3r2
SCAN_286_312:	
						;->25
	ldi	TMP_I, 3			; delay for rest of sync time
	nop					; delay for rest of sync time
	rjmp	NORMALSYNC			; (38-28)/3 = 10/3 = 3r1
; direct jump from halfpic selector
; halfpic2
SCAN_313:					;->7
	ldi	TMP_I,   high(1+313)
	cpi	VRPOINTL, low(1+313)
	cpc	VRPOINTH, TMP_I
	brsh	SCAN_314_315			; 12 if branch
	inc	TICKL
	sbr	FLAG_I, 0x80			; set VSYNC-bit
	rjmp	VSYNC_313			;  -> 13
SCAN_314_315:
	ldi	TMP_I,   high(1+315)
	cpi	VRPOINTL, low(1+315)
	cpc	VRPOINTH, TMP_I
	brsh	SCAN_316_358			; 17 if branch
	rjmp	TIM0_OVF_END			;   2 -> just leave the sync on
SCAN_316_358:	
	ldi	TMP_I,   high(1+358)
	cpi	VRPOINTL, low(1+358)
	cpc	VRPOINTH, TMP_I
	brsh	SCAN_359_598			; 22 if branch
	ldi	TMP_I, 5			; delay for rest of sync time
;	nop
;	nop
	rjmp	NORMALSYNC			; (38-24)/3 = 14/3 = 4r2
SCAN_359_598:	
	ldi	TMP_I,   high(1+598)
	cpi	VRPOINTL, low(1+598)
	cpc	VRPOINTH, TMP_I
	brsh	SCAN_599_624			; 27 if branch
	ldi	TMP_I, 3			; delay for rest of sync time
;	nop
;	nop
	nop
	rjmp	STREAMLINE			; (38-30)/3 = 8/3 = 2r2
SCAN_599_624:	
	ldi	TMP_I,   high(1+624)
	cpi	VRPOINTL, low(1+624)
	cpc	VRPOINTH, TMP_I
	brsh	SCAN_625			; 32 if branch
	ldi	TMP_I, 1			; delay for rest of sync time
	nop
	nop
	rjmp	NORMALSYNC			; (38-35)/3 = 3/3 = 1r0
SCAN_625:
	clr	VRPOINTL			; if field end then reset 
	clr	VRPOINTH			;  VRPOINT
;	nop					; delay for rest of sync time
;	nop
;	sbi	SYNCPORT, TESTPIN
	inc	TICKL
	sbr	FLAG_I, 0x80			; set VSYNC-bit

	rjmp	NORMALSYNC_ND			; (38-36)/3 = 2/3 = 0r2

TIM0_OVF_END:
;	cbi	SYNCPORT, TESTPIN
	adiw	VRPOINTL, 1		; increment VSYNC counter
	
	in	TMP_I, TCNT0		; adjust TCNT0 register for 64탎
	nop
	nop
	nop
	nop
	nop
	subi	TMP_I, (63-256)		
	out	TCNT0, TMP_I
	
	out	SREG, SREG_SV
	reti


; do sync for 4,8탎 then end isr
; (TMP_I)*3 -> delay till sync-end
NORMALSYNC:
	dec	TMP_I			; 1
	brne	NORMALSYNC		; 2 1
	nop				;   1
NORMALSYNC_ND:
	sbi	SYNCPORT, SYNCPIN	;   2
; check for last couple of lines before streaming, if so, then stay
; in ISR to prevent isr response time jitter
					;->5,125탎 = 41 cycles
					; 
	ldi	TMP_I,   high(45)	; 1
	cpi	VRPOINTL, low(45)	; 1
	cpc	VRPOINTH, TMP_I		; 1
	brlt	NORMALSYNC_END		; 1   2 
	ldi	TMP_I,   high(1+46)	; 1
	cpi	VRPOINTL, low(1+46)	; 1
	cpc	VRPOINTH, TMP_I		; 1
	brsh	NORMALSYNC_C46_END	; 1   2 
	ldi	TMP_I, 152		; 1
	nop
	nop
NORMALSYNC_C46:	
	dec	TMP_I			; 1
	brne	NORMALSYNC_C46		; 2 1
	nop				;   1
	adiw	VRPOINTL, 1		; 2   increment VSYNC counter
	rjmp	TIM0_OVF_SYNC		; 2   continue directly
NORMALSYNC_C46_END:	

	ldi	TMP_I,   high(357)	; 1
	cpi	VRPOINTL, low(357)	; 1
	cpc	VRPOINTH, TMP_I		; 1
	brlt	NORMALSYNC_END		; 1   2 
	ldi	TMP_I,   high(1+358)	;     1
	cpi	VRPOINTL, low(1+358)	;     1
	cpc	VRPOINTH, TMP_I		;     1
	brsh	NORMALSYNC_C358_END	;     1   2
	ldi	TMP_I, 149		;     1
	nop
	nop
NORMALSYNC_C358:	
	dec	TMP_I			;     1
	brne	NORMALSYNC_C358		;     2 1
	nop				;       1
	adiw	VRPOINTL, 1		;       1 increment VSYNC counter
	rjmp	TIM0_OVF_SYNC		;       1 continue directly
NORMALSYNC_C358_END:	
NORMALSYNC_END:
	rjmp	TIM0_OVF_END		;         2
;end NORMALSYNC:	

; rest of the 160탎 VSYNC -> another 32탎 low (lines1/2=128탎)
; 32탎 = 256cyc
VSYNC_3:				;16
	nop
	ldi	TMP_I, 79		; 1	-> (256-16)/3 = 240/3 = 80r0
VSYNC_3_1:
	dec	TMP_I			; 1
	brne	VSYNC_3_1		; 2 1
	nop				;   1

	sbi	SYNCPORT, SYNCPIN	; 2
	rjmp	TIM0_OVF_END		; 2
; end VSYNC3	

; rest of the 4,8탎 HSYNC, pause 32-4,8탎 = 217,6cyc, beginn 160탎 VSYNC 
; 32탎 = 256cyc
VSYNC_313:				;13
	ldi	TMP_I, 7		; 1	-> (38-14)/3 = 24/3 = 8r0
	nop
VSYNC_313_1:
	dec	TMP_I			; 1
	brne	VSYNC_313_1		; 2 1
	nop				;   1

	sbi	SYNCPORT, SYNCPIN	; 2

	ldi	TMP_I, 71		; 1	-> (217-3)/3 = 214/3 = 71r1
	nop
VSYNC_313_2:
	dec	TMP_I			; 1
	brne	VSYNC_313_2		; 2 1
	nop				;   1

	cbi	SYNCPORT, SYNCPIN	; 2

	rjmp	TIM0_OVF_END		; 2
; end VSYNC3	


	
; do sync then stream one scanline of pixels, then end isr
; (TMP_I)*3 -> delay till sync-end
STREAMLINE:
	dec	TMP_I			; 1
	brne	STREAMLINE		; 2 1
	nop				;   1
	sbi	SYNCPORT, SYNCPIN	; 2 end of 4.8탎 sync

; start back porch 5탎 = 40 cycles
	push	VRPOINTL		; 2
	push	VRPOINTH		; 2
	
	; calculate video memory pointer	
	mov	TMPL_I, VRPOINTL	; 1
	mov	TMPH_I, VRPOINTH	; 1
	ldi	TMP_I, 	high(312)	; 1 check halfpic
	cpi	TMPL_I,  low(312)	; 1
	cpc	TMPH_I, TMP_I		; 1
	brsh	STREAMLINE_H2		; 1 2
STREAMLINE_H1:
	ldi	TMP_I, high(47)		; 1
	subi	TMPL_I, low(47)		; 1
	sbc	TMPH_I, TMP_I		; 1
	rjmp	STREAMLINE_HE		; 2
STREAMLINE_H2:
	ldi	TMP_I, high(359)	;   1
	subi	TMPL_I, low(359)	;   1
	sbc	TMPH_I, TMP_I		;   1
	nop				;   1
	
STREAMLINE_HE:				; at this point we got the right scanline in TMPL_I/TMPH_I
					;  TMPH_I is supposed to be zero!!!
					; ->	 17cyc
	ldi	VRPOINTL, low(VIDEOBASE)		; 1 	; get videobase in VRPOINTer
	ldi	VRPOINTH, high(VIDEOBASE)	; 1 

	; video memory: scanline/8 * 12
	lsr	TMPL_I		; /8		; 1	
	lsr	TMPL_I				; 1
	lsr	TMPL_I				; 1
	mov	TMPH_I, TMPL_I			; 1
	add	TMPL_I, TMPH_I	; *3		; 1
	add	TMPL_I, TMPH_I			; 1
	lsl	TMPL_I		; *2		; 1
	add	VRPOINTL, TMPL_I		; 1
	adc	VRPOINTH, ZEROREG		; 1
	add	VRPOINTL, TMPL_I		; 1
	adc	VRPOINTH, ZEROREG		; 1
	mov	HCOUNT, VRPOINTL		; 1 	; preload HRCOUNT last pixel byte
	subi	HCOUNT, -(13)			; 1 
					; -> 	 32cyc

;	ldi	TMP_I, $FF
;	out	TIFR, TMP_I
	nop					; 1
	nop					; 1
	nop					; 1
	nop					; 1
;	nop					; 1
;	nop					; 1
					; -> 	 38cyc

	; horizontal correction
	ldi	TMP_I, HSHIFT
STREAMLINE_HSHIFT:
	dec	TMP_I
	brne	STREAMLINE_HSHIFT
	nop


	ld	TMPL_I, X+;VRPOINT+		; 2
STREAMLINE_SHIFTER:						; 32*12 cycles: 384cycles = 48us
	out	PIXELPORT, TMPL_I		; 1
	mov	TMP_I, TMPL_I			; 1	
	lsl	TMP_I				; 1
	nop					; 1
	nop
	nop
	nop
	nop

	out	PIXELPORT, TMP_I		; 1
	lsl	TMP_I				; 1
	nop					; 1
	nop					; 1
	nop
	nop
	nop
	nop


	out	PIXELPORT, TMP_I		; 1
	ld	TMPL_I, X+;VRPOINT+		; 2
	lsl	TMP_I				; 1
	nop
	nop
	nop
	nop


	out	PIXELPORT, TMP_I		; 1
	cp	VRPOINTL, HCOUNT		; 1
	nop
	nop
	nop
	nop

	brne	STREAMLINE_SHIFTER				; 2
; end shifter							;		: 57,5us -> 6,5us bis voll
	

; start front porch 1.9탎 = 15cyc -> to short for isr return -> stay in isr
STREAMLINE_END:
	out	PIXELPORT, ZEROREG
	pop	VRPOINTH
	pop	VRPOINTL
	adiw	VRPOINTL, 1		; increment VSYNC counter

	ldi	TMP_I, 14-HSHIFT	; 1 : 43/3=14r1
;	nop
STREAMLINE_END_1:
	dec	TMP_I			; 1
	brne	STREAMLINE_END_1	; 2 1
;	nop				;   1
	
	rjmp	TIM0_OVF_SYNC
; end STREAMLINE:
	


; delays program for (n+1)*8 cycles
;	ldi	TMP_I, n	;   1
;	rcall			;   3
WAIT_8C_I:
	nop			; 1
	nop			; 1
	nop			; 1
	nop			; 1
	nop			; 1
	dec	TMP_I		; 1	: TMP_I*(3+5)
	brne	WAIT_8C_I		; 2 1
	ret			;   4

WAIT_VSYNC:
	sbrs	FLAG_I, 7	; check for VSYNC-bit
	rjmp	WAIT_VSYNC
	cbr	FLAG_I, 0x80	; reset VSYNC-bit
	rcall	DOSOUND
	ret	


;****************************************************************************
;*
;* MAIN Program
;*
;****************************************************************************
MAIN:  
	ldi	TMPH, high(SOUND1*2)
	ldi	TMPL, low(SOUND1*2)
	rcall	STARTSOUND

MAIN_WAIT:
	rcall	WAIT_VSYNC
;	rjmp	MAIN_VSYNC


;	ldi	TMPH, high( fC1 )
;	ldi	TMPL,  low( fC1 )

;	sbi	PORTD,5
;	cbi	PORTD,5
;	rjmp	MAIN

	sbis	PADDLEPIN, PADDLE1LEFT
	rcall	SETSOCCER
	sbis	PADDLEPIN, PADDLE1RIGHT
	rcall	SETTENNIS

	sbic	PADDLEPIN, PADDLE1UP
	rjmp	MAIN_WAIT
	sbic	PADDLEPIN, PADDLE2UP
	rjmp	MAIN_WAIT

	push	ZL
	push	ZH
	ldi	ZL, low( PICPAT*2 )	; plot normal playfield
	ldi	ZH, high( PICPAT*2 )
	rcall	PLOTSCREEN
	pop	ZH
	pop	ZL


;**** MAIN loop **********************************************

	ldi	VREG1, 45		; draw winning score marker
	ldi	VREG2, 29-SCOREWIN
	ldi	TMP, 0x03
	rcall	SETPIXEL
	ldi	VREG1, 46
	ldi	VREG2, 29-SCOREWIN
	ldi	TMP, 0x03
	rcall	SETPIXEL


forever:
	rcall	PLAYPONG
	
	rjmp	forever		; eternal loop
;**** end MAIN loop **********************************************

SETSOCCER:
	ldi	TMPL, SPEED_SOCCER	; start speed x
	sbrc	TICKL, 1
	ldi	TMPL, -SPEED_SOCCER

	ldi	TMPH, SPEED_SOCCER		; start speed y
	sbrc	TICKL, 2
	ldi	TMPH, -SPEED_SOCCER

	ori	FLAG_I, 0x40	; set 2D-Flag

	ldi	TMP, 80	; start coordinates
	ldi	YL, low(BALL_X)	; set ball coordinates in SRAM
	ldi	YH, high(BALL_X)
	st	Y, TMP
	ldi	TMP, 10
	ldi	YL, low(BALL_Y)
	ldi	YH, high(BALL_Y)
	st	Y, TMP

	ldi	YL, low(BALLSPEED_X)	; set ball speed in SRAM
	ldi	YH, high(BALLSPEED_X)
	st	Y, TMPL
	ldi	YL, low(BALLSPEED_Y)
	ldi	YH, high(BALLSPEED_Y)
	st	Y, TMPH

	push	ZL
	push	ZH
	ldi	ZL, low( SOCCERTEXT*2 )	; plot normal playfield
	ldi	ZH, high( SOCCERTEXT*2 )
	rcall	PLOTSCREEN
	pop	ZH
	pop	ZL

	ret

SETTENNIS:
	ldi	TMPL, SPEED_TENNIS	; start speed x
	sbrc	TICKL, 1
	ldi	TMPL, -SPEED_TENNIS
	ldi	TMPH, SPEED_TENNIS		; start speed y
	sbrc	TICKL, 2
	ldi	TMPH, -SPEED_TENNIS
	andi	FLAG_I, 0xFF-0x40	; reset 2D-Flag

	ldi	TMP, 80	; start coordinates
	ldi	YL, low(BALL_X)	; set ball coordinates in SRAM
	ldi	YH, high(BALL_X)
	st	Y, TMP
	ldi	TMP, 10
	ldi	YL, low(BALL_Y)
	ldi	YH, high(BALL_Y)
	st	Y, TMP
	
	ldi	YL, low(BALLSPEED_X)	; set ball speed in SRAM
	ldi	YH, high(BALLSPEED_X)
	st	Y, TMPL
	ldi	YL, low(BALLSPEED_Y)
	ldi	YH, high(BALLSPEED_Y)
	st	Y, TMPH


	push	ZL
	push	ZH
	ldi	ZL, low( TENNISTEXT*2 )	; plot normal playfield
	ldi	ZH, high( TENNISTEXT*2 )
	rcall	PLOTSCREEN
	pop	ZH
	pop	ZL

	ret



; source data-pointer in Z
;	ldi	ZL, low( CREDITSCREEN*2 )
;	ldi	ZH, high( CREDITSCREEN*2 )
PLOTSCREEN:
	cli
	push	YL
	push	YH
	ldi	YL, low(VIDEOBASE)
	ldi	YH, high(VIDEOBASE)
	clr	TMP
PLOTSCREEN_1:
	lpm	
	st	Y+, LPMREG					; preload video memory
	adiw	ZL, 1
	inc	TMP
	cpi	TMP, 160
	brne	PLOTSCREEN_1
	clr	TMP
PLOTSCREEN_2:
	lpm	
	st	Y+, LPMREG					; preload video memory
	adiw	ZL, 1
	inc	TMP
	cpi	TMP, 200
	brne	PLOTSCREEN_2
	pop	YH
	pop	YL
	sei
	ret
; *** END of PLOTSCREEN



; the real authentic pong routine
PLAYPONG:
	rcall	WAIT_VSYNC	; synchronise game with screen
	rcall	WAIT_VSYNC	; synchronise game with screen
; do paddle1
	rcall	DOPADDLE


;PLAYPONG_GETBALL:
	ldi	YL, low(BALL_X)	; get ball coordinates from SRAM
	ldi	YH, high(BALL_X)
	ld	LREG1, Y
	ldi	YL, low(BALL_Y)
	ldi	YH, high(BALL_Y)
	ld	LREG2, Y
	mov	LREG5, LREG1		; old ball position
	mov	LREG6, LREG2
	ldi	YL, low(BALLSPEED_X)	; get ball speed from SRAM
	ldi	YH, high(BALLSPEED_X)
	ld	LREG3, Y
	ldi	YL, low(BALLSPEED_Y)
	ldi	YH, high(BALLSPEED_Y)
	ld	LREG4, Y


;PLAYPONG_CLEARCURRENTBALL_POSITION:
	mov	VREG1, LREG5	; clear ball position on screen
	mov	VREG2, LREG6	
	lsr	VREG1		; the resolution in SRAM is 4times higher than on the screen
	lsr	VREG1		;  thus the shifting
	lsr	VREG2
	lsr	VREG2
	ldi	TMP, 0x00
	rcall	SETPIXEL
	
;PLAYPONG_CALC_NEW_BALL_POSITION:
PLAYPONG_CNBP:
	add	LREG1, LREG3	; add x-speed to x-pos
	mov	VREG1, LREG1	; check for obstacle on new position
	mov	VREG2, LREG2	
	lsr	VREG1		
	lsr	VREG1		
	lsr	VREG2
	lsr	VREG2

	rcall	DOSCORE

	rcall	GETPIXEL	; GETPIXEL returns 1 if pixel set
	andi	TMP, 0x03
	breq	PLAYPONG_CNBP_X1 ; no obstacle, go on!
	neg	LREG3		; -> obstacle in x direction -> neg x-speed
	add	LREG1, LREG3
	
	ldi	TMPH, high(SOUND_BAT1*2)
	ldi	TMPL, low(SOUND_BAT1*2)
	rcall	STARTSOUND

	rjmp	PLAYPONG_CNBP
PLAYPONG_CNBP_X1:

	add	LREG2, LREG4	; add y-speed to y-pos
	mov	VREG1, LREG1	; check for obstacle on new position
	mov	VREG2, LREG2	
	lsr	VREG1		
	lsr	VREG1		
	lsr	VREG2
	lsr	VREG2
	rcall	GETPIXEL	; GETPIXEL returns 1 if pixel set
	andi	TMP, 0x03
	breq	PLAYPONG_CNBP_Y1 ; no obstacle, go on!
	neg	LREG4		; -> obstacle in y direction -> neg y-speed
	add	LREG2, LREG4

	ldi	TMPH, high(SOUND_BAT1*2)
	ldi	TMPL, low(SOUND_BAT1*2)
	rcall	STARTSOUND

	rjmp	PLAYPONG_CNBP
PLAYPONG_CNBP_Y1:


;PLAYPONG_SETCURRENTBALL_POSITION:
	mov	VREG1, LREG1	; set ball position on screen
	mov	VREG2, LREG2	
	lsr	VREG1		; the resolution in SRAM is 4times higher than on the screen
	lsr	VREG1		;  thus the shifting
	lsr	VREG2
	lsr	VREG2
	ldi	TMP, 0x03
	rcall	SETPIXEL

	
;PLAYPONG_SETBALL:
	ldi	YL, low(BALL_X)		; set ball coordinates in SRAM
	ldi	YH, high(BALL_X)
	st	Y, LREG1
	ldi	YL, low(BALL_Y)
	ldi	YH, high(BALL_Y)
	st	Y, LREG2
	ldi	YL, low(BALLSPEED_X)	; set ball speed in SRAM
	ldi	YH, high(BALLSPEED_X)
	st	Y, LREG3
	ldi	YL, low(BALLSPEED_Y)
	ldi	YH, high(BALLSPEED_Y)
	st	Y, LREG4
	ret


DOSCORE:
	push	TMP
	push	VREG1
	push	VREG2

;	rjmp DOSCORE21
	
	ldi	YL, low(SCORE2)	; get data from SRAM
	ldi	YH, high(SCORE2)
	ld	TMP, Y
	cpi	VREG1, GOAL1X+1	; if goal
	brge	DOSCORE_1
	inc	TMP		; -> inc score
	st	Y, TMP

	cpi	TMP, SCOREWIN
	brge	DOSCORE_MATCH2

	ldi	VREG1, 39+4+3
	ldi	VREG2, 29
	sub	VREG2, TMP
	ldi	TMP, 0x01
	rcall	SETPIXEL
	
	rcall	STOPSOUND
	ldi	TMPH, high(SOUND_GOAL1*2)
	ldi	TMPL, low(SOUND_GOAL1*2)
	rcall	STARTSOUND
	
	rjmp	DOSCORE_2	
DOSCORE_1:

DOSCORE21:
	ldi	YL, low(SCORE1)	; get data from SRAM
	ldi	YH, high(SCORE1)
	ld	TMP, Y
	cpi	VREG1, GOAL2X	; if goal
	brlt	DOSCORE_2
	inc	TMP		; -> inc score
	st	Y, TMP

	cpi	TMP, SCOREWIN
	brge	DOSCORE_MATCH1

	ldi	VREG1, 39+4+2
	ldi	VREG2, 29
	sub	VREG2, TMP
	ldi	TMP, 0x02
	rcall	SETPIXEL
	
	rcall	STOPSOUND
	ldi	TMPH, high(SOUND_GOAL2*2)
	ldi	TMPL, low(SOUND_GOAL2*2)
	rcall	STARTSOUND
DOSCORE_2:	
	
	pop	VREG2
	pop	VREG1
	pop	TMP
	ret	

DOSCORE_MATCH1:
	push	ZL
	push	ZH
	ldi	ZL, low( MATCH1*2 )
	ldi	ZH, high( MATCH1*2 )
	rcall	PLOTSCREEN

	rcall	STOPSOUND
	ldi	TMPH, high(SOUND_MATCH1*2)
	ldi	TMPL, low(SOUND_MATCH1*2)
	rcall	STARTSOUND

	pop	ZL
	pop	ZH
DOSCORE_MATCH_FE:
	rcall	WAIT_VSYNC		
	sbic	PADDLEPIN, PADDLE1DOWN
	rjmp	DOSCORE_MATCH_FE
	sbic	PADDLEPIN, PADDLE2DOWN
	rjmp	DOSCORE_MATCH_FE
	rjmp	RESET

DOSCORE_MATCH2:
	push	ZL
	push	ZH
	ldi	ZL, low( MATCH2*2 )
	ldi	ZH, high( MATCH2*2 )
	rcall	PLOTSCREEN

	rcall	STOPSOUND
	ldi	TMPH, high(SOUND_MATCH2*2)
	ldi	TMPL, low(SOUND_MATCH2*2)
	rcall	STARTSOUND

	pop	ZL
	pop	ZH
	rjmp	DOSCORE_MATCH_FE

; do paddle calculation and drawing
DOPADDLE:
	ldi	YL, low(BAT1_Y)	; get paddle coordinates from SRAM
	ldi	YH, high(BAT1_Y)
	ld	VREG2, Y
	ldi	YL, low(BAT1_X)	; get paddle coordinates from SRAM
	ldi	YH, high(BAT1_X)
	ld	VREG1, Y
DOPADDLE1_ERASE:
	ldi	TMP, 0x00	; color black
	dec	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	dec	VREG2
	dec	VREG2
	sbis	PADDLEPIN, PADDLE1UP	; paddle movement
	dec	VREG2
	sbis	PADDLEPIN, PADDLE1DOWN
	inc	VREG2
	cpi	VREG2, BATYMIN		; check upper limit
	brge	DOPADDLE1_1
	ldi	VREG2, BATYMIN
DOPADDLE1_1:
	cpi	VREG2, BATYMAX		; check upper limit
	brlt	DOPADDLE1_2
	ldi	VREG2, BATYMAX
DOPADDLE1_2:
	ldi	YL, low(BAT1_Y)		; set paddle coordinates in SRAM
	ldi	YH, high(BAT1_Y)
	st	Y, VREG2

	sbrs	FLAG_I, 6		; check for 2D-flag
	rjmp	DOPADDLE1_DRAW
	
	sbis	PADDLEPIN, PADDLE1LEFT	; paddle movement
	dec	VREG1
	sbis	PADDLEPIN, PADDLE1RIGHT
	inc	VREG1
	cpi	VREG1, BATXMIN		; check upper limit
	brge	DOPADDLE1_3
	ldi	VREG1, BATXMIN
DOPADDLE1_3:
	cpi	VREG1, BATXMAX		; check upper limit
	brlt	DOPADDLE1_4
	ldi	VREG1, BATXMAX
DOPADDLE1_4:
	ldi	YL, low(BAT1_X)		; set paddle coordinates in SRAM
	ldi	YH, high(BAT1_X)
	st	Y, VREG1
DOPADDLE1_DRAW:
	ldi	TMP, 0x02		; color light grey
	dec	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL


DOPADDLE2:
	ldi	YL, low(BAT2_Y)	; get paddle coordinates from SRAM
	ldi	YH, high(BAT2_Y)
	ld	VREG2, Y
	ldi	YL, low(BAT2_X)	; get paddle coordinates from SRAM
	ldi	YH, high(BAT2_X)
	ld	VREG1, Y
DOPADDLE2_ERASE:
	ldi	TMP, 0x00	; color black
	dec	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	dec	VREG2
	dec	VREG2
	sbis	PADDLEPIN, PADDLE2UP	; paddle movement
	dec	VREG2
	sbis	PADDLEPIN, PADDLE2DOWN
	inc	VREG2
	cpi	VREG2, BATYMIN		; check upper limit
	brge	DOPADDLE2_1
	ldi	VREG2, BATYMIN
DOPADDLE2_1:
	cpi	VREG2, BATYMAX		; check upper limit
	brlt	DOPADDLE2_2
	ldi	VREG2, BATYMAX
DOPADDLE2_2:
	ldi	YL, low(BAT2_Y)		; set paddle coordinates in SRAM
	ldi	YH, high(BAT2_Y)
	st	Y, VREG2

	sbrs	FLAG_I, 6		; check for 2D-flag
	rjmp	DOPADDLE2_DRAW

	sbis	PADDLEPIN, PADDLE2LEFT	; paddle movement
	dec	VREG1
	sbis	PADDLEPIN, PADDLE2RIGHT
	inc	VREG1
	cpi	VREG1, BATXMIN		; check upper limit
	brge	DOPADDLE2_3
	ldi	VREG1, BATXMIN
DOPADDLE2_3:
	cpi	VREG1, BATXMAX		; check upper limit
	brlt	DOPADDLE2_4
	ldi	VREG1, BATXMAX
DOPADDLE2_4:
	ldi	YL, low(BAT2_X)		; set paddle coordinates in SRAM
	ldi	YH, high(BAT2_X)
	st	Y, VREG1
DOPADDLE2_DRAW:
	ldi	TMP, 0x01		; color dark grey
	dec	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	inc	VREG2
	rcall	SETPIXEL
	
	ret

;****************************************************************************
; get pixel
; coordinates are in VREG1 and VREG2, return TMP = 0x00,0x01, 0x10, 0x11 (pixelcolor)
;
;ByteAdresse = Y*12 + (X/4) + 1 + Bildschirmspeicher
;BitAdresse  = X & 0x03	
GETPIXEL:
	push	YL
	push	YH
	push	TMPL
	push	TMPH
	rcall	CALCPIXEL
	ld	TMPL, Y

	cpi	TMP, 0x00
	brne	GETPIXEL_1
	lsr	TMPL
	lsr	TMPL
	lsr	TMPL
	rjmp	GETPIXEL_4
GETPIXEL_1:
	cpi	TMP, 0x01
	brne	GETPIXEL_2
	lsr	TMPL
	lsr	TMPL
	rjmp	GETPIXEL_4
GETPIXEL_2:
	cpi	TMP, 0x02
	brne	GETPIXEL_3
	lsr	TMPL
	rjmp	GETPIXEL_4
GETPIXEL_3:
GETPIXEL_4:
	andi	TMPL, 0x11
	andi	TMP, ~0x03
	sbrc	TMPL, 4		; move color 0..3 into TMP
	sbr	TMP, 0x02
	sbrc	TMPL, 0
	sbr	TMP, 0x01
GETPIXEL_5:
	pop	TMPH
	pop	TMPL
	pop	YH
	pop	YL
	ret
;****************************************************************************



;****************************************************************************
; set pixel
; coordinates are in VREG1 and VREG2, color in TMP bit7 und bit3
;
;ByteAdresse = Y*12 + (X/4) + 1 + Bildschirmspeicher
;BitAdresse  = X & 0x03	
SETPIXEL:
	push	YL
	push	YH
	push	TMPL
	push	TMPH
	push	TMP		; is pushed twice, to preserve TMP
	sbrc	TMP, 1		; prepare color in TMP
	sbr	TMP, 0x10
	cbr	TMP, 0x02
	push	TMP
	rcall	CALCPIXEL
	ld	TMPL, Y
	cpi	TMP, 0x00
	brne	SETPIXEL_1
	pop	TMP
	lsl	TMP
	lsl	TMP
	lsl	TMP
	andi	TMPL, ~0x88
	or	TMPL, TMP
	rjmp	SETPIXEL_4
SETPIXEL_1:
	cpi	TMP, 0x01
	brne	SETPIXEL_2
	pop	TMP
	lsl	TMP
	lsl	TMP
	andi	TMPL, ~0x44
	or	TMPL, TMP
	rjmp	SETPIXEL_4
SETPIXEL_2:
	cpi	TMP, 0x02
	brne	SETPIXEL_3
	pop	TMP
	lsl	TMP
	andi	TMPL, ~0x22
	or	TMPL, TMP
	rjmp	SETPIXEL_4
SETPIXEL_3:
	pop	TMP
	andi	TMPL, ~0x11
	or	TMPL, TMP
SETPIXEL_4:
	st	Y, TMPL
	pop	TMP
	pop	TMPH
	pop	TMPL
	pop	YH
	pop	YL
	ret
;****************************************************************************

;****************************************************************************
;ByteAdresse = Y*12 + (X/4) + 1 + Bildschirmspeicher
;BitAdresse  = X & 0x03	
; calculate pixel memory adress                                             *
CALCPIXEL:
	ldi	YL, low(VIDEOBASE)
	ldi	YH, high(VIDEOBASE)
	clr	TMPH		
	mov	TMPL, VREG2	; Y*3
	add	TMPL, VREG2		
	add	TMPL, VREG2		
	lsl	TMPL		; Y*4
	rol	TMPH
	lsl	TMPL
	rol	TMPH
	mov	TMP, VREG1	; X/4
	lsr	TMP
	lsr	TMP
	inc	TMP		; X+1	
	add	YL, TMPL
	adc	YH, TMPH
	add	YL, TMP
	adc	YH, ZEROREG
	mov	TMP, VREG1
	andi	TMP, 0x03
	ret	
;**** END CALCPIXEL ****************************************************************


;**** DOSOUND **********************************************************************
DOSOUND:
	push	ZL
	push	ZH
	push	YL
	push	YH
;	push	TMP
;	push	TMPL
;	push	TMPH
	
	ldi	YL, low(SOUNDSOURCEL)	; sram position of the dosound-data
	ldi	YH, high(SOUNDSOURCEH)
	ld	ZL,Y		; soundsource L
	ldd	ZH,Y+1		; soundsource H
	ldd	TMP,Y+2		; get duration
	
	cpi	TMP,0		; if duration 0 -> no sound
	breq	DOSOUND_SILENCE

	cpi	TMP,1		; if duration 1 -> fetch next data
	breq	DOSOUND_NEXT

	ldi	TMPL, 0x0A	; start timer
	out	TCCR1B, TMPL	

	dec	TMP
	std	Y+2, TMP		; store duration
	rjmp	DOSOUND_END



DOSOUND_NEXT:
	adiw	ZL,2		; increment sound source
	
	lpm
	mov	TMP, LPMREG	; get tone
	adiw	ZL,1
	lpm
	mov	TMPL, LPMREG	; get duration
	subi	ZL, 1
	sbc	ZH, ZEROREG

	std	Y+2, TMPL	; store new duration
	std	Y+1, ZH		; store new source
	std	Y+0, ZL

	cpi	TMPL, 0		; stop noise if duration zero
	breq	DOSOUND_SILENCE

	ldi	ZL,  low(TONETABLE*2)	; retrieve tone value and load timer
	ldi	ZH, high(TONETABLE*2)
	lsl	TMP			; tone table is 16bit wide
	add	ZL, TMP
	adc	ZH, ZEROREG

	lpm
	mov	TMP, LPMREG
	adiw	ZL, 1
	lpm
	out	OCR1AH, LPMREG
	out	OCR1AL, TMP
	ldi	TMP, 0x08	; ())=/(/stop timer to get break between sounds
	out	TCCR1B, TMP	

	rjmp	DOSOUND_END

DOSOUND_SILENCE:
	out	TCCR1B, ZEROREG	; stop timer
	rjmp	DOSOUND_END
		
DOSOUND_END:
;	push	TMPH
;	push	TMPL
;	push	TMP
	pop	YH
	pop	YL
	pop	ZH
	pop	ZL
	ret
;**** END DOSOUND ******************************************************************

;******** STARTSOUND ***************************************************************
;*
;* SOUNDSOURCEL/H in TMPL/H
;*
;***********************************************************************************
STARTSOUND:
	push	ZL
	push	ZH
	push	YL
	push	YH
	push	TMP
	
	mov	ZH, TMPH	; position of the soundsource
	mov	ZL, TMPL
	subi	ZL, 2		; correction for dosound
	sbc	ZH, ZEROREG

	ldi	YL, low(SOUNDSOURCEL)	; sram position of the dosound-data
	ldi	YH, high(SOUNDSOURCEL)
	ldd	TMP, Y+2
	cpi	TMP, 0			; check if sound still running-> 
	brne	STARTSOUND_END		;  if so, don't start new sound
	
	ldi	YL, low(SOUNDSOURCEL)	; sram position of the dosound-data
	ldi	YH, high(SOUNDSOURCEL)
	st	Y, ZL		; soundsource L
	std	Y+1, ZH		; soundsource H
	ldi	ZL,1		; set duration 1 to trigger sound
	std	Y+2, ZL

STARTSOUND_END:		
	pop	TMP
	pop	YH
	pop	YL
	pop	ZH
	pop	ZL
	ret
;**** END STARTSOUND ***************************************************************
	
;**** STOPSOUND *******************************************************************
STOPSOUND:
	push	ZL
	push	ZH
	ldi	ZL, low(SOUNDSOURCEL)	; sram position of the dosound-data
	ldi	ZH, high(SOUNDSOURCEL)
	std	Z+0, ZEROREG			; clear all sound parameters
	std	Z+1, ZEROREG			; clear all sound parameters
	std	Z+2, ZEROREG		; set duration to zero -> nois stops ;)
	pop	ZH
	pop	ZL
	ret	
;**** END STOPSOUND ***************************************************************


;*******************************************************************************************
;*** Reset function, initialization of AVR
RESET:
;***** Initialize stack pointer
;* Initialize stack pointer to highest address in internal SRAM
;* Comment out for devices without SRAM
	cli	; for secondary reset (warm start)

	ldi	TMP, $FF		; joystick input port with pullups
	out	PORTA, TMP
	ldi	TMP, 00			
	out	DDRA, TMP

	ldi	TMP, $00
	out	PORTB, TMP
	ldi	TMP, $0F	
	out	DDRB, TMP

	ldi	TMP, $00
	out	PORTC, TMP
	ldi	TMP, $88			; port C data direction register
	out	DDRC, TMP

	ldi	TMP, (1<<SYNCPIN)
	out	PORTD,TMP
	ldi	TMP, (1<<SYNCPIN)+(0x20)	; SYNC pin, port b data direction register
	out	DDRD, TMP

	ldi	r16,high(RAMEND) 	;High byte only required if  
	out	SPH,r16	       		;RAM is bigger than 256 Bytes ( not 2313... )
	ldi	TMP,low(RAMEND)	 
	out	SPL,TMP


	clr	ZEROREG

	ldi	TMP, $00	; disable all interrupts
	out	GIMSK, TMP

	ldi	TMP, $00	; clear status register
	out	SREG, TMP

; UART initialization
;	ldi	TMP, 0b00011001	; no RX-Interrupt, TX-Enable, TX-Enable, 8-Bit
;	out	UCR, TMP	; UART Control Register
;	ldi	TMP, 32		; 19200 Baud bei 10 MHz	Baud = f_Clock / ( 16 ( UBRR + 1 ) )
;	ldi	TMP, 12		; 19200 Baud bei  4 MHz	Baud = f_Clock / ( 16 ( UBRR + 1 ) )
;	ldi	TMP, 25		; 19200 Baud bei  8 MHz	Baud = f_Clock / ( 16 ( UBRR + 1 ) )
;	ldi	TMP, 51		;  9600 Baud bei  8 MHz	Baud = f_Clock / ( 16 ( UBRR + 1 ) )
;	ldi	TMP, 64		;  9600 Baud bei 10 MHz	Baud = f_Clock / ( 16 ( UBRR + 1 ) )
;	ldi	TMP, 207		;  2400 Baud bei  8 MHz	Baud = f_Clock / ( 16 ( UBRR + 1 ) )
;	out	UBRR, TMP		; UART Baud Rate Register  UBRR = (f_Clock / (16 * Baud)) -1
;	cbi	PORTD, 1
; end of UART initialization

;	clr	HCOUNT
;	clr	SCOUNT
;	clr	SCOUNTH
;	ldi	VRPOINTL, low(VIDEOBASE)
;	ldi	VRPOINTH, high(VIDEOBASE)
	ldi	FLAG_I, 0		; clear flags

; *** setup video system
	sbi	SYNCPORT, SYNCPIN		; sync high
	cbi	PIXELPORT, PIXELPINH		; pixel black
	cbi	PIXELPORT, PIXELPINL

;rjmp AFTER_PRELOAD


PRESET_BATS:
	ldi	YL, low(BAT1_Y)	; get paddle coordinates from SRAM
	ldi	YH, high(BAT1_Y)
	ldi	TMP, BATYMAX/2
	st	Y, TMP
	ldi	YL, low(BAT2_Y)	; get paddle coordinates from SRAM
	ldi	YH, high(BAT2_Y)
	ldi	TMP, BATYMAX/2
	st	Y, TMP
	ldi	YL, low(BAT1_X)	; get paddle coordinates from SRAM
	ldi	YH, high(BAT1_X)
	ldi	TMP, BATXMIN
	st	Y, TMP
	ldi	YL, low(BAT2_X)	; get paddle coordinates from SRAM
	ldi	YH, high(BAT2_X)
	ldi	TMP, BATXMAX
	st	Y, TMP

PRESET_SCORE:
	ldi	YL, low(SCORE1)	; get paddle coordinates from SRAM
	ldi	YH, high(SCORE1)
	ldi	TMP, 0
	st	Y, TMP
	ldi	YL, low(SCORE2)	; get paddle coordinates from SRAM
	ldi	YH, high(SCORE2)
	ldi	TMP, 0
	st	Y, TMP

AFTER_PRELOAD:

DO_CREDIT:
	push	ZL
	push	ZH
	ldi	ZL, low( CREDITSCREEN*2 )	; plot credit screen
	ldi	ZH, high( CREDITSCREEN*2 )
	rcall	PLOTSCREEN
	pop	ZH
	pop	ZL
DO_CREDIT_FE:

; *** setup video system END

; setup sound system ;)
	ldi	YL, low(SOUNDSOURCEL)	; sram position of the dosound-data
	ldi	YH, high(SOUNDSOURCEL)
	st	Y+, ZEROREG			; clear all sound parameters
	st	Y+, ZEROREG
	st	Y+, ZEROREG

	ldi	TMPH, high( 500000 / 240 )
	ldi	TMPL,  low( 500000 / 240 )
	out	OCR1AH, TMPH
	out	OCR1AL, TMPL

	ldi	TMP, 0x40	; set OCR1A toggle on compare match
	out	TCCR1A, TMP
	ldi	TMP, 0x0A	; set presc 8, clear on compare match
	out	TCCR1B, TMP	;  8 means 14Hz at 65535
; end SETUP sound


; **** timer interrupt setup

	; setup counters
	ldi	TMP, (1<<TOIE0)		; enable timer TOV0 interrupt
	out	TIMSK, TMP
	
	ldi	TMP, 0 	
	out	TCNT0, TMP	;
	ldi	TMP, (1<<CS01) ; start timer clock 0
	out	TCCR0, TMP
	

; **** timer interrupt setup END
;	clr	SCOUNT
	ldi	VRPOINTL, 1		; set VRPOINTER to SCANLINE 1
	ldi	VRPOINTH, 0

	ldi	TMP, $FF	; clear interrupt flags
	out	TIFR, TMP
	out	GIFR, TMP	
	sei			; global interrupt enable
	
	rjmp	MAIN
;*******************************************************************************************



;******* SCREEN patterns ***********************************************************
PICPAT:
	;          0    4    8    12   16   20 	 24   28   32   36
	.db 0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00 ; 0
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ; 1
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ; 2
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ; 3
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ; 4
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ; 5
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ; 6
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ; 7
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ; 8
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ; 9
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;10 
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;11
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;12 
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;13
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;14
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;15
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;16 
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;17
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;18
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;19
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;20
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;21
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;22
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;23
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;24
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;25
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;26
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;27
	.db 0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00 ;28
	.db 0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00 ;29



MATCH1:
	.db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
	.db 0x78, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE1
	.db 0x7B, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xED
	.db 0x7A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x70, 0xC0, 0x60, 0x00, 0xF0, 0xB0, 0x60, 0xF0, 0x70, 0xC0, 0xE5
	.db 0x7A, 0x70, 0xE0, 0x60, 0x10, 0xF0, 0xB0, 0x60, 0xF0, 0x60, 0x20, 0xE5
	.db 0x7A, 0x60, 0x30, 0x60, 0x10, 0x80, 0xB0, 0x60, 0xC0, 0x60, 0x20, 0xE5
	.db 0x7A, 0x60, 0x30, 0x60, 0x10, 0x80, 0xB0, 0x20, 0xC0, 0x60, 0x20, 0xE5
	.db 0x7A, 0x60, 0x30, 0x60, 0x10, 0x80, 0xB0, 0x20, 0xF0, 0xE0, 0x60, 0xE5
	.db 0x7A, 0x70, 0xE0, 0x60, 0x10, 0xF0, 0xB0, 0x20, 0xF0, 0x70, 0xC0, 0xE5
	.db 0x7A, 0x70, 0xC0, 0x60, 0x10, 0xF0, 0xB0, 0xE0, 0xC0, 0x70, 0xC0, 0xE5
	.db 0x7A, 0x60, 0x00, 0x60, 0x10, 0x80, 0x80, 0x60, 0xC0, 0x60, 0x40, 0xE5
	.db 0x7A, 0x60, 0x00, 0x70, 0xD0, 0x80, 0x81, 0x68, 0xC0, 0x60, 0x60, 0xE5
	.db 0x7A, 0x60, 0x00, 0x70, 0xF0, 0x80, 0xB0, 0xC0, 0xF0, 0x60, 0x20, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x30, 0xF0, 0xC0, 0x66, 0x22, 0xFF, 0xDD, 0x88, 0x88, 0x00, 0xE5
	.db 0x7A, 0x30, 0xF0, 0xC0, 0x66, 0x22, 0x66, 0x11, 0xCC, 0x99, 0xCC, 0xE5
	.db 0x7A, 0x00, 0x60, 0x00, 0x66, 0x22, 0x66, 0x11, 0xCC, 0xAA, 0x00, 0xE5
	.db 0x7A, 0x00, 0x60, 0x00, 0x66, 0x22, 0x66, 0x11, 0xAA, 0xAA, 0x00, 0xE5
	.db 0x7A, 0x00, 0x60, 0x00, 0x66, 0x22, 0x66, 0x11, 0xAA, 0x99, 0x88, 0xE5
	.db 0x7A, 0x00, 0x60, 0x00, 0x66, 0xAA, 0x66, 0x11, 0x99, 0x88, 0x44, 0xE5
	.db 0x7A, 0x30, 0xF0, 0xC0, 0x66, 0xAA, 0x66, 0x11, 0x99, 0x88, 0x44, 0xE5
	.db 0x7A, 0x30, 0xF0, 0xC0, 0x11, 0x55, 0xFF, 0x99, 0x88, 0xBB, 0x88, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE5
	.db 0x7B, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xED
	.db 0x78, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE1
	.db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F


MATCH2:
	.db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
	.db 0x78, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE1
	.db 0x7B, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xED
	.db 0x7A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x52, 0x48, 0x42, 0x00, 0x5A, 0x1A, 0x42, 0x5A, 0x52, 0x48, 0xE5
	.db 0x7A, 0x25, 0xA4, 0x24, 0x01, 0xA5, 0xA1, 0x24, 0xA5, 0x24, 0x02, 0xE5
	.db 0x7A, 0x42, 0x12, 0x42, 0x10, 0x08, 0x1A, 0x42, 0x48, 0x42, 0x20, 0xE5
	.db 0x7A, 0x24, 0x21, 0x24, 0x01, 0x80, 0xA1, 0x20, 0x84, 0x24, 0x02, 0xE5
	.db 0x7A, 0x42, 0x12, 0x42, 0x10, 0x08, 0x1A, 0x02, 0x5A, 0x4A, 0x60, 0xE5
	.db 0x7A, 0x25, 0xA4, 0x24, 0x01, 0xA5, 0xA1, 0x20, 0xB4, 0x25, 0x84, 0xE5
	.db 0x7A, 0x52, 0x48, 0x42, 0x10, 0x5A, 0x1A, 0x4A, 0x48, 0x52, 0x48, 0xE5
	.db 0x7A, 0x24, 0x00, 0x24, 0x01, 0x80, 0x80, 0x24, 0x84, 0x24, 0x04, 0xE5
	.db 0x7A, 0x42, 0x00, 0x52, 0x58, 0x08, 0x18, 0x4A, 0x48, 0x42, 0x42, 0xE5
	.db 0x7A, 0x24, 0x00, 0x25, 0xA5, 0x80, 0xA1, 0x84, 0xA5, 0x24, 0x20, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x34, 0xF0, 0xC2, 0x66, 0x22, 0xFF, 0xDD, 0x88, 0x88, 0x00, 0xE5
	.db 0x7A, 0x34, 0xF0, 0xC2, 0x66, 0x22, 0x66, 0x11, 0xCC, 0x99, 0xCC, 0xE5
	.db 0x7A, 0x10, 0x90, 0x80, 0x66, 0x22, 0x66, 0x11, 0xCC, 0xAA, 0x00, 0xE5
	.db 0x7A, 0x10, 0x90, 0x80, 0x66, 0x22, 0x66, 0x11, 0xAA, 0xAA, 0x00, 0xE5
	.db 0x7A, 0x10, 0x90, 0x80, 0x66, 0x22, 0x66, 0x11, 0xAA, 0x99, 0x88, 0xE5
	.db 0x7A, 0x10, 0x90, 0x80, 0x66, 0xAA, 0x66, 0x11, 0x99, 0x88, 0x44, 0xE5
	.db 0x7A, 0x34, 0xF0, 0xC2, 0x66, 0xAA, 0x66, 0x11, 0x99, 0x88, 0x44, 0xE5
	.db 0x7A, 0x34, 0xF0, 0xC2, 0x11, 0x55, 0xFF, 0x99, 0x88, 0xBB, 0x88, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE5
	.db 0x7B, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xED
	.db 0x78, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE1
	.db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F


CREDITSCREEN:
	.db 0xAF, 0xAF, 0xAF, 0xAF, 0xAF, 0xAF, 0xAF, 0xAF, 0xAF, 0xAF, 0xAF, 0xAF
	.db 0x78, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF1
	.db 0xFB, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xED
	.db 0x7A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF5
	.db 0xFA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0xF5
	.db 0xFA, 0x02, 0x02, 0x07, 0x02, 0x02, 0x30, 0x06, 0x01, 0x08, 0x00, 0xE5
	.db 0x7A, 0x03, 0x06, 0x08, 0x0A, 0x02, 0x30, 0x34, 0x01, 0x08, 0x00, 0xF5
	.db 0xFA, 0x02, 0x0A, 0x08, 0x0A, 0x02, 0x30, 0x31, 0x89, 0x08, 0x00, 0xE5
	.db 0x7A, 0x02, 0x0A, 0x08, 0x0A, 0x02, 0x30, 0x11, 0x89, 0x08, 0x00, 0xF5
	.db 0xFA, 0x02, 0x02, 0x0F, 0x0B, 0x0E, 0x30, 0x00, 0x01, 0x08, 0x00, 0xE5
	.db 0x7A, 0x02, 0x02, 0x08, 0x0A, 0x02, 0x30, 0x00, 0x01, 0x08, 0x00, 0xF5
	.db 0xFA, 0x02, 0x02, 0x08, 0x0A, 0x02, 0x30, 0x00, 0x01, 0x08, 0x00, 0xE5
	.db 0x7A, 0x02, 0x02, 0x08, 0x0A, 0x02, 0x00, 0x00, 0x01, 0x08, 0x00, 0xF5
	.db 0xFA, 0x02, 0x02, 0x08, 0x0A, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF5
	.db 0xFA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x30, 0x80, 0xE0, 0x40, 0x40, 0xE0, 0x00, 0xF5
	.db 0xFA, 0x00, 0x66, 0x00, 0x20, 0x50, 0x10, 0x40, 0x50, 0x10, 0x00, 0xE5
	.db 0x7A, 0x00, 0x66, 0x00, 0x20, 0x50, 0x10, 0x60, 0x50, 0x00, 0x00, 0xF5
	.db 0xFA, 0x10, 0x90, 0x80, 0x30, 0x90, 0x10, 0x50, 0x50, 0x70, 0x00, 0xE5
	.db 0x7A, 0x10, 0x90, 0x80, 0x20, 0x10, 0x10, 0x40, 0xD0, 0x10, 0x00, 0xF5
	.db 0xFA, 0x06, 0x00, 0x06, 0x20, 0x10, 0x10, 0x40, 0x50, 0x10, 0x00, 0xE5
	.db 0x7A, 0x06, 0x00, 0x06, 0x20, 0x00, 0xE0, 0x40, 0x40, 0xF0, 0x00, 0xF5
	.db 0xFA, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF5
	.db 0xFA, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE5
	.db 0x7B, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFD
	.db 0xF8, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE1
	.db 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F
		
TENNISTEXT:
	.db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
	.db 0x78, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE1
	.db 0x7B, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xED
	.db 0x7A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x70, 0xD0, 0xF0, 0x40, 0x50, 0x10, 0x70, 0x30, 0xC0, 0x00, 0xE5
	.db 0x7A, 0x10, 0x10, 0x00, 0x40, 0x50, 0x10, 0x20, 0x40, 0x00, 0x00, 0xE5
	.db 0x7A, 0x10, 0x10, 0x20, 0x60, 0x50, 0x90, 0x20, 0x40, 0x00, 0x00, 0xE5
	.db 0x7A, 0x10, 0x10, 0xE0, 0x50, 0x50, 0x50, 0x20, 0x30, 0x81, 0x08, 0xE5
	.db 0x7A, 0x10, 0x10, 0x00, 0x40, 0xD0, 0x30, 0x20, 0x00, 0x41, 0x08, 0xE5
	.db 0x7A, 0x10, 0x10, 0x00, 0x40, 0x50, 0x10, 0x20, 0x00, 0x41, 0x08, 0xE5
	.db 0x7A, 0x10, 0x10, 0xF0, 0x40, 0x50, 0x10, 0x70, 0x70, 0x90, 0x80, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x80, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x80, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x80, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x80, 0xE5
	.db 0x7A, 0x01, 0x01, 0x0C, 0x00, 0x0E, 0x03, 0x0B, 0x0E, 0x10, 0x80, 0xE5
	.db 0x7A, 0x03, 0x01, 0x02, 0x00, 0x09, 0x04, 0x04, 0x08, 0x01, 0x08, 0xE5
	.db 0x7A, 0x05, 0x01, 0x01, 0x00, 0x09, 0x04, 0x04, 0x0B, 0x09, 0x08, 0xE5
	.db 0x7A, 0x01, 0x01, 0x01, 0x06, 0x0E, 0x07, 0x0C, 0x0A, 0x01, 0x08, 0xE5
	.db 0x7A, 0x01, 0x01, 0x01, 0x00, 0x09, 0x04, 0x04, 0x09, 0x00, 0x00, 0xE5
	.db 0x7A, 0x01, 0x01, 0x02, 0x00, 0x09, 0x04, 0x04, 0x08, 0x08, 0x00, 0xE5
	.db 0x7A, 0x07, 0x0D, 0x0C, 0x00, 0x0E, 0x04, 0x04, 0x0B, 0x08, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE5
	.db 0x7B, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xED
	.db 0x78, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE1
	.db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
	
SOCCERTEXT:
	;          0    4    8    12   16   20 	 24   28   32   36
	.db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
	.db 0x78, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE1
	.db 0x7B, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xED
	.db 0x7A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x30, 0xC0, 0xE0, 0x30, 0x90, 0xD0, 0xE0, 0xF0, 0x00, 0x00, 0xE5
	.db 0x7A, 0x40, 0x10, 0x10, 0x40, 0x20, 0x10, 0x00, 0x80, 0x80, 0x00, 0xE5
	.db 0x7A, 0x40, 0x10, 0x10, 0x40, 0x20, 0x10, 0x00, 0x80, 0x80, 0x00, 0xE5
	.db 0x7A, 0x30, 0x90, 0x10, 0x40, 0x20, 0x10, 0xC0, 0xF0, 0x01, 0x08, 0xE5
	.db 0x7A, 0x00, 0x50, 0x10, 0x40, 0x20, 0x10, 0x00, 0xA0, 0x01, 0x08, 0xE5
	.db 0x7A, 0x00, 0x50, 0x10, 0x40, 0x20, 0x10, 0x00, 0x90, 0x01, 0x08, 0xE5
	.db 0x7A, 0x70, 0x80, 0xE0, 0x30, 0x90, 0xD0, 0xE0, 0x80, 0x90, 0x80, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x84, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x16, 0x86, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x16, 0x86, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x84, 0xE5
	.db 0x7A, 0x03, 0x09, 0x0C, 0x00, 0x0E, 0x03, 0x0B, 0x0E, 0x10, 0x80, 0xE5
	.db 0x7A, 0x04, 0x05, 0x02, 0x00, 0x09, 0x04, 0x04, 0x08, 0x01, 0x08, 0xE5
	.db 0x7A, 0x00, 0x05, 0x01, 0x00, 0x09, 0x04, 0x04, 0x0B, 0x09, 0x08, 0xE5
	.db 0x7A, 0x00, 0x09, 0x01, 0x06, 0x0E, 0x07, 0x0C, 0x0A, 0x01, 0x08, 0xE5
	.db 0x7A, 0x01, 0x01, 0x01, 0x00, 0x09, 0x04, 0x04, 0x09, 0x00, 0x00, 0xE5
	.db 0x7A, 0x02, 0x01, 0x02, 0x00, 0x09, 0x04, 0x04, 0x08, 0x08, 0x00, 0xE5
	.db 0x7A, 0x07, 0x0D, 0x0C, 0x00, 0x0E, 0x04, 0x04, 0x0B, 0x08, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE5
	.db 0x7A, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE5
	.db 0x7B, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xED
	.db 0x78, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xE1
	.db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
	
;******* end SCREEN patterns ********************************************************


;******* SOUND patterns ***********************************************************
TONETABLE:
	.dw 	(fREF/26163)	; fC1 = 0
	.dw	(fREF/27718)	; fCIS1 = 1
	.dw	(fREF/27718)	; fDES1 = 2
	.dw	(fREF/29367)	; fD1 	= 3
	.dw	(fREF/31113)	; fDIS1 = 4
	.dw	(fREF/31113)	; fES1 	= 5
	.dw	(fREF/32963)	; fE1	= 6
	.dw	(fREF/34923)	; fF1	= 7
	.dw	(fREF/36999)	; fFIS1	= 8
	.dw	(fREF/36999)	; fGES1	= 9
	.dw	(fREF/39200)	; fG1	= 10
	.dw	(fREF/41530)	; fGIS1	= 11
	.dw	(fREF/41530)	; fAS1	= 12
	.dw	(fREF/44000)	; fA1	= 13
	.dw	(fREF/46616)	; fAIS1	= 14
	.dw	(fREF/46616)	; fB1	= 15
	.dw	(fREF/49388)	; fH1	= 16
	.dw	(fREF/52325)	; fC2	= 17
	.dw	0xFFFF		; fPAUSE = 18

	.dw 	(fREF/26163*2)	; fC0 = 19
	.dw	(fREF/27718*2)	; fCIS0 = 20
	.dw	(fREF/27718*2)	; fDES0 = 21
	.dw	(fREF/29367*2)	; fD0 	= 22
	.dw	(fREF/31113*2)	; fDIS0 = 23
	.dw	(fREF/31113*2)	; fES0 	= 24
	.dw	(fREF/32963*2)	; fE0	= 25
	.dw	(fREF/34923*2)	; fF0	= 26
	.dw	(fREF/36999*2)	; fFIS0	= 27
	.dw	(fREF/36999*2)	; fGES0	= 28
	.dw	(fREF/39200*2)	; fG0	= 29
	.dw	(fREF/41530*2)	; fGIS0	= 30
	.dw	(fREF/41530*2)	; fAS0	= 31
	.dw	(fREF/44000*2)	; fA0	= 32
	.dw	(fREF/46616*2)	; fAIS0	= 33
	.dw	(fREF/46616*2)	; fB0	= 34
	.dw	(fREF/49388*2)	; fH0	= 35
	.dw	(fREF/50857*2)	; fCES1	= 36


SOUND1:
	.db tC2, d16  
	.db 0,0
	.db tC1, d4  
	.db tC1, d4p 
	.db tD1, d8  
	.db tE1, d4  
	.db tF1, d2p 
	.db tF1, d2  
	.db tB1, d4  
	.db tA1, d4p 
	.db tG1, d8  
	.db tA1, d4  
	.db tE1, d4p 
	.db tD1, d8  
	.db tE1, d4  
	.db tF1, d2p 
	.db tF1, d2p

	.db tC1, d2  
	.db tC1, d4  
	.db tC1, d4p 
	.db tD1, d8  
	.db tE1, d4  
	.db tF1, d2p 
	.db tF1, d2  
	.db tB1, d4  
	.db tA1, d4p 
	.db tG1, d8  
	.db tA1, d4  
	.db tE1, d4p 
	.db tD1, d8  
	.db tE1, d4  
	.db tF1, d2p 
	.db tF1, d2p
	 
	.db tA1, d2  
	.db tA1, d4  
	.db tA1, d4p 
	.db tG1, d8  
	.db tF1, d4  
	.db tG1, d2p 
	.db tG1, d2p 
	.db tG1, d2p 
	.db tG1, d4p 
	.db tF1, d8  
	.db tE1, d4  
	.db tD1, d2p 
	.db tD1, d2  
	.db tE1, d4  
	.db tF1, d4p 
	.db tG1, d8  
	.db tF1, d4  

	.db tE1, d4p 
	.db tD1, d8  
	.db tE1, d4  
	.db tF1, d4p 
	.db tG1, d8  
	.db tF1, d4  
	.db tE1, d4p 
	.db tD1, d8  
	.db tE1, d4  
	.db tD1, d2  
	.db tC1, d4  
	.db tCES1, d4p 
	.db tA0, d8  
	.db tB0, d4  
	.db tC1, d2p 
	.db tC1, d2p 
	.db 0,0	
	
SOUND_BAT1:
	.db tC1,4,0,0
SOUND_BAT2:
	.db tG1,4,0,0	

SOUND_GOAL1:
	.db tC1,4
	.db tD1,4
	.db tE1,4
	.db 0,0	
SOUND_GOAL2:
	.db tG1,4
	.db tA1,4
	.db tH1,4
	.db 0,0	


SOUND_MATCH2:
BUTZEMANN:
	.db tC1, d8	;

	.db tF1, d8	;
	.db tF1, d8
	.db tC2, d8
	.db tC2, d8

	.db tA1, d8	;
	.db tA1, d8
	.db tF1, d8
	.db tF1, d8

	.db tG1, d8
	.db tG1, d8
	.db tC1, d8
	.db tC1, d8

	.db tF1, d4p
	.db tC1, d8

	.db tF1, d8
	.db tF1, d8
	.db tC2, d8
	.db tC2, d8
	.db tA1, d8
	.db tA1, d8
	.db tF1, d8
	.db tF1, d8
	.db tG1, d8
	.db tG1, d8
	.db tC1, d8
	.db tC1, d8
	.db tF1, d4p
	.db tA1, d8
	.db tG1, d8p
	.db tA1, d16
	.db tB1, d8
	.db tG1, d8
	.db tA1, d8p
	.db tB1, d16
	.db tC2, d8
	.db tA1, d8
	.db tG1, d8
	.db tA1, d8
	.db tB1, d8
	.db tG1, d8
	.db tA1, d8p
	.db tB1, d16
	.db tC2, d8
	.db tC1, d8

	.db tF1, d8
	.db tF1, d8
	.db tC2, d8
	.db tC2, d8

	.db tA1, d8
	.db tA1, d8
	.db tF1, d8
	.db tF1, d8

	.db tG1, d8
	.db tG1, d8
	.db tC1, d8
	.db tC1, d8

	.db tF1, d4p
	
	.db 0,0	

SOUND_MATCH1:
BIENCHEN:
	.db tC2, d4  
	.db tB1, d4  
	.db tA1, d2  
	.db tG1, d8  
	.db tA1, d8  
	.db tB1, d8  
	.db tG1, d8  
	.db tF1, d2  
	.db tA1, d8  
	.db tB1, d8  
	.db tC2, d8  
	.db tA1, d8  
	.db tG1, d8  
	.db tA1, d8  
	.db tB1, d8  
	.db tG1, d8  
	.db tA1, d8  
	.db tB1, d8  
	.db tC2, d8  
	.db tA1, d8  
	.db tG1, d8  
	.db tA1, d8  
	.db tB1, d8  
	.db tG1, d8  
	.db tC2, d4  
	.db tB1, d4  
	.db tA1, d2  
	.db tG1, d8  
	.db tA1, d8  
	.db tB1, d8  
	.db tG1, d8  
	.db tF1, d1  
;.db tx1, d8  
	.db 0,0	


;******* end SOUND patterns ********************************************************
	