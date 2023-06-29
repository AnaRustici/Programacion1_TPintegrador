
Algoritmo TP_Programacion
	//Variables para carga de articulos
	definir articulos, rubro, codigo como caracter;
	definir cant, i, j, rub, cod, venta1, venta2, suma, op,precio_validacion,stock_validacion como entero;
	//Variables para opciones de menú
	definir buscarCodigo, auxArt como caracter;
	definir stock, ventaMes, stock_actual, totalVentas, stockAct como entero;
	definir codValido como logico;
	definir precio, importeTotal, mayor1, mayor2, pje, porcentaje1, porcentaje2 como real;
	dimension porcentaje1[5];
	dimension porcentaje2[5];
	Dimension pje[5];
	dimension auxArt[5,3];
	buscarCodigo="";
	precio=0;
	importeTotal=0;
	stock=0;
	ventaMes=0;
	suma=0;
	rubro="";
	codigo="";
	totalVentas=0;
	
	//un ciclo para que el espacio de memoria tengo cero y no otra cosa 
	para i=0 hasta 4 con paso 1 Hacer
		porcentaje1[i]=0;
		porcentaje2[i]=0;
		pje[i]=0;
	FinPara
	
	//el usuario ingresa la cantidad de articulos que va a cargar (puede ser de distintos rubros)
	Escribir "Ingrese la cantidad de articulos que desea cargar:";
	leer cant;
	validar_datos(cant);
	//estos arreglos estan definidos aca ya que estan influenciados por la variable "cant"
	dimension articulos[cant,8];
	
	
	//un ciclo para cargar cada dato del articulo
	para i=0 hasta cant-1 con paso 1 Hacer
		Escribir "ARTICULO ", i+1, ":";
		Escribir "Ingrese el codigo:";
		//funcion para validar el codigo y ademas convertirlo a texto para guardarlo en el arreglo de caracteres
		ValidarCodigo(rub, cod, rubro, codigo);
		// concatenamos el rubro y el codigo para poder guardarlo en una sola posicion del arreglo
		articulos[i,0]=Concatenar(rubro, codigo);
		
		//ingeso de descripcion
		Escribir "Ingrese la descripcion:";
		leer articulos[i,1];
		Escribir "Ingrese el precio:";
		
		//ingreso de precio
		leer precio_validacion;
		Mientras precio_validacion <= 0 Hacer
			Escribir "ingresaste mal el precio, vuelve a ingresarlo: ";
			leer precio_validacion;
		FinMientras
		articulos[i,2] = ConvertirATexto(precio_validacion);
		
		//ingreso de stock
		Escribir "Ingrese el stock:";
		leer stock_validacion;
		Mientras stock_validacion < 0 Hacer
			Escribir "ingresaste mal el stock, vuelve a ingresarlo: ";
			leer stock_validacion;
		FinMientras
		articulos[i,3] = ConvertirATexto(stock_validacion);
		
		Repetir
			//ingreso de la cantidad vendida en la 1er quincena
			Escribir "Ingrese la cantidad vendida en la 1° quincena:";
			leer venta1;
			Mientras venta1 < 0 Hacer
				Escribir "ingresaste mal la venta por quincena, vuelve a ingresarlo: ";
				leer venta1;
			FinMientras
			
			//ingreso de la cantidad vendida en la 2da quincena
			Escribir "Ingrese la cantidad vendida en la 2° quincena:";
			leer venta2;
			Mientras venta2 < 0 Hacer
				Escribir "ingresaste mal la venta por quincena, vuelve a ingresarlo: ";
				leer venta2;
			FinMientras
			//suma equivale a la suma total de las dos quincenas.
			suma=venta1+venta2;
			si suma>stock_validacion Entonces
				Escribir "Error. Las ventas no pueden ser mayores que la cantidad de articulos existentes.";
			FinSi
		Hasta Que suma<stock_validacion
		
		//convertimos luego a texto para que pueda guardarse en el arreglo
		articulos[i,4] = ConvertirATexto(venta1);
		articulos[i,5] = ConvertirATexto(venta2);
		articulos[i,6]=ConvertirATexto(suma);
		//guardamos el valor del stock actual de ese producto en una variable, y luego lo guardamos en una posicion del arreglo principal
		stock_actual = ConvertirANumero(articulos[i,3]) - suma;
		articulos[i,7] = ConvertirATexto(stock_actual);
		suma=0;
	FinPara
	//totalVentas sera la suma total de todos los articulos
	Para i = 0 Hasta cant -1 Con Paso 1 Hacer
		ventaMes=ConvertirANumero(articulos[i,6]);
		totalVentas=totalVentas+ventaMes;
	FinPara
	
	//finalizamos la carga de articulos y comenzamos a operar en el menu
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
				//ordenar todos los articulos por descripcion
				OrdenarPorDescripcion(articulos, cant);
				Para i = 0 Hasta cant -1 Con Paso 1 Hacer
					Escribir "Codigo: ", articulos[i,0];
					Escribir "Descripcion: ", articulos[i,1];
					Escribir "Precio de venta: $", articulos[i, 2];
					Escribir "";
				FinPara
			2:
				//ordenar todos los articulos por venta total  de manera descendiente
				OrdenarPorVenta(articulos, cant);
				Para i = 0 Hasta cant -1 Con Paso 1 Hacer
					Escribir "Codigo: ", articulos[i,0];
					Escribir "Descripcion: ", articulos[i,1];
					Escribir "Cantidad total vendida en el mes: ", articulos[i, 6];
					Escribir "";
				FinPara
				Escribir "Monto total de ventas realizadas en el mes: ", totalVentas;
				Escribir "";
			3:
				//mostrar stock actual de articulos
				Escribir "Mostrar stock actual de artículos";
				Para i = 0 Hasta cant - 1 Con Paso 1 Hacer
					Escribir "Codigo: ", articulos[i,0];
					Escribir "Descripcion: ", articulos[i,1];
					Escribir "Stock actual: ", articulos[i,7];
					Escribir "";
				FinPara
			4:
				//buscar articulo por codigo
				codValido=falso;
				Escribir "Ingrese el codigo del articulo que desea buscar:";
				//validamos que el codigo ingresado sea correcto y luego comparamos con el que ingrese
				ValidarCodigo(rub, cod, rubro, codigo);
				buscarCodigo=Concatenar(rubro,codigo);
				para i=0 hasta cant-1 con paso 1 Hacer
					si articulos[i,0]==buscarCodigo Entonces
						codValido=Verdadero;
						Escribir "Codigo: ", articulos[i,0];
						Escribir "Descripcion: ", articulos[i,1];
						Escribir "Cantidad vendida en la 1° quincena: ", articulos[i,4];
						Escribir "Cantidad vendida en la 2° quincena: ", articulos[i,5];
						//stock=ConvertirANumero(articulos[i,3]);
						//stockAct=stock-ventaMes;
						Escribir "Stock actual: ", articulos[i,7];
						precio=ConvertirANumero(articulos[i,2]);
						ventaMes=ConvertirANumero(articulos[i,6]);
						importeTotal=precio*ventaMes;
						Escribir "Importe total de venta: ", "$", importeTotal;
						Escribir "";
					FinSi
				FinPara
				si codValido=falso Entonces
					Escribir "No existe artículo con ese código.";
					Escribir "";
				FinSi
				
			5:  //mostrar estadisticas
				//priner estadistica: porcentaje de la cantidad de articulos vendidos de cada rubro del total de ventas
				Escribir "Porcentaje de la cantidad de artículos vendidos de cada rubro sobre la cantidad total de ventas:";
				estadisticaPrimerPunto(articulos, cant, totalVentas, pje);
				Escribir "Rubro: Tornillos y tuercas(100): ", pje[0], "%";
				Escribir "Rubro: Adhesivos(300): ", pje[1], "%";
				Escribir "Rubro: Herrajes(450): ", pje[2], "%";
				Escribir "Rubro: Pinturas(680): ", pje[3], "%";
				Escribir "Rubro: Electricidad(720): ", pje[4], "%";
				Escribir "";
				
				//porcentaje de venta de cada quincena de cada rubro (sobre el total del mes del mismo rubro y no del total)
				escribir "Porcentaje de venta de cada quincena por Rubro sobre el total del mes:";
				estadisticaSegundoPunto(articulos, cant, porcentaje1, porcentaje2);
				Escribir "Tornillos y tuercas(100): ";
				Escribir "Primera quincena: ", porcentaje1[0], "%";
				Escribir "Segunda quincena: ", porcentaje2[0], "%";
				Escribir "Adhesivos(300): ";
				Escribir "Primera quincena: ", porcentaje1[1], "%";
				Escribir "Segunda quincena: ", porcentaje2[1], "%";
				Escribir "Herrajes(450): ";
				Escribir "Primera quincena: ", porcentaje1[2], "%";
				Escribir "Segunda quincena: ", porcentaje2[2], "%";
				Escribir "Pinturas(680): ";
				Escribir "Primera quincena: ", porcentaje1[3], "%";
				Escribir "Segunda quincena: ", porcentaje2[3], "%";
				Escribir "Electricidad(720): ";
				Escribir "Primera quincena: ", porcentaje1[4], "%";
				Escribir "Segunda quincena: ", porcentaje2[4], "%";
				Escribir "";
				
				//rubro de mayor monto recaudado de cada quincena
				Escribir "Rubro con mayor importe total de ventas en cada quincena";
				estadisticaTercerPunto(articulos, cant, mayor1, mayor2, auxArt);
				Escribir "Primera quincena:";
				Escribir "Rubro con mayor importe total: ", auxArt[mayor1,0], " - Importe total: $", auxArt[mayor1,1];
				Escribir "Segunda quincena:";
				Escribir "Rubro con mayor importe total: ", auxArt[mayor2,0], " - Importe total: $", auxArt[mayor2,2];
				escribir "";
		FinSegun
	Hasta Que op=6
	Escribir "Fin del programa. Gracias";
