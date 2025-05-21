dosseg
.model small
;#################################################
;this procedure takes numbers and multiplies them
algo macro G1,G2,G3,G4,G5
mov al,G1      ;load one number to al
mov bl,G2      ;load another to bl
mul bl         ;multiply them
mov bl,G3      ;load another number
mul bl         ;multiply that
mov bl,G4      ;load 4th number
mul bl         ; multiply that
mov bl,G5      ;load 5th
mul bl         ;multiply that
show ax        ;show the product
call CR        ; call carriage return
endm

;#################################################
; this procedure pints the digit which is passed to it
print macro P1
mov dl,P1         ;numbe to be printed saved to dl
add dl,48         ;add 48 to convert to asii 
mov ah,2          ;print number
int 21h           ;call interupt
endm
;#####################################################
show macro P2
lea si,ans1         ;load initial addres to si
mov ax,P2           ;load number to ax
mov bl,10           ; mov 10 to bl
div bl              ; divide number by 10
mov cl,al           ; mov al to cl(10th number in cl)
mov ans1[0],ah      ;store in arrry poition 0
mov bl,10           ;mov 10 to bl
mov ah,00           ;mov 00 to ah
mov al,cl           
div bl              ;again divide by 10
mov cl,al
mov ans1[1],ah      ;store in ans arry location 1
mov ans1[2],cl      ;store in ans arry location 2
print ans1[2]       ;
print ans1[1]       ;store all digits of number
print ans1[0]       ;
endm
;########################################################
.stack 100h
.data
str1 db 'The elements of array before algo applied are:$'
str2 db 'The elements of array after algo applied are:$'
arr1 db 6 dup(?)
ans1 db 3 dup(?)
ans2 db 6 dup(?)
.code
;####################################################
;this is the main code which calls all other functions
main proc
call takeinput         ;take input from user
call print1            ;print initial string
call showinputs        ;and show our input numbers
call print2            ;print string2
algo arr1[1],arr1[2],arr1[3],arr1[4],arr1[5]     ;1st number after algo applied
algo arr1[0],arr1[2],arr1[3],arr1[4],arr1[5]     ;2nd number after algo applied
algo arr1[0],arr1[1],arr1[3],arr1[4],arr1[5]     ;3rd number after algo applied
algo arr1[0],arr1[1],arr1[2],arr1[4],arr1[5]     ;4th number after algo applied
algo arr1[0],arr1[1],arr1[2],arr1[3],arr1[5]     ;5th number after algo applied
algo arr1[0],arr1[1],arr1[2],arr1[3],arr1[4]     ;6th number after algo applied
mov ah,4ch
int 21h
main endp

;########################################################
;this procedure print strings
print1 proc
mov ax,@data
mov ds,ax
lea dx, str1      ;load adress of string to be printed in dx
mov ah,9h         ; mov 9h to ah to print
int 21h           ;call interupt
ret
print1 endp
;########################################################
;this procedure prints second string 
print2 proc
mov ax,@data
mov ds,ax
call linefeed      ;call linefeed
lea dx, str2       ;load adress of string to be printed in dx
mov ah,9h          ; mov 9h to ah to print
int 21h            ;call interupt
ret
print2 endp

;###################################################
linefeed proc
mov ax,@data
mov ds,ax
mov dx,10
mov ah,2
int 21h
ret
linefeed endp
;######################################
; tgis procedure creates space between numbers via carriage return
CR  proc
mov ax,@data
mov ds,ax
mov dx,32            ; send 32 to dx(32 is ascii for space)
mov ah,2             ;send 2 to ah to print number in dx
int 21h              ;call interupt
ret
CR endp

;#################################################
showinputs proc
call CR             ;call carriage retrn procedure
print arr1[0]       ;print 1st number
call CR             ;call carriage retun proc
print arr1[1]       ;print second number   
call CR
print arr1[2]       ;print third number
call CR
print arr1[3]       ;print 4th number
call CR
print arr1[4]       ;print fifth number
call CR
print arr1[5]       ;print sixth number
ret
showinputs endp
;################################################
;this procedure takes input from user
takeinput proc
mov ax,@data
mov ds,ax
mov si,offset arr1
mov cx,6           ;take number of inputs
l1:
mov ah,1           ;taking input
int 21h
cmp al,13          ;check either enter pressed
je programend      ; if yes goto 
sub al,48          ;subtract 48 from input to makeit digit
mov [si],al        ;store at location indicated by si
inc si             ;inrement si
jmp l1
programend:
dec cx              ;decrement 
jnz l1              ;if 6 inuts not done
ret                 ; if done
takeinput endp      ;end procedure
end main            ;end program



