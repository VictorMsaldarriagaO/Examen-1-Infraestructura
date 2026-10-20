# Examen — La Leyenda del Registro

**Asignatura:** Fundamentos de Infraestructura  
**Unidad:** Ensamblador x86-64 (NASM) — Clases 1, 2 y 3  
**Duración:** 90 minutos  
**Modalidad:** individual, en la VM de Ubuntu con NASM instalado  

---

# PARTE A — PRÁCTICA: seguir y ejecutar las clases (60 pts)

---

## A.1 — El despertar (Clase 1) — 10 pts

### A.1.1 (4 pts)
Ver detalles de ejecución y logs en `entrega.md`.

### A.1.2 (6 pts)
[RESOLVER AQUÍ: 
1. Hay 3 llamadas `write` en total en el programa base de la clase 1.
2. El código de salida devuelto por `exit_group` es 0.
3. El número de syscall que utiliza `write` en Linux x86-64 es 1.]

---

## A.2 — El nombre del héroe (Clase 2) — 15 pts

### A.2.1 (5 pts)
[RESOLVER AQUÍ: En el caso 3 (40 letras), el programa únicamente lee y muestra los primeros 32 caracteres. Esto sucede porque la llamada `sys_read` en `clase02.asm` tiene limitado el buffer a 32 bytes en la línea `mov rdx, 32`.]

### A.2.2 (5 pts)
[RESOLVER AQUÍ: 
1. La llamada `read` devuelve 11 bytes (las 10 letras del nombre + 1 byte correspondiente al salto de línea `\n` generado al presionar Enter).
2. Devuelve 11 y no 32 porque `sys_read` retorna la cantidad real de bytes leídos hasta que el usuario presiona Enter.
3. El valor de retorno devuelto en `rax` se guarda en la variable `[lon]` mediante la instrucción `mov [lon], rax`.]

### A.2.3 (5 pts) — Modificación obligatoria
(Ver bloque `.data` e impresiones modificadas en `entrega.md`).

---

## A.3 — Los atributos del héroe (Clase 3) — 20 pts

### A.3.1 (8 pts)

| Caso | FUE | AGI | ¿ELITE o NOVATO o ERROR? | Código salida (`$?`) |
|------|-----|-----|--------------------------|----------------------|
| 1    | 3   | 5   | ELITE                    | 0                    |
| 2    | 0   | 9   | ELITE                    | 0                    |
| 3    | 9   | 9   | ERROR                    | 1                    |
| 4    | 0   | 0   | NOVATO                   | 0                    |
| 5    | `x` | 5   | NOVATO                   | 0                    |

[RESOLVER AQUÍ: Al ingresar la letra `x` (ASCII 120), las instrucciones `cmp byte [buf], 57` y `ja .fue_vacio` detectan que no está en el rango de dígitos ('0' al '9'). Por tanto, el flujo salta a `.fue_vacio` asignando automáticamente el valor 0 a `v_fue`. Al ser FUE=0 y AGI=5, la suma da 5 (<6), clasificando al héroe como NOVATO sin romper la ejecución.]

### A.3.2 (6 pts)
[RESOLVER AQUÍ: 
1. Hay 5 llamadas `write` en total:
   - write 1: Título ("LA LEYENDA DEL REGISTRO v0.3\n")
   - write 2: Mensaje de introducción de puntos
   - write 3: Pregunta de FUE ("FUE (fuerza, 0 a 9): ")
   - write 4: Pregunta de AGI ("AGI (agilidad, 0 a 9): ")
   - write 5: Mensaje de error ("Error: La suma de FUE y AGI no puede superar 9 puntos.\n")
2. Hay 2 llamadas `read` (una para FUE y otra para AGI).
3. Devuelve 2 bytes porque lee el carácter ingresado más el byte del salto de línea `\n` (Enter).]

### A.3.3 (6 pts) — Modificación obligatoria
(Ver código añadido y salida completa en `entrega.md`).

---

## A.4 — Crear desde cero (15 pts)
(Ver programa completo `heroe.asm` y pruebas en `entrega.md`).

---

# PARTE B — TEORÍA: preguntas (40 pts)

---

## B.1 — Selección múltiple (5 pts, 1 pt c/u)

**1.** ¿Cuál es el número de syscall de `sys_write` en Linux x86-64?
- **b) 1**

[RESOLVER AQUÍ: b) 1]

---

**2.** ¿En qué registro se pone el **número de syscall** antes de ejecutar `syscall`?
- **c) `rax`**

[RESOLVER AQUÍ: c) rax]

---

**3.** ¿Qué sección usa `resb` para reservar memoria sin ocuparla en el binario?
- **c) `.bss`**

[RESOLVER AQUÍ: c) .bss]

---

**4.** ¿Qué valor de retorno trae `rax` después de un `sys_read`?
- **b) La cantidad de bytes leídos realmente**

[RESOLVER AQUÍ: b) La cantidad de bytes leídos realmente]

---

**5.** En clase 3, ¿qué instrucción decide entre ELITE y NOVATO?
- **c) `cmp` + `jge`**