FinAlgoritmo


//subproceso para validar la cantidad ingresada
SubProceso validar_datos(cant Por Referencia)
	Mientras cant <= 0 Hacer
		Escribir "dato invalido.";
		Escribir "volve a ingresar la cantidad: ";
		Leer cant;
	FinMientras
FinSubProceso


//subproceso para validar el rubro y el codigo del articulo, ademas de convertirlo a texto Para que se guarde en el arreglo
subproceso ValidarCodigo(rub por referencia, cod por referencia, rubro Por Referencia, codigo Por Referencia)
	definir i como entero;
	Escribir "(3 primeros digitos para el rubro)";
	Escribir "100 - Tornillos y tuercas";
	Escribir "300 - Adhesivos";
	Escribir "450 - Herrajes";
	Escribir "680 - Pinturas";
	Escribir "720 - Electricidad";
	leer rub;
	mientras rub <> 100 & rub <> 300 & rub <> 450 & rub <> 680 & rub <> 720 hacer
		Escribir "Rubro invalido, ingrese nuevamente:";
		Leer rub;
	Finmientras
	Escribir "(5 digitos para el numero de articulo)";
	leer cod;
	mientras cod < 10000 | cod > 99999 hacer
		Escribir "Código invalido, ingrese nuevamente:";
		Leer cod;
	Finmientras
	rubro=ConvertirATexto(rub);
	codigo=ConvertirATexto(cod);	
