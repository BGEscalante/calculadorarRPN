;Operaciones aritmeticas
;bge
;operaciones de calculadora
%include	'stdio32.asm'

SECTION	.data
;-----------Menú
	msg1 db 		'    -----caluladora RPN-----    ',0h
	msg2	db 		'1. Suma',0h
	msg3	db 		'2. Resta',0h
	msg4	db 		'3. Multiplicación',0h
	msg5	db 		'4. División',0h
	msg6	db 		'5. Módulo',0h
	msg7	db 		'Seleccione una opción: ',0h
	noOp	db 		'incorrecto' , 0h
	pru 	db 		'prueba', 0h
	p 		db	'Desea realizar otra operación? (1=si , 0=no) ',0h

    
;------------------cuadrocalc
	e1		db		'┌', 0h
	e2 		db		'┐', 0Ah,0h
	e3 		db		'└', 0h
	e4		db		'┘', 0h
	hor		db		'────────────────────────────────────────', 0h
	ver1	db		'│                                        ', 0h
	ver2	db		'                                        │', 0Ah, 0h
	variable dd 	5h
	
;----------------peticion de datos :v	
	numero1  db 	`Ingrese el primer número: \n`, 0
   	 nula1 	db 	`\n`, 0
    	numero2 db 	`Ingrese el segundo número: \n`, 0
    	fmt     db  `%lf`, 0		;imprimir numero double
    	resul    db  `Resultado =  %lf`, 0
    	modul	db 	"El modulo es: ",0
   	 resi	db 	"El residuo es: ",0

  
SECTION	.bss
	  opcion:	resb	1
	  n1:		resq 	1	      ;Reserva de un doble para las variables
    n2:		resq 	1
    respu:  resq 	1
    n11: 	resb 	1
    n21:	resb	1
    r1:		resb	1

SECTION	.text
	global main
		main:	
		call	cls				    ;limpia la pantalla
		call 	recuadro			;genera el recuadro
		mov		ah, 8d
		mov		al, 30d
		call	gotoxy				;va a la posición en pantalla
		mov		eax, msg1		  ;muestra el primer mensaje	
		call	printStrLn			;Escribe el primer mensaje
		mov		ah, 9d
		mov		al, 30d
		call	gotoxy
		mov		eax, msg2
		call 	printStrLn
		mov		ah, 10d
		mov		al, 30d
		call	gotoxy
		mov		eax, msg3
		call 	printStrLn
		mov		ah, 11d
		mov		al, 30d
		call	gotoxy
		mov		eax, msg4
		call 	printStrLn
		mov		ah, 12d
		mov		al, 30d
		call	gotoxy
		mov		eax, msg5
		call 	printStrLn
		mov		ah, 13d
		mov		al, 30d
		call	gotoxy
		mov		eax, msg6
		call 	printStr
		mov		ah, 14d
		mov		al, 30d
		call	gotoxy
		mov		eax, msg7
		call 	printStr
		mov		ah, 15d
		mov		al, 39d
		call	gotoxy
		

;------------------------------------------------------
	
	recuadro:
		call	cls
		call 	xy
		mov 	eax, e1
		call	printStr
		mov 	eax, hor
		call 	printStr
		mov 	eax, hor
		call 	printStr
		mov 	eax, e2
		call	printStr
		mov 	ecx, 24d
	
	etiqueta:					;ciclo para hacer el marco
		mov 	[variable], ecx
		mov 	eax, ver1
		call	printStr
		mov 	eax, ver2
		call	printStr
		mov 	ecx, [variable]
   		 loop 	etiqueta	
   		 mov 	eax, e3
		call	printStr
		mov 	eax, hor
		call 	printStr
		mov 	eax, hor
		call 	printStr
		mov 	eax, e4
		call	printStr
		ret
;--------------------confirmacion
repeat:
		mov		ah, 17d
		mov		al, 16d
		call		gotoxy
		mov 		eax, p
		call 		printStr
		mov		eax, 3		;Invoca el SYS_READ (Kernel opcode 3)
		mov		ebx, 0		
		mov		ecx, opcion
		mov		edx, 8
		int 		80H
		mov		ecx, opcion
		mov		edx, opcion
		call		chartoint	;convierte a entero la opcion ingresada
		mov		ecx, edx
		mov		eax, ecx
		mov		ebx, 1d
		cmp		eax, ebx
		je		main		;si el número es 1 regresa al main
		ret

;---------suma de floatsxd
	suma:
		call 	recuadro			;Crea el recuadro
		push 	ebp
		mov 	ebp, esp
	;lectura primer número
		mov		ah, 9d		
		mov		al, 30d
		call	gotoxy				;Llama a gotoxy
		push 	numero1				;Le pasa la cadena a mostrar
	    
		mov		ah, 10d
		mov		al, 40d
		call	gotoxy
	  push 	n1
	  push 	fmt
	   
	;lectura segundo número
	    mov		ah, 11d
		mov		al, 30d
		call	gotoxy
		push 	numero2 			;
		mov		ah, 12d
		mov		al, 40d
		call	gotoxy
	  push 	n2
	  push 	fmt
	    
	  fld 	qword 	[n1]
	  fadd 	qword 	[n2] 		    ;suma los dos primeros números del vector
	  fstp 	qword 	[respu]

		mov		ah, 13d
		mov		al, 32d
		call	gotoxy

	  push 	dword 	[respu + 4]	;convierte el número a double
	  push 	dword 	[respu + 0]
	  push 	resul 				      ;Pasa el formato del resultado			
	  push 	nula1 				      ;Le pasa la cadena a mostrar
	    			
	    mov 	esp, ebp
	    pop 	ebp
	    call 	repeat
	    ret

