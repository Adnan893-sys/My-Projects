;programme for  special addition
dosseg
.model small
.stack 100h
.data
ans2 dw 3 dup(?)            ;variables to store values
new  dw 3 dup(?)
z1   dw 3 dup(?)
z2   dw 3 dup(?)
real dw 3 dup(?)
sum1 dw 3 dup(?)
ans1 db 3 dup(?)
ans3 db 5 dup(?)
num1 dw 3 dup(?)
temp dw 3 dup(?)
add1 dw 3 dup(?)
str1 db 'Enter binary number:$'
str2 db 'Series Sum=$'
.code
;#####################################
;this  macro prints number which is passed to it
print macro P1
mov dl,P1    ;number to be printed
add dl,48    ;convert to ascii 
mov ah,2     ; mov 2 to ah for printing
int 21h
endm
;##############################
addsign proc
mov dl,43    ;for addsign 
mov ah,2     ; mov 2 to ah for printing
int 21h
ret
addsign endp
;#########################################
BOpen proc
mov dl,40    ;for bracket opening 
mov ah,2     ; mov 2 to ah for printing
int 21h
ret
BOpen endp
;#########################################
BClose proc
mov dl,41    ;for bracket closing 
mov ah,2     ; mov 2 to ah for printing
int 21h
ret
BClose endp
;#########################################
equal proc
mov dl,61    ;for equal to sign
mov ah,2     ; mov 2 to ah for printing
int 21h
ret
equal endp
;#####################
;this procedure  checks and removes extra zeros from the number
check proc
mov al,ans1[2]   
cmp al,0         ;if equal to zero
je second        ;jump to second label
print ans1[2]    ;show digit
print ans1[1]    ;show digit
print ans1[0]    ;show digit
jmp go
second:
mov al,ans1[1]
cmp al,0         ;if equal to zero
je first         ;jump to first label
print ans1[1]    ;show digit
print ans1[0]    ;show digit
jmp go
first:
mov al,ans1[0]
cmp al,0          ;if equal to zero
je go             ;jump to go
print ans1[0]     ;else print only one number
jmp go
go:
ret
check endp
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
call check
endm
;#################################
show1 macro P3
lea si,ans3      ;address of array where input to be saved
mov ax,P3        ;mov entered number to ax
mov dx,0
mov bx,10        ; mov 10 to bl
div bx           ;divide by 10        
mov ans3[0],dl   
mov bx,10
mov dx,00
div bx      ;divide by 10
mov ans3[1],dl
mov temp[0],ax
endm
;##t###############################
print1 proc
mov ax,@data
mov ds,ax
lea dx, str1      ;printing sting1
mov ah,9h         ;9h for string printing
int 21h
ret
print1 endp
;#########################
print2 proc
mov ax,@data
mov ds,ax
lea dx, str2         ;printing sting1
mov ah,9h            ;9h for string printing
int 21h
ret
print2 endp
;##########################
;this procedure takes input in binary and converts that into decimal
takeinput proc
  mov dl,128              ;128 for mcb
  mov bx,0
  mov cl,2                ;for division after every number
scannum:
    mov ah,1h             ;for input  
    int 21h
    cmp al,13             ;compare it either enter pressed
    je exit               ;if pressed then exit
    mov ah,0              ;if not then 
    sub al,48             ;covert ascii to decimal by subtracting 48
    mul dl                ;multiply by dl
    add bx,ax             ;and add it with bx
    mov al,dl
    div cl                ;divide by 2
    mov dl,al             ;save remainder again in dl
    jmp scannum
exit:
     ret
takeinput endp
;#######################
;this macro takes number and makes its adding starting from 1 to that number
series macro S1
call BOpen          ;start small bracket
mov ax,S1           ;pass number
mov ans2[0],ax      ; save that number in the array
mov ax,0
mov sum1[0],ax
mov bx,0
mov z1[0],bx
back1:
mov bx,z1[0]
add bx,1             ;add 1 to bx
mov z1[0],bx         ;save tha number to z1 array
add sum1[0],bx
show z1[0]           ;show that number
mov ax,ans2[0]       
mov bx,z1[0]
cmp bl,al            ; compare current number with actual
je next              ; if became equal the next
call addsign         ; add addsign and go back
jmp back1            ; jump to back1 label
next:
call BClose
endm
;#############################
;###########################
main proc
mov ax,0
mov new[0],ax          ;clear array
call print1            ;write initial line    
call takeinput         ;take input in binary and convert that
mov real[0],bx         ;save tha numbe into real array
call print2            ;write line for special sum
mov ax,1
mov z2[0],ax           ;start from 1
again:
series z2[0]           ;print that number into series
mov ax,sum1[0]         ;sum the number with previous one
add new[0],ax         
mov bx,real[0]
mov ax,z2[0]
cmp al,bl               ;compare current and previous number
je next1                ;if equal goto  for final sum
add ax,1                ; else go back for loop again
mov z2[0],ax            ;save the copy of this number in array    
call addsign            ;call addsign
jmp again               ;jump at again label
next1:
call finalout           ;call final out for printing addition result
mov ah,4ch              ;terminate programme
int 21h
main endp
;##################
;#################
finalout proc
call equal                 ;call equal sign
mov bx,new[0]              ;for 1st digit and 2nd digit
show1 bx
mov bx,temp[0]
show bx                    ;show 3LSBs of number
print ans3[1]    ;show digit Msb
print ans3[0]    ;show digit Msb
ret
finalout endp
;################################
end main