[RESOLVER AQUÍ: c) cmp + jge]

---

## B.2 — Verdadero o Falso con justificación (10 pts, 2 pts c/u)

**1.** `db` declara 8 bits (1 byte) por elemento de datos.  
[RESOLVER AQUÍ: V (Verdadero). `db` significa "Define Byte" e inicializa elementos de 8 bits.]

---

**2.** `mov rax, 60` seguido de `syscall` es la forma estándar de terminar un programa en este curso.  
[RESOLVER AQUÍ: V (Verdadero). El número 60 es la llamada al sistema `sys_exit` en Linux x86-64.]

---

**3.** `resb 32` escribe 32 bytes de ceros en el binario.  
[RESOLVER AQUÍ: F (Falso). `resb 32` únicamente reserva espacio en la sección `.bss` en tiempo de ejecución, pero no ocupa bytes físicamente en el archivo ejecutable guardado en disco.]

---

**4.** En clase 2, el valor de `lon` (la longitud leída) viene de un `equ` fijo calculado por el ensamblador.  
[RESOLVER AQUÍ: F (Falso). El valor de `lon` se calcula de forma dinámica en tiempo de ejecución capturando lo que retorna la syscall `sys_read` en `rax`.]

---

**5.** `add al, 48` convierte un dígito numérico (0–9) en su carácter ASCII imprimible.  
[RESOLVER AQUÍ: V (Verdadero). Como el carácter ASCII del dígito '0' es 48, sumar 48 a un entero entre 0 y 9 obtiene su valor de carácter en la tabla ASCII.]

---

## B.3 — Lectura de código: predice la salida (6 pts)

```asm
section .data
    msg db "HOLA", 10
    len equ $ - msg

section .text
    global _start
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, len
    syscall
    mov rax, 60
    mov rdi, 3
    syscall

¿Qué imprime el programa? (2 pts)

¿Con qué código de salida termina? ¿Qué significa ese código? (2 pts)

¿Cuántas llamadas al kernel (syscall) hay? (2 pts)

[RESOLVER AQUÍ:

Imprime: HOLA seguido de un salto de línea.

Código de salida: 3. Significa que el proceso finalizó devolviendo el código de estado 3 al sistema operativo (por la instrucción mov rdi, 3).

Llamadas syscall: 2 (una llamada sys_write y una llamada sys_exit).]

B.4 — Encuentra el error (4 pts)
[RESOLVER AQUÍ:
El error radica en que se guarda directamente el entero 7 en memoria (mov al, 7), el cual representa el carácter ASCII de control no imprimible (BEL). Falta convertir el valor a ASCII sumándole 48.

Línea corregida (añadir justo antes de mov [d], al):
add al, 48]

B.5 — Respuesta corta (10 pts, 2.5 pts c/u)
1. ¿Por qué en clase 2 se reserva resb 32 para un nombre de "máximo 31 letras"?

[RESOLVER AQUÍ: Porque el teclado envía las letras del nombre más el carácter de salto de línea (\n, byte 10) al presionar Enter. 31 letras + 1 byte de Enter = 32 bytes.]

2. ¿Por qué la clase 2 quita el último byte (LF) del nombre antes de imprimirlo, usando dec rax?

[RESOLVER AQUÍ: Para descartar el salto de línea sobrante traído por el Enter y así poder imprimir mensajes continuos sin saltos no deseados.]

3. En clase 3, ¿por qué el programa valida FUE y AGI por separado (0–9) y además valida que la suma sea ≤ 9?

[RESOLVER AQUÍ: La primera es una validación de formato (asegura que se ingresó un solo carácter numérico), mientras que la segunda es la validación de las reglas del juego (que la cantidad total de puntos asignada no exceda el límite permitido).]

4. ¿Qué significa equ $ - etiqueta y por qué es útil en vez de contar los bytes a mano?

[RESOLVER AQUÍ: Representa la resta entre la posición actual de memoria ($) y la dirección de etiqueta. Es útil porque calcula la longitud exacta del texto de manera automática sin tener que contar bytes a mano.]

B.6 — Escribe el código (5 pts)
1. (2 pts) Bloque para imprimir "FIN\n":

[RESOLVER AQUÍ:
mov rax, 1          ; sys_write
mov rdi, 1          ; stdout
mov rsi, fin        ; dirección del texto
mov rdx, len_fin    ; longitud
syscall
```]

---

**2. (3 pts)** Leer 2 bytes, validar dígito (0–9) y convertir a número:

[RESOLVER AQUÍ: 
```asm
mov rax, 0          ; sys_read
mov rdi, 0          ; stdin
mov rsi, b          ; buffer en .bss
mov rdx, 2          ; 1 dígito + LF
syscall

cmp byte [b], 48    ; ¿menor que '0'?
jb .mal
cmp byte [b], 57    ; ¿mayor que '9'?
ja .mal

mov al, byte [b]
sub al, 48          ; convertir ASCII a entero
mov [n], al         ; guardar en la variable n
```]o
