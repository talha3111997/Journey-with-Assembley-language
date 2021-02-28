

;---------------------------------------------------------------------------;
;                       Constant Initilization                              ;
;---------------------------------------------------------------------------;

LCD_Data    equ P2      ; Data bus 
LCD_BusyF   equ P2.7    ; Busy flag of LCD that is at D7
LCD_RegS    equ P3.2    ; register select (RS)
LCD_RW      equ P3.3    ; Read or write
LCD_En      equ P3.4    ; LCD Enable 
Col4        equ P1.0    ; keypad column pins to Port 1 lower nibble 
Col3        equ P1.1    ;
Col2        equ P1.2    ;
Col1        equ P1.3    ;
Row4        equ P1.4    ; keypad row pins to port 1 higher nibble 
Row3        equ P1.5    ;
Row2        equ P1.6    ;
Row1        equ P1.7    ;
N1          equ 30h     ; First Number Memory Location 
N2          equ 31h     ; Second Number Memory Location 
temp1       equ 32h     ; temporary Location 1
Operation   equ 33h     ; Operator Memory Location 
temp2       equ 34h     ; temporary Location 2 
	

; initilize program origne to 0x0000
ORG 0

;---------------------------------------------------------------------------;
;                    Initilize 16x2 LCD Display                             ;
;---------------------------------------------------------------------------;

LCD_Initilization: 
	mov LCD_Data,#38H           ; for using 2 lines and 5X7 matrix of LCD
	clr LCD_RegS                ; TO SELECT COMMAND REGISTER
	clr LCD_RW                  ; TO WRITE
	setb LCD_En                 ;  
	acall Delay                 ;
    clr LCD_En                  ; SO from high to low pulse data would be send to LCD 
    Lcall Delay                 ; SO , necessay delay between two commands for the execusion of both commands
    mov LCD_Data, #0FH          ; to on the cursor
    clr LCD_RegS                ; TO SELECT COMMAND REGISTER
    clr LCD_RW                  ; TO WRITE
    setb LCD_En                 ;
    acall Delay                 ;
    CLR LCD_En                  ;
    LCALL Delay                 ;
    mov LCD_Data, #01H          ; TO clear the screen
    clr LCD_RegS                ; TO SELECT COMMAND REGISTER
    clr LCD_RW                  ; TO WRITE
    setb LCD_En                 ;
    aCALL Delay                 ;
    clr LCD_En                  ;
							
							
					
Command:					
	mov LCD_Data, #06H; to go to first line and 0th position in LCD
	clr LCD_RegS; TO SELECT COMMAND REGISTER
	clr LCD_RW; TO WRITE
	setb LCD_En;
	
	aCALL Delay;
	clr LCD_En;					
    mov R1, #03;


main:	
	inc R1; to make it infinite loop
	LCALL delay;
	
	LCALL delay;
	setb Col1;
	setb Col2;
	setb Col3;
	setb Col4;
	clr Row1;
	clr Row2;
	clr Row3;
	clr Row4;
	jnb Col1,row_finder1; 
	jnb Col2,row_finder2; 
	jnb Col3,row_finder3; 
	jnb Col4,row_finder4; 
	
	DJNZ R1, main;
					
					
					

;---------------------------------------------------------------------------;
;                       Send Data to LCD Display                            ;
;---------------------------------------------------------------------------;
				
lcd_show_data:      
	mov LCD_Data, R3; 
	setb LCD_RegS;
	clr LCD_RW;
	
	
	SETB LCD_En;
	acall Delay;
	
	CLR LCD_En;
	
	LCALL Delay;
	push 7;
					
	acall command;

					


;---------------------------------------------------------------------------;
;                          Read Keypad Input                                ;
;---------------------------------------------------------------------------;

row_finder1: 
	setb Row1;
	setb Row2;
	setb Row3;
	setb Row4;
	clr Col1;
	clr Col2;
	clr Col3;
	clr Col4;
	jnb Row1, Ro1 
	jnb Row2, Ro2;
	jnb Row3, Ro3;
	jnb Row4, Ro4;
	ret;


row_finder2:

	setb Row1;
	setb Row2;
	setb Row3;
	setb Row4;
	clr Col1;
	clr Col2;
	clr Col3;
	clr Col4;
	jnb Row1, Ro5 
	jnb Row2, Ro6;
	jnb Row3, Ro7;
	jnb Row4, Ro8;
	ret;


row_finder3:
	setb Row1;
	setb Row2;
	setb Row3;
	setb Row4;
	clr Col1;
	clr Col2;
	clr Col3;
	clr Col4;
	jnb Row1, Ro9 
	jnb Row2, Ro10;
	jnb Row3, Ro11;
	jnb Row4, Ro12;	
    ret;


row_finder4:
	setb Row1;
	setb Row2;
	setb Row3;
	setb Row4;
	clr Col1;
	clr Col2;
	clr Col3;
	clr Col4;
	jnb Row1, Ro13 
	jnb Row2, Ro14;
	jnb Row3, Ro15;
	jnb Row4, Ro16;
	ret;