Finsubproceso


//subproceso para ordenar por descripcion el arreglo
subproceso OrdenarPorDescripcion(articulos Por Referencia, cant)
	definir primer_pos, k, i, j Como entero;
	Definir auxiliarArt Como Caracter;
	dimension auxiliarArt[8];
	para i = 0 hasta cant -2 con paso 1 Hacer
		primer_pos = i;
		para j = i + 1 hasta cant -1 con paso 1 Hacer
			si articulos[j, 1] < articulos[primer_pos,1] Entonces
				primer_pos = j;
			FinSi
		FinPara
	    //la variable k recorre todo el arreglo para poder guardar todos los datos de un mismo arreglo en la misma posicion
		para k=0 hasta 7 con paso 1 Hacer
			auxiliarArt[k] = articulos[i,k];
			articulos[i,k] = articulos[primer_pos,k];
			articulos[primer_pos,k] = auxiliarArt[k];
		FinPara
	FinPara
FinSubProceso


//subproceso para ordenar por venta de manera descendiente
subproceso OrdenarPorVenta(articulos Por Referencia, cant)
	definir i, j, k, primer_pos como entero;
	Definir auxiliarArt Como Caracter;
	dimension auxiliarArt[8];
	para i = 0 hasta cant -2 con paso 1 Hacer
		primer_pos = i;
		para j = i + 1 hasta cant -1 con paso 1 Hacer
			si articulos[j, 6] > articulos[primer_pos,6] Entonces
				primer_pos = j;
			FinSi
		FinPara
        //la variable k recorre todo el arreglo para poder guardar todos los datos de un mismo arreglo en la misma posicion
		para k=0 hasta 7 con paso 1 Hacer
			auxiliarArt[k] = articulos[i,k];
			articulos[i,k] = articulos[primer_pos,k];
			articulos[primer_pos,k] = auxiliarArt[k];
		FinPara
	FinPara
