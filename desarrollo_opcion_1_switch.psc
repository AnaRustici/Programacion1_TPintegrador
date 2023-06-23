Algoritmo TP_Programacion
	definir articulos, rubro, codigo como caracter;
	definir cant, i, j, rub, cod, venta1, venta2, suma, op, long como entero;
	suma=0;
	rubro="";
	codigo="";
	
	Escribir "Ingrese la cantidad de articulos que desea cargar:";
	leer cant;
	dimension articulos[cant,7];
	long<-cant;
	
	para i=0 hasta cant-1 con paso 1 Hacer
		Escribir "ARTICULO ", i+1, ":";
		Escribir "Ingrese el codigo:";
		Escribir "(3 primeros digitos para el rubro)";
		Escribir "100 - Tornillos y tuercas";
		Escribir "300 - Adhesivos";
		Escribir "450 - Herrajes";
		Escribir "680 - Pinturas";
		Escribir "720 - Electricidad";
		leer rub;
		Escribir "(5 digitos para el numero de articulo)";
		leer cod;
		Valido(rub, cod, rubro, codigo);
		articulos[i,0]=Concatenar(rubro, codigo);
		Escribir "Ingrese la descripcion:";
		leer articulos[i,1];
		Escribir "Ingrese el precio:";
		leer articulos[i,2];
		Escribir "Ingrese el stock:";
		leer articulos[i,3];
		Escribir "Ingrese la cantidad vendida en la 1° quincena:";
		leer articulos[i,4];
		venta1=ConvertirANumero(articulos[i,4]);
		Escribir "Ingrese la cantidad vendida en la 2° quincena:";
		leer articulos[i,5];
		venta2=ConvertirANumero(articulos[i,5]);
		suma=venta1+venta2;
		articulos[i,6]=ConvertirATexto(suma);
		suma=0;
	FinPara
	Repetir
		Escribir "Seleccione una opcion:";
		escribir "1. Mostrar lista de artículos ordenada por descripción";
		escribir "2. Mostrar lista de artículos ordenada por cantidad vendida";
		escribir "3. Mostrar stock actual de artículos";
		escribir "4. Buscar artículo por código";
		escribir "5. Mostrar estadísticas";
		escribir "6. Salir";
		leer op;
		Segun op Hacer
			caso 1:
				definir primer_pos Como entero
				Definir auxiliar Como Caracter
				para i = 0 hasta cant -2 con paso 1 Hacer
					primer_pos = i
					para j = i + 1 hasta cant -1 con paso 1 Hacer
						si articulos[j, 0] <> articulos[primer_pos,0] Entonces
							primer_pos = j
						FinSi
					FinPara
					auxiliar = articulos[i,0]
					articulos[i,0] = articulos [primer_pos,0]
					articulos[primer_pos,0] = auxiliar
				FinPara
				
				Para i = 0 Hasta cant -1 Con Paso 1 Hacer
					Escribir "codigo: " articulos[i,0]
					Escribir "descripcion: ", articulos[i,1]
					Escribir "precio de venta: ", articulos[i, 2],"$"
					Escribir ""
				FinPara
		FinSegun
		si op<>1 & op<>2 & op<>3 & op<>4 & op<>5 & op<>6 Entonces
			Escribir "Opcion inexistente";
		FinSi
	Hasta Que op=6

FinAlgoritmo

subproceso Valido(rub, cod, rubro por referencia, codigo por referencia)
	definir i como entero;
	definir valid como logico;	
	Repetir
		si rub<>100 & rub<>300 & rub<>450 & rub<>680 & rub<>720 | cod<10000 | cod>99999 Entonces
			valid=falso;
			Escribir "Codigo invalido. Vuelva a intentarlo";
			Escribir "Rubro:";
			leer rub;
			Escribir "Numero de articulo:";
			leer cod;
		SiNo
			valid=verdadero;
			rubro=ConvertirATexto(rub);
			codigo=ConvertirATexto(cod);
		FinSi
	Hasta Que valid=verdadero	
Finsubproceso
