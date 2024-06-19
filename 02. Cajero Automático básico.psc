Algoritmo Cajero_Automatico_Basico
	Definir rut Como Cadena

	rut_digitado = ''
	pin_inicial = 9999 
	pin_digitado = 0000 
	pin_validado <- Falso 
	saldo_inicial = 0 
	
	Validar_Rut(rut_digitado) 
	Validar_Pin(pin_inicial, pin_validado, pin_digitado) 
	
	Si pin_validado == Verdadero Entonces 
		Construir_Menu(pin_inicial, pin_digitado, saldo_inicial, rut_digitado)
	FinSi
FinAlgoritmo

Funcion Validar_Rut(rut_digitado Por Referencia)
	Definir largo_rut Como Entero
	Definir rut_validado Como Logico
	
	Repetir
		Escribir '******** Bienvenido a REDBANC *********'
		Escribir 'Para comenzar, por favor ingrese su RUT'
		Leer rut_digitado 
		
		largo_rut <- Longitud(rut_digitado)
		
		Si largo_rut >= 9 Y largo_rut <= 11 Entonces
			rut_validado <- Verdadero
			rut_digitado <- rut_digitado
		SiNo
			Limpiar Pantalla
			
			Escribir 'El RUT ingresado debe ser mayor a 9 digitos y menor que 11'
			rut_validado <- Falso
		FinSi
	Hasta Que rut_validado == Verdadero
FinFuncion

Funcion Validar_Pin(pin_inicial Por Referencia, pin_validado Por Referencia, pin_digitado Por Referencia)
	Definir contador Como Entero
	contador = 0
	
	Limpiar Pantalla
	Escribir 'Por favor ingrese su PIN:'
	Escribir ' _______'
	Escribir '| 1 2 3 | Recuerde nunca compartir'
	Escribir '| 4 5 6 | sus contrase�as'
	Escribir '| 7 8 9 | por seguridad'
	Escribir '| - 0 + | BANCO PATITO'
	Escribir ' _______'
	Escribir 'Por motivos de seguridad tiene m�ximo 3 intentos'
	Leer pin_digitado
	Limpiar Pantalla
	
	Repetir
		Si pin_digitado == pin_inicial Entonces
			pin_validado <- Verdadero
		SiNo
			contador = contador + 1
			pin_validado <- Falso
			Si contador < 3 Entonces
				Limpiar Pantalla
				Escribir 'El PIN digitado es incorrecto, n�mero de intentos: ', contador
				Escribir 'Por favor ingrese su PIN:'
				Leer pin_digitado
			SiNo
				Limpiar Pantalla
				Escribir 'ERROR! Alcanz� el n�mero m�ximo de intentos: (', contador, ')'
				Escribir 'Por favor intente m�s tarde'
			FinSi
		FinSi
	Hasta que pin_validado == Verdadero O contador >= 3
FinFuncion

