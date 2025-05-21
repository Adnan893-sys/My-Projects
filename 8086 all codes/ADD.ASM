;programme for  special addition
dosseg
.model small
.stack 100h
.data
ans2 dw 3 dup(?)
ans1 db 3 dup(?)
ans3 db 5 dup(?)
num1 dw 3 dup(?)
temp dw 3 dup(?)
add1 dw 3 dup(?)
str1 db 'Enter number:$'
str2 db 'Special Sum=$'
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
mov dl,43    ;convert to ascii 
mov ah,2     ; mov 2 to ah for printing
int 21h
ret
addsign endp
;#########################################
equal proc
mov dl,61    ;convert to ascii 
mov ah,2     ; mov 2 to ah for printing
int 21h
ret
equal endp
;#####################
check proc
mov al,ans1[2]
cmp al,0
je second
print ans1[2]    ;show digit
print ans1[1]    ;show digit
print ans1[0]    ;show digit
jmp go
second:
mov al,ans1[1]
cmp al,0
je first
print ans1[1]    ;show digit
print ans1[0]    ;show digit
jmp go
first:
mov al,ans1[0]
cmp al,0
je go
print ans1[0]
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
;#################################
print1 proc
mov ax,@data
mov ds,ax
lea dx, str1
mov ah,9h
int 21h
ret
print1 endp
;#########################
print2 proc
mov ax,@data
mov ds,ax
lea dx, str2
mov ah,9h
int 21h
ret
print2 endp
;##########################
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
    add ax,cx
    mov bx,ax
    jmp scannum
exit:
     ret
takeinput endp
;###########################
main proc
mov ax,0
mov add1[0],ax
call print1
call takeinput
mov ans2[0],bx
cmp bx,255
ja end1
cmp bx,3
jb end1
continue:
call multiples
addition:
call finalout 
end1:
mov ah,4ch
int 21h
main endp
;##################
multiples proc
call print2
mov ax,ans2[0]
mov bl,3
div bl
mov al,0
mov bx,ans2[0]
sub bl,ah
mov num1[0],bx
mov ax,add1[0]
mov bx,num1[0]
add ax,bx
mov add1[0],ax
mov bx,num1[0]
show bx
back:
mov ax,num1[0]
cmp al,3
je addition
mov bx,num1[0]
sub bl,3
mov num1[0],bx
call addsign
show num1[0]
mov bx,num1[0]
mov ax,add1[0]
add ax,bx
mov add1[0],ax
jmp back
ret
multiples endp
;#################
finalout proc
call equal
mov bx,add1[0]
show1 bx
mov bx,temp[0]
show bx
print ans3[1]    ;show digit
print ans3[0]    ;show digit
ret
finalout endp

end main
