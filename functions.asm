BITS 32
GLOBAL addstr
GLOBAL is_palindromeASM
GLOBAL palindrome_check
GLOBAL factstr
extern fact
extern atoi
extern strlen
extern is_palindromeC
section .data
prompt DB 'Insert a string' ,0xa
lenprompt EQU $ - prompt


;is_palindromeC
postiveresult   DB 'It is a palindrome', 0xa
lenpostiveresult  EQU $ - postiveresult
negativeresult   DB 'It is NOT a palindrome', 0xa
lennegativeresult  EQU $ - negativeresult

section .bss
userstring RESB 1024
result RESB 1

section .text
;add two numbers
addstr:
    push ebp
    mov ebp, esp

    push ebx

    push dword [ebp+8]  ;1st number push onto stack
    call atoi
    add esp, 4
    mov ebx, eax

    push dword [ebp+12]  ;2nd number push onto stack
    call atoi
    add esp,4
    add eax, ebx    ;eax contains result
    pop ebx
    mov esp, ebp
    pop ebp
    ret

is_palindromeASM:
    push ebp
    mov ebp, esp

    push ebx
    push DWORD[ebp+8] ; ebp+12 => dword[ebp+8] 
    call strlen ; does not include \0 eax holds string length
    add esp, 4
    mov edi, DWORD[ebp+8] ; edi = string
    mov esi, edi
    add esi, eax ; end of string
    dec esi     ; last letter
    mov ecx, eax   ; ecx is total characters remaining in string
    jmp again
again:
    cmp ecx, 1  ; test string one word or less
        jle test_true
    mov al, [edi]
    mov bl, [esi]
    cmp al, bl
        jne test_false  ;jumps if letters don't match
    inc edi
    dec esi
    sub ecx,2
    jmp again
test_true:
    xor eax, eax
    add eax, 1
    pop ebx
    mov esp, ebp
    pop ebp
    ret ;returns 1
test_false:
    xor eax, eax
    pop ebx
    mov esp, ebp
    pop ebp
    ret ;returns 0

factstr:
    push ebp
    mov ebp, esp

    push ebx

    push dword [ebp+8]  ;string push on stack
    call atoi
    add esp, 4
    push eax
    call fact
    add esp, 4
    pop ebx
    mov esp, ebp
    pop ebp
    ret
palindrome_check:
push ebp
    mov ebp, esp
    push ebx

    mov ebx, 1
    mov eax, 4
    mov ecx, prompt
    mov edx, lenprompt
    int 80h

    ;Read string
    mov eax, 3
    mov ebx, 0
    mov ecx, userstring
    mov edx, 1024
    int 80h
    cmp eax,1
    je postive
    dec eax
    mov byte [userstring+eax],0

    push userstring
    call is_palindromeC
    add esp, 4
    cmp eax, 0
    je postive
    jne negative

postive:
    xor eax,eax
    mov ebx, 1
    mov eax, 4
    mov ecx, postiveresult
    mov edx, lenpostiveresult
    int 80h
    pop ebx
    mov esp, ebp
    pop ebp
    ret

negative:
    xor eax,eax
    mov ebx, 1
    mov eax, 4
    mov ecx, negativeresult
    mov edx, lennegativeresult
    int 80h
    pop ebx
    mov esp, ebp
    pop ebp
    ret