;---resta-------------		
	resta:
		call 	recuadro
		push 	ebp
		mov 	ebp, esp
	;lectura primer número
		mov		ah, 9d
		mov		al, 30d
		call	gotoxy
		push 	numero1
		mov		ah, 10d
		mov		al, 40d
		call	gotoxy
	    push 	n1
	    push 	fmt
	    
	;lectura segundo número
	  mov		ah, 11d
		mov		al, 30d
		call	gotoxy
		push 	numero2
	    
		mov		ah, 12d
		mov		al, 40d
		call	gotoxy
	    push 	n2
	    push 	fmt
	
	    fld 	qword 	[n1]
	    fsub 	qword 	[n2]
	    fstp 	qword 	[respu]

	    mov		ah, 13d
		mov		al, 32d
		call	gotoxy

	    push 	dword 	[respu + 4]
	    push 	dword 	[respu + 0]
	    push 	resul
	    push 	nula1 				;pasa la cadena a mostrar
	    mov 	esp, ebp
	    pop 	ebp
	    call 	repeat
	    ret

;----multi-------------
	multiplicacion:
		call 	recuadro
		push 	ebp
		mov 	ebp, esp
	;lectura primer número
		mov		ah, 9d
		mov		al, 30d
		call	gotoxy
		push 	numero1
		mov		ah, 10d
		mov		al, 40d
		call	gotoxy
	    push 	n1
	    push 	fmt
	    
	;lectura segundo número
	    mov		ah, 11d
		mov		al, 30d
		call	gotoxy
		push 	numero2
	    
		mov		ah, 12d
		mov		al, 40d
		call	gotoxy
	    push 	n2
	    push 	fmt
	    

	    fld 	qword 	[n1]
	    fmul 	qword 	[n2]
	    fstp 	qword 	[respu]

	    mov		ah, 13d
		mov		al, 32d
		call	gotoxy

	    push 	dword 	[respu + 4]
	    push 	dword 	[respu + 0]
	    push 	resul
	;printf solo para que muestre cadena
	    push 	nula1 				
	    mov 	esp, ebp
	    pop 	ebp
	    call 	repeat
	    ret

;----div---		
	divisionR:
		call 	recuadro
		push 	ebp
		mov 	ebp, esp
;lectura primer número
		mov		ah, 9d
		mov		al, 30d
		call	gotoxy
		push 	numero1
		mov		ah, 10d
		mov		al, 40d
		call	gotoxy
	    push 	n1
	    push 	fmt
	    
;lectura segundo número
	    mov		ah, 11d
		mov		al, 30d
		call	gotoxy
		push 	numero2
		mov		ah, 12d
		mov		al, 40d
		call	gotoxy
	    push 	n2
	    push 	fmt
	   
	    fld 	qword 	[n1]
	    fdiv 	qword 	[n2]
	    fstp 	qword 	[respu]

	    mov		ah, 13d
		mov		al, 32d
		call	gotoxy

	    push 	dword 	[respu + 4]
	    push 	dword 	[respu + 0]
	    push 	resul 
	    push 	nula1 				
	    mov 	esp, ebp
	    pop 	ebp
	    call 	repeat
	    ret

	modulo:
		call 	cls
		call 	recuadro
		mov 	ah, 9d
		mov 	al, 30d
		call 	gotoxy
		mov 	eax, numero1
		call	printStr

		mov 	ah, 10d
		mov 	al, 39d
		call 	gotoxy
		mov		eax, 3		
		mov		ebx, 0		
		mov		ecx, n11
		mov		edx, 8
		int 	80H
		mov		ecx, n11
		mov		edx, n11
		call	chartoint
		mov		eax, edx
		push	eax

		mov 	ah, 11d
		mov 	al, 30d
		call 	gotoxy
		mov 	eax, numero2
		call	printStr

		mov 	ah, 12d
		mov 	al, 39d
		call 	gotoxy

		mov		eax, 3		
		mov		ebx, 0		
		mov		ecx, n21
		mov		edx, 8
		int 	80H
		mov		ecx, n21
		mov		edx, n21
		call	chartoint
		mov 	eax, edx
		mov 	ebx, eax
		mov 	ecx, 0000
		mov 	edx, 0000
		pop		eax
		idiv	ebx
		push 	edx
		mov 	ecx, edx
		push 	eax

		mov 	ah, 14d
		mov 	al, 30d
		call 	gotoxy
		mov 	eax, modul
		call 	printStr
		pop 	eax
		call 	printInt
		;pop 	edx
		mov 	ah, 15d
		mov 	al, 30d
		call 	gotoxy
		mov 	eax, resi
		call 	printStr
		pop 	edx
		mov 	eax, edx
		call 	printInt
		call	gotoxy
		call 	repeat
		ret

