dosseg
.model small
.stack 100h
.data
var1 db 100 dup('$')
str1 db 'This is Palindrome$'
str2 db 'This is not Palindrome$'
.code

;#################################################################
;this procedure is to take input string from user

takeinput proc
mov ax, @data
mov ds,ax
mov si, offset var1    ;load adress of array in which vslue to be saved
l1:
mov ah,1               ;take input
int 21h                ;call interupt
cmp al,13              ;check either enter pressed
je programend          ;if yes then exit from taking number
mov [si],al            ;if not mov entered number to var1
inc si                 ;increment si
jmp l1                 ;goto l1
programend:            
Ret                    ;return
takeinput endp         ;end procedure
;##############################################################
;this procedur checks either entered string is palindrom or not
check proc
mov si, offset var1      ;load initial address of string to si 
loop1:
    mov ax,[si]          ;load char to ax
    cmp al,'$'           ;and check either it isenter key ascii or not
    je label1            ; if yes goto
    inc si               ;if not increment si and check second number
    jmp loop1            ;jump to loop tag
label1:  
     mov di, offset var1       ;load inital address to di
     dec si                    ;point si to last location before enterkey char
 ;check for palindrom
loop2:
     cmp si,di                  ;compare for to charcters
     je output1                 ;goto output tag
     mov ax,[si]                
     mov bx,[di]
     cmp al,bl
     jne output2                 ;if not equal goto output2 tag
     dec si                      ;decrement si
     inc di                      ;increment di
     jmp loop2                   ;goto loop2
;if string is palindrome
output1:
     lea dx,str1                 ;load adress of string1
     mov ah,9h                   ;load 9h to print string
     int 21h                     ;call input
     ret
;if string is not palindrome
output2:
     lea dx,str2                 ;load address of string2
     mov ah,9h                   ;load 9h to print string     
     int 21h                     ;call input
     ret
check endp

;###########################################################
main proc
CALL takeinput  ;take input from user
CALL check      ;check either its is palindrom or not
mov ah,4ch      ;dos commad for end
int 21h         ; call interupt
main endp       ;end main
end main        ;end all
