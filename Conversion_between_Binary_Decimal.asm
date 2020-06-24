; HARIZAH SYAWAL
; ADLIN SHAFLINA
; ZHAOSONG

INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data

str13 byte "                                     ", 0
str14 byte "                                     ", 0
str3 byte ">>> Please Select the conversion type:", 0
str4 byte "1 - Binary to decimal", 0
str5 byte "2 - Decimal to binary", 0
str6 byte "3 - Exit", 0
str12 byte "--------------------------------------", 0
str7 byte "Enter Your Choice: ", 0
str8 byte "Please Enter 8-bit binary digits (e.g., 11110000):", 0
str9 byte "Please enter the decimal integer less than 256 :", 0
str10 byte "The binary is :", 0
str11 byte "The decimal integer is: ", 0

msgNotBinary byte "Invalid Binary can contain only 0's and 1's",0

strBye byte "Bye", 0

icz dword 1; determine the choice and to detect input
ucz dword 3; detect input

strbin dword 9 dup(? )

binaryNumber byte 33 DUP(?)   ; 32 characters for 32-bit Binary 
NumberLength dword 0
base dword 2           ; Base of Binary Number
DecimalNumber dword ?
OuterLoopCount dword 0		
		
.code
main PROC

outerLoop : ; loop the question
mov edx, offset str14
call writestring
call crlf
mov edx, offset str13
call writestring
call crlf
mov edx, offset str3
call writestring
call crlf
mov edx, offset str4
call writestring
call crlf
mov edx, offset str5
call writestring
call crlf
mov edx, offset str6
call writestring
call crlf
mov edx, offset str12
call writestring
call crlf

wrongin : ; looping
mov eax, 0; input must between 1, 2 or 3
mov edx, offset str7
call writestring
call readint
cmp eax, icz
jl wrongin
cmp eax, ucz
jg wrongin
je op3    ;exit
cmp eax, icz
je op1
jmp op2

; Ifand /or while section

; OPTION 1

op1:
mov edx, OFFSET str8
call WriteString

mov edx,OFFSET binaryNumber
mov ecx,SIZEOF binaryNumber  ; length of binaryNumber
call ReadString              ; Reads a string 
mov NumberLength,eax         ; Number of characters read

; Find Decimal Number

mov eax,0
mov esi,0                             ; ESI  initialize with zero
mov ecx, NumberLength                 ; ECX  initialize with length of Number

whilePart:
cmp ecx,0                             ; Compare ECX and 0
je displayNumbers                     ; Jump if number is 0
mov OuterLoopCount,ecx         

ifPart:
cmp binaryNumber[esi],'0'           ; Compare binaryNumber[esi] and '0'
je IncEsi                           ; jump if equal (==)
			                     ;Multiplying by zero, equal to zero. do nothing in this case

elseIfPart:
cmp binaryNumber[esi],'1'           ; Compare binaryNumber[esi] and '1'
jne elsePart                        ; if not equal then it is invalid.in other words it is neither 0 nor 1

;Calculate pow(base, NumberLength -ESI-1) and add them to eax

mov ecx, NumberLength
sub ecx,esi
dec ecx

; Calculate Power
mov eax,1                           ; EAX initialize with 1
whilePart2:
cmp ecx,0                           ; Compare ECX and 0
je stop                             ; jump if equal (==)
 
; Multiply EAX and EBX and save result in EAX
mov ebx,base
mul ebx
dec ecx
jmp whilePart2
; Calculate Power finish

stop:
add DecimalNumber,eax
jmp IncEsi

elsePart:
mov edx, OFFSET msgNotBinary  ; "Invalid Binary Number, Binary Number Contains only 0's or 1's"
call WriteString
call Crlf  
jmp outerLoop
call Crlf
call WaitMsg    ; Displays a message and waits for a key to be pressed.


IncEsi:
inc esi
mov ecx,OuterLoopCount 
dec ecx
jmp WhilePart

displayNumbers:
mov edx, OFFSET str11 
call WriteString

mov edx, 0
mov eax, DecimalNumber
call WriteDec              

call Crlf                          

mov edx, 0
mov eax, DecimalNumber
     
jmp outerLoop
call Crlf
call WaitMsg

	
	
; OPTION 2

op2:
mov edx, offset str9
call writeString
call readDec
mov edx, offset str10
call writeString
mov ebx, 1
call writeBinB
call Crlf
call WaitMsg

jmp outerLoop
call Crlf
call WaitMsg

; OPTION 3
op3:
mov edx, offset strBye
call crlf
call writeString

exit

main ENDP
END main