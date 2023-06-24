Algoritmo TP_Programacion
	//Variables para carga de articulos
	definir articulos, rubro, codigo como caracter;
	definir cant, i, j, rub, cod, venta1, venta2, suma, op como entero;
	definir valido como logico;
	//Variables para ordenamiento
	definir primer_pos, k Como entero;
	Definir auxiliarArt Como Caracter;
	dimension auxiliarArt[7];
	//Variables para opciones de menú
	definir buscarCodigo como caracter;
	definir stock, ventaMes, stock_actual como entero;
	definir codValido como logico;
	definir precio, importeTotal como real;
	suma=0;
	rubro="";
	codigo="";
	
	Escribir "Ingrese la cantidad de articulos que desea cargar:";
	leer cant;
	dimension articulos[cant,7];
	Dimension stock_actual[cant];
	
	para i=0 hasta cant-1 con paso 1 Hacer
		Escribir "ARTICULO ", i+1, ":";
		Escribir "Ingrese el codigo:";
		Repetir
			Escribir "(3 primeros digitos para el rubro)";
			Escribir "100 - Tornillos y tuercas";
			Escribir "300 - Adhesivos";
			Escribir "450 - Herrajes";
			Escribir "680 - Pinturas";
			Escribir "720 - Electricidad";
			leer rub;
			Escribir "(5 digitos para el numero de articulo)";
			leer cod;
			valido <- ValidarCodigo(rub, cod, rubro, codigo);
		hasta que valido=verdadero
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
		si op<>1 & op<>2 & op<>3 & op<>4 & op<>5 & op<>6 Entonces
			Escribir "Opcion inexistente";
		FinSi
		Segun op Hacer
			1:
				para i = 0 hasta cant -2 con paso 1 Hacer
					primer_pos = i;
					para j = i + 1 hasta cant -1 con paso 1 Hacer
						si articulos[j, 1] < articulos[primer_pos,1] Entonces
							primer_pos = j;
						FinSi
					FinPara
					para k=0 hasta 6 con paso 1 Hacer
						auxiliarArt[k] = articulos[i,k];
						articulos[i,k] = articulos[primer_pos,k];
						articulos[primer_pos,k] = auxiliarArt[k];
					FinPara
				FinPara
				
				Para i = 0 Hasta cant -1 Con Paso 1 Hacer
					Escribir "Codigo: ", articulos[i,0];
					Escribir "Descripcion: ", articulos[i,1];
					Escribir "Precio de venta: ", "$", articulos[i, 2];
					Escribir "";
				FinPara
			2:
				Escribir "Mostrar lista de artículos ordenada por cantidad vendida";
			3:
				Escribir "Mostrar stock actual de artículos";
			4:
				para i=0 hasta cant-1 con paso 1 Hacer
					stock_actual[i]=0;
				FinPara
				buscarCodigo="";
				precio=0;
				importeTotal=0;
				stock=0;
				ventaMes=0;
				codValido=falso;
				Escribir "Ingrese el codigo del articulo que desea buscar:";
				Repetir
					Escribir "(3 primeros digitos para el rubro)";
					leer rub;
					Escribir "(5 digitos para el numero de articulo)";
					leer cod;
					valido <- ValidarCodigo(rub, cod, rubro, codigo);
				hasta que valido=verdadero
				buscarCodigo=Concatenar(rubro,codigo);
				para i=0 hasta cant-1 con paso 1 Hacer
					si articulos[i,0]==buscarCodigo Entonces
						codValido=Verdadero;
						Escribir "Codigo: ", articulos[i,0];
						Escribir "Descripcion: ", articulos[i,1];
						Escribir "Cantidad vendida en la 1° quincena: ", articulos[i,4];
						Escribir "Cantidad vendida en la 2° quincena: ", articulos[i,5];
						stock=ConvertirANumero(articulos[i,3]);
						ventaMes=ConvertirANumero(articulos[i,6]);
						stock_actual[i]=stock-ventaMes;
						Escribir "Stock actual: ", stock_actual[i];
						precio=ConvertirANumero(articulos[i,2]);
						importeTotal=precio*ventaMes;
						Escribir "Importe total de venta: ", "$", importeTotal;
						Escribir "";
					FinSi
				FinPara
				si codValido=falso Entonces
					Escribir "No existe artículo con ese código.";
					Escribir "";
				FinSi
				buscarCodigo="";
		FinSegun
	Hasta Que op=6
FinAlgoritmo

subproceso valido <- ValidarCodigo(rub, cod, rubro por referencia, codigo por referencia)
	definir i como entero;
	definir valido como logico;	
	
	si rub<>100 & rub<>300 & rub<>450 & rub<>680 & rub<>720 | cod<10000 | cod>99999 Entonces
		valido=falso;
		Escribir "Codigo invalido. Vuelva a intentarlo";
	SiNo
		valido=verdadero;
		rubro=ConvertirATexto(rub);
		codigo=ConvertirATexto(cod);
	FinSi	
Finsubproceso