FinSubProceso

//subproceso para calcular porcentaje de cada rubro
subproceso estadisticaPrimerPunto(articulos, cant, totalVentas, pje)
	definir aux como caracter;
	definir i, acum1, acum2, acum3, acum4, acum5, auxArt como entero;
	dimension auxArt[cant];
	acum1=0;
	acum2=0;
	acum3=0;
	acum4=0;
	acum5=0;
	para i=0 hasta cant-1 con paso 1 Hacer
		auxArt[i]=ConvertirANumero(articulos[i,6]);
		aux=Subcadena(articulos[i,0],0,2);
		si aux=="100" Entonces
			acum1=acum1+auxArt[i];
			pje[0]=acum1*100/totalVentas;
		SiNo
			si aux=="300" Entonces
				acum2=acum2+auxArt[i];
				pje[1]=acum2*100/totalVentas;
			SiNo
				si aux=="450" Entonces
					acum3=acum3+auxArt[i];
					pje[2]=acum3*100/totalVentas;
				SiNo
					si aux=="680" Entonces
						acum4=acum4+auxArt[i];
						pje[3]=acum4*100/totalVentas;
					SiNo
						acum5=acum5+auxArt[i];
						pje[4]=acum5*100/totalVentas;
					FinSi
				FinSi
			FinSi
		FinSi
	FinPara
FinSubProceso


//subproceso para calcular porcentaje de cada venta de cada rubro por quincena
SubProceso estadisticaSegundoPunto(articulos, cant, porcentaje1 por referencia, porcentaje2 Por Referencia)
	definir i, k como entero;
	definir aux como caracter;
	definir q1, q2, vMes como entero;
	definir acumQ1, acumQ2, acumVM como real;
	dimension acumQ1[5];
	dimension acumQ2[5];
	dimension acumVM[5];
	para i=0 hasta 4 con paso 1 Hacer
		acumQ1[i]=0;
	FinPara
	para i=0 hasta 4 con paso 1 Hacer
		acumQ2[i]=0;
	FinPara
	para i=0 hasta 4 con paso 1 Hacer
		acumVM[i]=0;
	FinPara
	para i=0 hasta cant-1 con paso 1 Hacer
		q1=ConvertirANumero(articulos[i,4]);
		q2=ConvertirANumero(articulos[i,5]);
		vMes=ConvertirANumero(articulos[i,6]);
		aux=Subcadena(articulos[i,0],0,2);
		si aux=="100" Entonces
			acumQ1[0]=acumQ1[0]+q1;
			acumQ2[0]=acumQ2[0]+q2;
			acumVM[0]=acumVM[0]+vMes;
			porcentaje1[0]=acumQ1[0]*100/acumVM[0];
			porcentaje2[0]=acumQ2[0]*100/acumVM[0];
		SiNo
			si aux=="300" Entonces
				acumQ1[1]=acumQ1[1]+q1;
				acumQ2[1]=acumQ2[1]+q2;
				acumVM[1]=acumVM[1]+vMes;
				porcentaje1[1]=acumQ1[1]*100/acumVM[1];
				porcentaje2[1]=acumQ2[1]*100/acumVM[1];
			SiNo
				si aux=="450" Entonces
					acumQ1[2]=acumQ1[2]+q1;
					acumQ2[2]=acumQ2[2]+q2;
					acumVM[2]=acumVM[2]+vMes;
					porcentaje1[2]=acumQ1[2]*100/acumVM[2];
					porcentaje2[2]=acumQ2[2]*100/acumVM[2];
				SiNo
					si aux=="680" Entonces
						acumQ1[3]=acumQ1[3]+q1;
						acumQ2[3]=acumQ2[3]+q2;
						acumVM[3]=acumVM[3]+vMes;
						porcentaje1[3]=acumQ1[3]*100/acumVM[3];
						porcentaje2[3]=acumQ2[3]*100/acumVM[3];
					SiNo
						acumQ1[4]=acumQ1[4]+q1;
						acumQ2[4]=acumQ2[4]+q2;
						acumVM[4]=acumVM[4]+vMes;
						porcentaje1[4]=acumQ1[4]*100/acumVM[4];
						porcentaje2[4]=acumQ2[4]*100/acumVM[4];
					FinSi
				FinSi
			FinSi
		FinSi
	FinPara
