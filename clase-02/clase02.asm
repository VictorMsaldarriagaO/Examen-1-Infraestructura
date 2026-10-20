; ============================================================
;  LA LEYENDA DEL REGISTRO - CLASE 2 (Retos R1 a R6)
; ============================================================

default rel

section .data
    titulo          db "LA LEYENDA DEL REGISTRO v0.2", 10
    len_titulo      equ $ - titulo
    
    ; R1: Pregunta y saludo personalizados
    pregunta        db "Cual es el nombre de tu guerrero? (max 31 letras)", 10
    len_pregunta    equ $ - pregunta
    
    saludo          db "¡Saludos, poderoso "
    len_saludo      equ $ - saludo
    
    ; R2: Mensaje para repetir el nombre
    saludo_repetido db " Repito tu nombre en el reino: "
    len_saludo_rep  equ $ - saludo_repetido
    
    ; R6: Mensaje explicativo para la longitud en ASCII
    msg_lon         db 10, "Tu nombre tiene exactamente este numero de letras: "
    len_msg_lon     equ $ - msg_lon
    
    despedida       db 10, "Tu nombre ya vive en la memoria del proceso.", 10
    len_despedida   equ $ - despedida
    
    salto           db 10

section .bss
    nombre          resb 32        ; Buffer para el nombre (R4: límite de 32 bytes)
    lon             resq 1         ; Guardará la longitud real leída
    num_buf         resb 1         ; R6: buffer de 1 byte para el dígito ASCII

section .text
    global _start

_start:
    ; ---------- Acción 1: Título ----------
    mov rax, 1
    mov rdi, 1
    mov rsi, titulo
    mov rdx, len_titulo
    syscall

    ; ---------- Acción 2: Pregunta (R1) ----------
    mov rax, 1
    mov rdi, 1
    mov rsi, pregunta
    mov rdx, len_pregunta
    syscall

    ; ---------- Acción 3: LEER teclado (R4: Límite de 32 bytes) ----------
    mov rax, 0                  ; sys_read
    mov rdi, 0                  ; stdin
    mov rsi, nombre
    mov rdx, 32                 ; R4: Máximo 32 bytes
    syscall

    mov [lon], rax              ; Guardar bytes leídos en RAM

    ; ---------- Acción 4: Quitar LF / Salto de línea (\n) ----------
    cmp rax, 0
    je .sin_nombre
    cmp byte [nombre + rax - 1], 10
    jne .sin_saltolinea
    dec rax
    mov [lon], rax              ; Guardar nueva longitud sin el '\n'
.sin_saltolinea:

    ; ---------- Acción 5: Saludar con el nombre (R1) ----------
    mov rax, 1
    mov rdi, 1
    mov rsi, saludo
    mov rdx, len_saludo
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, nombre
    mov rdx, [lon]
    syscall

    ; ---------- R2: Repetir el nombre por segunda vez ----------
    mov rax, 1
    mov rdi, 1
    mov rsi, saludo_repetido
    mov rdx, len_saludo_rep
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, nombre
    mov rdx, [lon]
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, salto
    mov rdx, 1
    syscall

    ; ---------- R6 (Estiramiento): Imprimir la longitud en ASCII si es de 1 dígito (1..9) ----------
    mov rax, [lon]
    cmp rax, 1
    jl .omitir_r6
    cmp rax, 9
    jg .omitir_r6

    add rax, 48                 ; Convertir entero a carácter ASCII (ej: 6 -> '6')
    mov [num_buf], al

    mov rax, 1
    mov rdi, 1
    mov rsi, msg_lon
    mov rdx, len_msg_lon
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, num_buf
    mov rdx, 1                  ; Imprimir 1 byte
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, salto
    mov rdx, 1
    syscall

.omitir_r6:
    ; ---------- Acción 6: Despedida ----------
    mov rax, 1
    mov rdi, 1
    mov rsi, despedida
    mov rdx, len_despedida
    syscall

.sin_nombre:
    mov rax, 60                 ; sys_exit
    mov rdi, 0
    syscall
