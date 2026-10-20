; ============================================================
;  LA LEYENDA DEL REGISTRO - CLASE 1 (Con Retos R1 - R5)
; ============================================================

section .data
    ; R1: Título y mensaje de bienvenida personalizados
    titulo      db "MI GRAN AVENTURA v0.2", 10
    len_titulo  equ $ - titulo
    mensaje     db "Bienvenido, heroe. Tu aventura empieza aqui.", 10
    len_mensaje equ $ - mensaje

    ; R2: Cuarto texto declarado UNA SOLA VEZ
    continuar     db "Presiona Enter para continuar...", 10
    len_continuar equ $ - continuar

    adios       db "El sistema operativo te despidio con elegancia (código 7).", 10
    len_adios   equ $ - adios

section .text
    global _start

_start:
    ; ---------- Acción 1: Mostrar título (R1) ----------
    mov rax, 1                     ; sys_write
    mov rdi, 1                     ; stdout
    mov rsi, titulo                ; dirección del texto
    mov rdx, len_titulo            ; longitud
    syscall

    ; ---------- Acción 2: Mostrar bienvenida (R1) ----------
    mov rax, 1
    mov rdi, 1
    mov rsi, mensaje
    mov rdx, len_mensaje
    syscall

    ; ---------- Acción 3: Impresión 1 del texto 'continuar' (R2) ----------
    mov rax, 1
    mov rdi, 1
    mov rsi, continuar
    mov rdx, len_continuar
    syscall

    ; ---------- R5 (Estiramiento): Impresión 2 de 'continuar' ----------
    ; Reutiliza la etiqueta 'continuar' sin volver a declararla con db
    mov rax, 1
    mov rdi, 1
    mov rsi, continuar
    mov rdx, len_continuar
    syscall

    ; ---------- Acción 4: Mostrar despedida ----------
    mov rax, 1
    mov rdi, 1
    mov rsi, adios
    mov rdx, len_adios
    syscall

    ; ---------- Accion final: Salir con código 7 (R3) ----------
    mov rax, 60                    ; sys_exit (terminar proceso)
    mov rdi, 7                     ; código de salida 7
    syscall
