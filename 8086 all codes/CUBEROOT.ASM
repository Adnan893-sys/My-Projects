dosseg
.model small
;#####################################
;this  macro prints number which is passed to it
print macro P1
mov dl,P1    ;number to be printed
add dl,48    ;convert to ascii 
mov ah,2     ; mov 2 to ah for printing
int 21h
endm
;#############################################
;this macro shows the number entered passed to it
;1st it will divide the number by 10 and then
;display that number on scren digit by digit

show macro P2
lea si,ans1      ;address of array where input to be saved
mov ax,P2        ;mov entered number to ax
mov bl,10        ; mov 10 to bl
div bl           ;divide by 10
mov cl,al        
mov ans1[0],ah   
mov bl,10
mov ah,00
mov al,cl
div bl      ;divide by 10
mov cl,al
mov ans1[1],ah   
mov ans1[2],cl
print ans1[2]    ;show digit
print ans1[1]    ;show digit
print ans1[0]    ;show digit
endm
;#################################
;for checking 1st number as 1
check macro K1,K2
     mov cl,K1
     mul cl
     mul cl
     sub ax,K2
     jnz next
     print cube[0]
     jmp here
     endm
;######################################
;for 8
check1 macro K3,K4
     mov cl,K3
     mul cl
     mul cl
     sub ax,K4
     jnz next1
     print cube[0]
     jmp here
     endm
;#######################
;for 27
check2 macro K5,K6
     mov cl,K5
     mul cl
     mul cl
     sub ax,K6
     jnz next2
     print cube[0]
     jmp here
     endm
;###################
;for 64
check3 macro K7,K8
     mov cl,K7
     mul cl
     mul cl
     sub ax,K8
     jnz next3
     print cube[0]
     jmp here
     endm
;###########################
;for 125
check4 macro Z1,Z2
     mov cl,Z1
     mul cl
     mul cl
     sub ax,Z2
     jnz next4
     print cube[0]
     jmp here
     endm
;##########################################
check5 macro Z3,Z4
     mov cl,Z3
     mul cl
     mul cl
     sub ax,Z4
     jnz next5
     print cube[0]
     jmp here
     endm
;###################################
check6 macro Z5,Z6
     mov cl,Z5
     mul cl
     mul cl
     sub ax,Z6
     jnz next6
     print cube[0]
     jmp here
     endm
;#######################################
;this is the alg which is craeting iterations
   iteration macro G1,G2
      mov cl,2
      mov al,G1
      mul cl
     mov bl,3
     div bl 
     mov cube[0],al
     endm

 
;#########################################

;#####################################
.stack 100h
.data
ans1 db 3 dup(?)
ans2 dw 3 dup(?)
cube db 3 dup(?)
set dw 3 dup(?)
save1 dw 3 dup(?)
str1 db 'Enter perfect cube:$'
str2 db 'The cube root is:$'

.code
;##########################
;this procedure prints 2nd string
print2 proc
mov ax,@data
mov ds,ax
lea dx, str2
mov ah,9h
int 21h
ret
print2 endp
;########################################################
; this procedure prints 1st string
print1 proc
mov ax,@data
mov ds,ax
lea dx, str1
mov ah,9h
int 21h
ret
print1 endp

;####################################################
;this procedure takes input from user,convert them to digit 
;from ascii and form them as digits by multiplying and adding them
takeinput proc
  mov dl,10
  mov bl,0
scannum:
    mov ah,1h    
    int 21h
    cmp al,13
    je exit
    mov ah,0
    sub al,48
    mov cl,al
    mov al,bl
    mul dl
    add al,cl
    mov bl,al
    jmp scannum
exit:
     ret
takeinput endp

;###########################################
;this is main procedure from where all functions are called
main proc
   call print1      ; call print1 for showing string
    call takeinput   ; take input from user
    mov ans2[0],bx   ; store that input to this array location
    call print2      ; print second string
     
;***************************************************************
 ;for 1st iteration
     mov bx,ans2[0]
     mov cx,2
     add bx,cx
     mov ax,bx
     mov bl,3
     div bl
     mov cube[0],al
     cmp al,23
     jnae do
     iteration cube[0],ans2[0]
     iteration cube[0],ans2[0]
     iteration cube[0],ans2[0]
     jmp next2
do:
     check cube[0],ans2[0]

;********************************************
;This is for second iteration

next:
     iteration cube[0],ans2[0]
     check1 cube[0],ans2[0]

;*******************************************
;This is for third iteration

next1:
     iteration cube[0],ans2[0]
     check2 cube[0],ans2[0]
;*******************************************
;This is for 4th iteration
next2:
     iteration cube[0],ans2[0]
     mov ax,ans2[0]
     cmp ax,27
     jne go
     mov al,cube[0]
     add al,1
     mov cube[0],al

go:    check3 cube[0],ans2[0]

;*************************************
;This is for 5th iteration
next3:
     iteration cube[0],ans2[0]
     check4 cube[0],ans2[0]

;************************************
;For 6th iteration
next4:
     iteration cube[0],ans2[0]
     check5 cube[0],ans2[0]

;************************************
;for 7th iteration
next5:
     iteration cube[0],ans2[0]
     check6 cube[0],ans2[0]
;**************************************
;for 8th iteration
next6:    
     jmp here
here:
     mov ah,4ch
     int 21h
     main endp

end main
;####################################################