SubProceso Construir_Menu(pin_inicial Por Referencia, pin_digitado Por Referencia, saldo_inicial Por Referencia, rut_digitado)
	Definir monto_abonado, monto_girado, saldo_total Como Entero
	Definir seleccion_opcion, repetir_menu Como Entero
	Definir nuevo_pin_1, nuevo_pin_2 Como Entero

	saldo_total = saldo_inicial
	
	Repetir
		Limpiar Pantalla
		
		Escribir 'Bienvenido: [' rut_digitado ']'
		Escribir 'Su clave PIN Actual es: [' pin_inicial ']'
		Escribir 'La clave ha sido validada con �xito'
		Escribir 'Por favor seleccione una de las siguientes opciones:'
		Escribir ''
		Escribir ' =================================================== '
		Escribir '| 1. Ver Saldo                                      |'
		Escribir '| 2. Abonar Dinero                                  |'
		Escribir '| 3. Girar Dinero                                   |'
		Escribir '| 4. Cambiar PIN                                    |'
		Escribir '| 5. Salir                                          |'
		Escribir ' ================================================== '
		
		Leer seleccion_opcion
	
		Segun seleccion_opcion Hacer
			1: 
				Voucher(seleccion_opcion, saldo_total, monto_abonado, monto_girado, pin_inicial, nuevo_pin_2)
			2: 
				Limpiar Pantalla
				Escribir 'Indique la cantidad de dinero que desea abonar a su cuenta'
				Leer monto_abonado
				
				Si monto_abonado > 0 Entonces
					saldo_total = saldo_total + monto_abonado
					Voucher(seleccion_opcion, saldo_total, monto_abonado, monto_girado, pin_inicial, nuevo_pin_2)
				SiNo
					Limpiar Pantalla
					Escribir 'El sistema no permite abonar un monto inferior a $1'
				FinSi
			3: 
				Limpiar Pantalla
				Escribir 'Indique la cantidad de dinero que desea girar'
				Leer monto_girado
				
				Si monto_girado > 0 Y monto_girado <= saldo_total Entonces
					Limpiar Pantalla
					saldo_total = saldo_total - monto_girado
					Voucher(seleccion_opcion, saldo_total, monto_abonado, monto_girado, pin_inicial, nuevo_pin_2)
				SiNo
					Limpiar Pantalla
					Escribir 'El monto ingresado es inferior a $1 o mayor a su saldo total'
				FinSi
			4: 
				Limpiar Pantalla
				pin_validado <- Verdadero
				
				Escribir 'El cambio requiere digitar su PIN Actual nuevamente'

				Validar_Pin(pin_inicial, pin_validado, pin_digitado)
				
				Si pin_validado == Verdadero Entonces
					Escribir 'Por favor ingrese su nuevo PIN:'
					Leer nuevo_pin_1
					Escribir 'Confirme nuevamente el PIN ingresado:'
					Leer nuevo_pin_2
					
					Si (nuevo_pin_1 == nuevo_pin_2) Y (nuevo_pin_1 <> pin_digitado) Entonces
						Voucher(seleccion_opcion, saldo_total, monto_abonado, monto_girado, pin_inicial, nuevo_pin_2)
						pin_inicial <- nuevo_pin_2
					SiNo
						Escribir 'El nuevo PIN digitado no coincide � es igual al PIN actual'
					FinSi
				FinSi
			5: 
				Limpiar Pantalla
				Escribir 'La sesi�n ha sido finalizada con �xito'
				Escribir 'Hasta pronto ', rut_digitado
				repetir_menu = 0
			De otro modo:
				Limpiar Pantalla
				Escribir "Opci�n no v�lida"
		FinSegun
		
		Si (seleccion_opcion > 0 Y seleccion_opcion <= 4) O seleccion_opcion >= 6 Entonces
			Escribir ''
			Escribir ''
			Escribir 'Para volver al Men� principal presione (1)'
			Escribir 'Para finalizar presione (0)'
			Leer repetir_menu
		FinSi
		
	Hasta Que repetir_menu == 0
FinSubProceso

Funcion Voucher(seleccion_opcion, saldo_total, monto_abonado, monto_girado, pin_inicial, nuevo_pin_2)
	Segun seleccion_opcion Hacer
		1:
			Limpiar Pantalla
			Escribir ' ======== BANCO PATITO ========'
			Escribir '| C�digo de transacci�n: BP', AZAR(500), 'FX'
			Escribir '| Fecha de transacci�n: 30/06/2024'
			Escribir '| ======== VALOR CTA CTE ========'
			Escribir '| Saldo Total: $', saldo_total
			Escribir ' ======= FIN TRANSACCION ======='
		2:
			Limpiar Pantalla
			Escribir ' ======== BANCO PATITO ========'
			Escribir '| C�digo de transacci�n: BP', AZAR(500), 'FX'
			Escribir '| Fecha de transacci�n: 30/06/2024'
			Escribir '| ======== ABONO CTA CTE ========'
			Escribir '| Monto Abonado: $', monto_abonado
			Escribir '| Saldo Total: $', saldo_total
			Escribir ' ======= FIN TRANSACCION ======='
		3:
			Limpiar Pantalla
			Escribir ' ======== BANCO PATITO ========'
			Escribir '| C�digo de transacci�n: BP', AZAR(500), 'FX'
			Escribir '| Fecha de transacci�n: 30/06/2024'
			Escribir '| ======== GIRO CTA CTE ========'
			Escribir '| Monto Girado: $', monto_girado
			Escribir '| Saldo Total: $', saldo_total
			Escribir ' ====== FIN TRANSACCION ======='
		4:
			Limpiar Pantalla
			Escribir ' ======== BANCO PATITO ========'
			Escribir '| C�digo de transacci�n: BP', AZAR(500), 'FX'
			Escribir '| Fecha de transacci�n: 30/06/2024'
			Escribir '| == CAMBIO DE PIN REALIZADO =='
			Escribir '| PIN Anterior: ', pin_inicial
			Escribir '| PIN Nuevo: ', nuevo_pin_2
			Escribir ' ====== FIN TRANSACCION ======'
	FinSegun
FinFuncion