FinSubProceso


//subproceso para calcular el rubro con mayor monto total de las dos quincenas
subproceso estadisticaTercerPunto(articulos, cant, mayor1 por referencia, mayor2 por referencia, auxArt)
	definir i, j, q1, q2 como entero;
	definir precio, total1, total2, impTotal, auxMayor como real;
	definir aux como caracter;
	dimension impTotal[5,2];
	auxArt[0,0]="Tornillos y tuercas(100)";
	auxArt[1,0]="Adhesivos(300)";
	auxArt[2,0]="Herrajes(450)";
	auxArt[3,0]="Pinturas(680)";
	auxArt[4,0]="Electricidad(720)";
	//bucles para inicializar el arreglo
	para i=0 hasta 4 con paso 1 Hacer
		para j=1 hasta 2 con paso 1 Hacer
			auxArt[i,j]="";
		FinPara
	FinPara
	para i=0 hasta 4 con paso 1 Hacer
		para j=0 hasta 1 con paso 1 Hacer
			impTotal[i,j]=0;
		FinPara
	FinPara
	
	para i=0 hasta cant-1 con paso 1 Hacer
		q1=ConvertirANumero(articulos[i,4]);
		q2=ConvertirANumero(articulos[i,5]);
		precio=ConvertirANumero(articulos[i,2]);
		//capturamos los 3 primeros numeros del codigo
		aux=Subcadena(articulos[i,0],0,2);
		si aux=="100" Entonces
			total1=precio*q1;
			total2=precio*q2;
			impTotal[0,0]=impTotal[0,0]+total1;
			impTotal[0,1]=impTotal[0,1]+total2;
		SiNo
			si aux=="300" Entonces
				total1=precio*q1;
				total2=precio*q2;
				impTotal[1,0]=impTotal[1,0]+total1;
				impTotal[1,1]=impTotal[1,1]+total2;
			SiNo
				si aux=="450" Entonces
					total1=precio*q1;
					total2=precio*q2;
					impTotal[2,0]=impTotal[2,0]+total1;
					impTotal[2,1]=impTotal[2,1]+total2;
				SiNo
					si aux=="680" Entonces
						total1=precio*q1;
						total2=precio*q2;
						impTotal[3,0]=impTotal[3,0]+total1;
						impTotal[3,1]=impTotal[3,1]+total2;
					SiNo
						total1=precio*q1;
						total2=precio*q2;
						impTotal[4,0]=impTotal[4,0]+total1;
						impTotal[4,1]=impTotal[4,1]+total2;
					FinSi
				FinSi
			FinSi
		FinSi
		total1=0;
		total2=0;
	FinPara
	para i=0 hasta 4 con paso 1 Hacer
		auxArt[i,1]=ConvertirATexto(impTotal[i,0]);
		auxArt[i,2]=ConvertirATexto(impTotal[i,1]);
	FinPara
	para i=0 hasta 4 con paso 1 Hacer
		si i=0 Entonces
			auxMayor=ConvertirANumero(auxArt[i,1]);
			mayor1=i;
		FinSi
		si ConvertirANumero(auxArt[i,1]) > auxMayor Entonces
			auxMayor = ConvertirANumero(auxArt[i,1]);
			mayor1=i;
		FinSi
	FinPara
	para i=0 hasta 4 con paso 1 Hacer
		si i=0 Entonces
			auxMayor=ConvertirANumero(auxArt[i,2]);
			mayor2=i;
		FinSi
		si ConvertirANumero(auxArt[i,2]) > auxMayor Entonces
			auxMayor = ConvertirANumero(auxArt[i,2]);
			mayor2=i;
		FinSi
	FinPara
FinSubProceso
