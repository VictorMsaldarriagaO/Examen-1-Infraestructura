; ============================================================
;  LA LEYENDA DEL REGISTRO - CLASE 3
;  "Los atributos del heroe"
; ============================================================

default rel

section .data
    titulo      db "LA LEYENDA DEL REGISTRO v0.3", 10
    len_titulo  equ $ - titulo

    msg_intro   db "Tienes 9 puntos para repartir. El resto se vuelve vida (VID).", 10
    len_intro   equ $ - msg_intro

    ask_fue     db "FUE (fuerza, 0 a 9): "
    len_ask_fue equ $ - ask_fue

    ask_agi     db "AGI (agilidad, 0 a 9): "
    len_ask_agi equ $ - ask_agi

    msg_error   db "Error: La suma de FUE y AGI no puede superar 9 puntos.", 10
    len_error   equ $ - msg_error

    elite       db "El heroe despierta como ELITE del reino.", 10
    len_elite   equ $ - elite

    novato      db "El heroe despierta como NOVATO del reino.", 10
    len_novato  equ $ - novato

    lbl_fue     db "FUE: "
    len_lbl_fue equ $ - lbl_fue

    lbl_agi     db "AGI: "
    len_lbl_agi equ $ - lbl_agi

    lbl_vid     db "VID: "
    len_lbl_vid equ $ - lbl_vid

    lbl_used    db "Puntos gastados: "
    len_lbl_used equ $ - lbl_used

    lbl_niv     db "Nivel: "
    len_lbl_niv equ $ - lbl_niv

    despedida   db "Los atributos quedaron grabados en los registros del heroe.", 10
    len_despedida equ $ - despedida

    salto       db 10

section .bss
    buf         resb 2
    v_fue       resb 1
    v_agi       resb 1
    v_vid       resb 1
    v_used      resb 1
    v_nivel     resb 1
    outd        resb 1

section .text
    global _start

_start:
    ; 1. Mostrar Titulo e Introduccion
    mov rax, 1
    mov rdi, 1
    mov rsi, titulo
    mov rdx, len_titulo
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg_intro
    mov rdx, len_intro
    syscall

    ; 2. Pedir y leer FUE
    mov rax, 1
    mov rdi, 1
    mov rsi, ask_fue
    mov rdx, len_ask_fue
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 2
    syscall

    cmp rax, 0
    je .fue_vacio
    cmp byte [buf], 48          ; ¿menor que '0'?
    jb .fue_vacio
    cmp byte [buf], 57          ; ¿mayor que '9'?
    ja .fue_vacio

    mov al, byte [buf]
    sub al, 48                  ; Convertir ASCII a número
    mov [v_fue], al
    jmp .fue_leido

.fue_vacio:
    mov byte [v_fue], 0

.fue_leido:

    ; 3. Pedir y leer AGI
    mov rax, 1
    mov rdi, 1
    mov rsi, ask_agi
    mov rdx, len_ask_agi
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 2
    syscall

    cmp rax, 0
    je .agi_vacio
    cmp byte [buf], 48          ; ¿menor que '0'?
    jb .agi_vacio
    cmp byte [buf], 57          ; ¿mayor que '9'?
    ja .agi_vacio

    mov al, byte [buf]
    sub al, 48                  ; Convertir ASCII a número
    mov [v_agi], al
    jmp .agi_leido

.agi_vacio:
    mov byte [v_agi], 0

.agi_leido:

    ; 4. Calcular suma (puntos gastados)
    mov al, [v_fue]
    add al, [v_agi]             ; SUMA: FUE + AGI
    mov [v_used], al

    ; Validar que la suma no supere 9 puntos
    cmp byte [v_used], 9
    jbe .suma_valida

    ; Si supera 9, mostrar error y salir con codigo 1
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_error
    mov rdx, len_error
    syscall

    mov rax, 60
    mov rdi, 1
    syscall

.suma_valida:
    ; Calcular Vida: VID = 9 - v_used
    mov al, 9
    sub al, [v_used]            ; RESTA: 9 - v_used
    mov [v_vid], al

    ; Determinar Nivel: ELITE si v_used >= 6, NOVATO si v_used < 6
    mov byte [v_nivel], 1
    cmp byte [v_used], 6
    jge .es_elite

    ; Mensaje Novato
    mov rax, 1
    mov rdi, 1
    mov rsi, novato
    mov rdx, len_novato
    syscall
    jmp .fin_nivel

.es_elite:
    inc byte [v_nivel]          ; INCREMENTO: nivel + 1
    mov rax, 1
    mov rdi, 1
    mov rsi, elite
    mov rdx, len_elite
    syscall

.fin_nivel:

    ; 5. Imprimir resumen de resultados
    ; Imprimir FUE
    mov rax, 1
    mov rdi, 1
    mov rsi, lbl_fue
    mov rdx, len_lbl_fue
    syscall
    mov al, [v_fue]
    add al, 48                  ; Convertir número a ASCII
    mov [outd], al
    mov rax, 1
    mov rdi, 1
    mov rsi, outd
    mov rdx, 1
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, salto
    mov rdx, 1
    syscall

    ; Imprimir AGI
    mov rax, 1
    mov rdi, 1
    mov rsi, lbl_agi
    mov rdx, len_lbl_agi
    syscall
    mov al, [v_agi]
    add al, 48
    mov [outd], al
    mov rax, 1
    mov rdi, 1
    mov rsi, outd
    mov rdx, 1
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, salto
    mov rdx, 1
    syscall

    ; Imprimir VID
    mov rax, 1
    mov rdi, 1
    mov rsi, lbl_vid
    mov rdx, len_lbl_vid
    syscall
    mov al, [v_vid]
    add al, 48
    mov [outd], al
    mov rax, 1
    mov rdi, 1
    mov rsi, outd
    mov rdx, 1
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, salto
    mov rdx, 1
    syscall

    ; Imprimir Puntos gastados
    mov rax, 1
    mov rdi, 1
    mov rsi, lbl_used
    mov rdx, len_lbl_used
    syscall
    mov al, [v_used]
    add al, 48
    mov [outd], al
    mov rax, 1
    mov rdi, 1
    mov rsi, outd
    mov rdx, 1
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, salto
    mov rdx, 1
    syscall

    ; Imprimir Nivel
    mov rax, 1
    mov rdi, 1
    mov rsi, lbl_niv
    mov rdx, len_lbl_niv
    syscall
    mov al, [v_nivel]
    add al, 48
    mov [outd], al
    mov rax, 1
    mov rdi, 1
    mov rsi, outd
    mov rdx, 1
    syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, salto
    mov rdx, 1
    syscall

    ; Despedida final
    mov rax, 1
    mov rdi, 1
    mov rsi, despedida
    mov rdx, len_despedida
    syscall

    ; Salida limpia (0)
    mov rax, 60
    mov rdi, 0
    syscall