Ro1:	
	mov R3, #049; // to print 1
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #1;
	;push R7;
	Lcall lcd_show_data;

Ro2: 
	mov R3, #052; // 4
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #4;
	Lcall lcd_show_data;
Ro3:
	mov R3, #055;  // 7
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #7;
	call lcd_show_data;
Ro4:
	mov R3, #032;  // " " space
	mov A, R3;
	ANL		A, #0FH; converting ASCII  to BCD
	mov R7, A;
	;mov R7, #0;
	call lcd_show_data;
	
Ro5:
	mov R3, #050; // 2
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #2;
	call lcd_show_data;
Ro6:
	mov R3, #053; // to print 5 number
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #5;
	call lcd_show_data;
Ro7:
	mov R3, #056; // 8
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #8;
	call lcd_show_data;
	
Ro8:
	mov R3, #048; // 0
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #0;
	call lcd_show_data;


Ro9:
	mov R3, #051; // 3
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #3;
	call lcd_show_data;
Ro10:
	mov R3, #054; // to print 6 number
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #6;
	call lcd_show_data;
Ro11:
	mov R3, #057; // 9
	mov A, R3;
	ANL		A, #0FH;
	mov R7, A;
	;mov R7, #9;
	call lcd_show_data;
Ro12:
	mov R3, #061; // =
	;mov R7, #0;
	jmp result ;
	call lcd_show_data;
	
	
Ro13:
	mov R3, #045; //  - sign 
	mov operation , #'-';
	call lcd_show_data;
Ro14:
	mov R3, #042; // to print * number
	mov operation , #'*';
	call lcd_show_data;
Ro15:
	mov R3, #047; // for division sign /
	mov operation , #'/';
	call lcd_show_data;
Ro16:
	mov R3, #043; // + sign 
	mov operation , #'+';
	call lcd_show_data;
		



;---------------------------------------------------------------------------;
;                       Show the Result to Disaplay                         ;
;---------------------------------------------------------------------------;

result:       
    acall equal;
    acall delay;
    mov R5 , #0;
    mov R6, #0;

	pop 3;
	pop 3;
	
	pop 6; 1st number
	
	pop 3;
	pop 0;
	
	pop 1;
	pop 2;
		
	POP 5; 2nd number
	MOV A, operation;
    CJNE  A , #'+' , Next2;		
		
	mov A, R5;
	add  A , R6;
	;ADD		A,#30H ; converting to Ascii 
	;////////////////
	acall delay
	mov B, #00001010b;
	div AB; 
	;mov temp1 , A;
	
	ADD		A,#30H ;
	mov     R3, A;
	acall   delay;
	acall   result2;
	acall   delay;
	
	mov     A, B;
	ADD	    A,#30H ; converting to Ascii
	mov     R3, A;		
	acall   delay;
	acall   result2;
	acall   delay;
	acall   command;	
    MOV     A, operation;


Next2: 
    CJNE  A , #'-' , Next3;		
	mov A, R5;
	SUBB  A , R6;
	ADD		A,#30H ; converting to Ascii 
	mov R3, A;
	acall delay
	acall lcd_show_data;	
    MOV A, operation;

Next3:
    CJNE  A , #'*' , Next4;		
	MOV B , R6
	mov A, R5;
	MUL  AB;
	;ADD		A,#30H ; converting to Ascii 
	;mov R3, A;
	acall delay
	mov B, #00001010b;
	div AB; 
	;mov temp1 , A;
	
	ADD		A,#30H ;
	mov R3, A;
	acall delay;
	acall result2;
	acall delay;
	
	mov A, B;
	ADD		A,#30H ; converting to Ascii
	mov R3, A;		
	acall delay;
	acall result2;
	acall delay;
	acall command;
	MOV A, operation;	


Next4: 
    CJNE  A , #'/' , NEXTNOTHING;		
	mov B, R6;
	mov A, R5;
	DIV  AB;
	ADD		A,#30H ; converting to Ascii 
	mov R3, A;
	acall delay
	acall lcd_show_data;
    NEXTNOTHING:
    ret; 


result2:
	mov LCD_Data, R3; 
	setb LCD_RegS;
	clr LCD_RW;
	
	
	SETB LCD_En;
	acall Delay;
	
	CLR LCD_En;
	
	aCALL Delay;
	ret


equal:
	mov R3, #061;
	mov LCD_Data, R3; 
	setb LCD_RegS;
	clr LCD_RW;
	
	
	SETB LCD_En;
	acall Delay;
	
	CLR LCD_En;
	
	aCALL Delay;
	ret



;---------------------------------------------------------------------------;
;                       57.505us Delay Subroutine                           ;
;---------------------------------------------------------------------------;
	
Delay:
    mov R4, #255;

back2:	
	mov R2, #255;		

back1:				
	djnz R2,back1; to produce a delay of 50us approx. ((2*25)+1 + 2) * 1.085us = 57.505us
	djnz R4,back2;		
	ret;						

DoNothing:
	END;
