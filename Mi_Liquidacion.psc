Algoritmo Liquidacion_Sueldo
	Definir sueldoBaseValido, cargasValidas, movilizacion, colacion, gratificacion, totalHaberesImponibles, afp, salud, seguroCesantia, totalDescuentosLegales, asignacionFamiliar Como Real
	Definir largoSueldoBase, largoCargas Como Entero
	Definir sueldoBase, cargasFamiliares Como Cadena
	Definir esValorCorrecto Como Logico
	
	Limpiar Pantalla
	
	Repetir
		Escribir 'Por favor ingrese un Sueldo Base mayor o igual 460000'
		Leer sueldoBase
		largoSueldoBase <- Longitud(sueldoBase)
		esValorCorrecto <- Verdadero
		
		Si largoSueldoBase > 0 Entonces //Validación para que incluso ingresando un valor vacío (ENTER), vuelva a solicitar ingresar un monto
			esValorCorrecto <- ValidaNumeros(sueldoBase, largoSueldoBase, esValorCorrecto) //Si retorna falso, siempre se repetira el ciclo, si no retorna Falso, se mantendrá Verdadero y terminará el ciclo
			Si esValorCorrecto = Verdadero Entonces
				sueldoBaseValido <- ConvertirANumero(sueldoBase)
				Si sueldoBaseValido < 460000 Entonces
					Escribir 'Ha ingresado un valor de Sueldo Base inferior a 460000, Por favor intentelo nuevamente'
					esValorCorrecto <- Falso
				FinSi
			FinSi
		SiNo
			esValorCorrecto <- Falso
		FinSi
	Hasta Que esValorCorrecto = Verdadero
	
	Limpiar Pantalla
	
	Repetir
		Escribir 'Por favor ingrese el numero de cargas familiares'
		Leer cargasFamiliares
		largoCargas <- Longitud(cargasFamiliares)
		esValorCorrecto <- Verdadero
		
		Si largoCargas > 0 Entonces
			esValorCorrecto <- ValidaNumeros(cargasFamiliares, largoCargas, esValorCorrecto)
			Si esValorCorrecto = Verdadero Entonces
				cargasValidas <- ConvertirANumero(cargasFamiliares)
				Si cargasValidas >= 10 Entonces
					Escribir 'La cantidad de cargas familiares no puede ser superior a 10, Por favor Intentelo nuevamente'
					esValorCorrecto <- Falso
				SiNo
					esValorCorrecto <- Verdadero
				FinSi
			FinSi
		SiNo
			esValorCorrecto <- Falso
		FinSi
	Hasta Que esValorCorrecto = Verdadero
	
	Limpiar Pantalla
	
	movilizacion <- 35000
	colacion <- 40000
	gratificacion <- (sueldoBaseValido) * (25/100)
	totalHaberesImponibles <- sueldoBaseValido + gratificacion
	afp <- (totalHaberesImponibles) * (10/100)
	salud <- (totalHaberesImponibles) * (7/100)
	seguroCesantia <- (totalHaberesImponibles) * (0.6/100)
	totalDescuentosLegales <- afp + salud + seguroCesantia
	
	Si sueldoBaseValido >= 0 Y sueldoBaseValido < 539328 Entonces
		asignacionFamiliar <- 20328 * cargasValidas
	SiNo
		Si sueldoBaseValido >= 539328 Y sueldoBaseValido < 787746 Entonces
			asignacionFamiliar <- 12475 * cargasValidas
		SiNo
			Si sueldoBaseValido >= 787746 Y sueldoBaseValido < 1228614 Entonces
				asignacionFamiliar <- 3942 * cargasValidas
			SiNo
				asignacionFamiliar <- 0
			FinSi
		FinSi
	FinSi
	
	totalHaberesNoImponibles <- asignacionFamiliar + movilizacion+colacion
	totalHaberes <- totalHaberesImponibles + totalHaberesNoImponibles
	totalDescuentosLegales <- afp + salud + seguroCesantia
	sueldoLiquido <- totalHaberes - totalDescuentosLegales
	
	Escribir ' Sueldo Base:        ', sueldoBaseValido
	Escribir ' Gratificación:      ', gratificacion, '               ----------> 25 % conceptos gratificables'
	Escribir '      Total haberes imponibles    ', totalHaberesImponibles
	Escribir ' Asignación familiar ', asignacionFamiliar
	Escribir ' movilizacion        ', movilizacion
	Escribir ' colación            ', colacion
	Escribir '      Total haberes no imponibles ', totalHaberesNoImponibles
	Escribir '      Total Haberes               ', totalHaberes
	Escribir ' AFP                 ', afp
	Escribir ' Salud               ', salud
	Escribir ' Seguro de Cesantía  ', seguroCesantia, '               -----------> Contrato indefinido -> 0.6 % '
	Escribir ' Total descuentos legales         ', totalDescuentosLegales
	Escribir ' El sueldo líquido es:            ', sueldoLiquido
	
FinAlgoritmo

Funcion resultado <- ValidaNumeros(valorVariable, largo, operadorLogico)
	Definir numEvaluar Como Cadena
	Para i<-1 Hasta largo Con Paso 1 Hacer
		numEvaluar <- Subcadena(valorVariable,i,i);
		Si numEvaluar<>'0' Y numEvaluar<>'1' Y numEvaluar<>'2' Y numEvaluar<>'3' Y numEvaluar<>'4' Y numEvaluar<>'5' Y numEvaluar<>'6' Y numEvaluar<>'7' Y numEvaluar<>'8' Y numEvaluar<>'9' Entonces
			operadorLogico <- Falso
		FinSi
	FinPara
	resultado <- operadorLogico
FinFuncion