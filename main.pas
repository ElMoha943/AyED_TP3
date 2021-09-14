// Trabajo Práctico 3 - AyED comisión 102
// Integrantes: Valentino Casadidio, Sebastian Giordanino, Mateo Querede
program tpayed2;
uses crt, sysutils;

type
	empresas = record
		cod_emp : string;
		nombre : string;
		direccion : string;
		mail : string;
		telefono : string;
		cod_ciudad : string;
	end;

	ciudades = record
		cod_ciudad : string;
		nombre: string;
	end;

	clientes = record
		dni : string;
		nombre : string;
		mail : string
	end;

	proyectos = record
		cod_proy : string;
		cod_emp : string;
		etapa : char;
		tipo : char;
		cod_ciudad : string;
		cantidad : array[1..3] of integer; 
	end;

	prodcutos = record
		cod_prod : string;
		cod_proy : string;
		precio : integer;
		estado : string; //bool?
		detalle: string;
	end;

var
	option: char;
	access, pass: boolean;
	contEmpresas, contCiudades, contClientes, contProyectos, i: integer;
	next: integer;

	empresa: empresas;
	ciudad: ciudades;
	cliente: clientes;
	proyecto: proyectos;
	producto: prodcutos;

	docEmpresas: file of empresas;
	docCiudades: file of ciudades;
	docClientes: file of clientes;
	docProyectos: file of proyectos;
	docProductos: file of prodcutos;

//MANEJO DE ARCHIVOS

procedure initDocs();
	begin
		//Ciudades
		assign(docCiudades,'Ciudades.dat');
		{$I-} // Errors will lead to an EInOutError exception (default)
		reset(docCiudades);
		If ioresult = 2 then
			rewrite(docCiudades);
		{$I+} // Suppress I/O errors: check the IOResult variable for the error code

		//Clientes
		assign(docClientes,'Clientes.dat');
		{$I-}
		reset(docClientes);
		If ioresult = 2 then
			rewrite(docClientes);
		{$I+}

		//Empresas
		assign(docEmpresas,'Empresas.dat');
		{$I-}
		reset(docEmpresas);
		If ioresult = 2 then
			rewrite(docEmpresas);
		{$I+}

		//Proyectos
		assign(docProyectos,'Proyectos.dat');
		{$I-}
		reset(docProyectos);
		If ioresult = 2 then
			rewrite(docProyectos);
		{$I+}

		//Productos
		assign(docProductos,'Productos.dat');
		{$I-}
		reset(docProductos);
		If ioresult = 2 then
			rewrite(docProductos);
		{$I+}
	end;

procedure closeDocs();
	begin
		close(docCiudades);
		close(docClientes);
		close(docEmpresas);
		close(docProyectos);
		close(docProductos);
	end;

//ALTAS

procedure altaCiudad();
	begin
		repeat
			writeln('Ingrese el codigo de la ciudad');
			readln(ciudad.cod_ciudad);
			writeln('Ingrese el nombre de la ciudad');
			readln(ciudad.nombre);
			write(docCiudades,ciudad);
			repeat
				writeln('Ingrese 1 para ingresar otra ciudad o 0 para salir');
				readln(next);
			until ((next = 0) or (next = 1)) ;
		until (next = 0);
	end;

procedure altaCliente();
	begin
		repeat
			writeln('Ingrese el dni del cliente');
			readln(cliente.dni);
			writeln('Ingrese el nombre del cliente');
			readln(cliente.nombre);
			writeln('Ingrese el mail del cliente');
			readln(cliente.mail);
			write(docClientes,cliente);
			repeat
				writeln('Ingrese 1 para ingresar otro cliente o 0 para salir');
				readln(next);
			until ((next = 0) or (next = 1)) ;
		until (next = 0);
	end;

procedure altaEmpresa();
	begin
		repeat
			writeln('Ingrese el codigo de la empresa');
			readln(empresa.cod_emp);
			writeln('Ingrese el nombre de la empresa');
			readln(empresa.nombre);
			writeln('Ingrese la direccion de la empresa');
			readln(empresa.direccion);
			writeln('Ingrese el mail de la empresa');
			readln(empresa.mail);
			writeln('Ingrese el telefono de la empresa');
			readln(empresa.telefono);
			writeln('Ingrese el codigo de la ciudad asociada con la empresa');
			readln(empresa.cod_ciudad);
			write(docEmpresas,empresa);
			repeat
				writeln('Ingrese 1 para ingresar otra empresa o 0 para salir');
				readln(next);
			until ((next = 0) or (next = 1)) ;
		until (next = 0);
	end;

procedure altaProyecto();
	begin
		repeat
			writeln('Ingrese el codigo del proyecto');
			readln(proyecto.cod_proy);
			writeln('Ingrese el codigo de la empresa asociada al proyecto');
			readln(proyecto.cod_emp);
			writeln('Ingrese la etapa del proyecto');
			readln(proyecto.etapa);
			writeln('Ingrese el tipo de proyecto');
			readln(proyecto.tipo);
			writeln('Ingrese el codigo de la ciudad asociada con el proyecto');
			readln(proyecto.cod_ciudad);
			writeln('Ingrese la cantidad de productos del proyecto');
			readln(proyecto.cantidad[1]);
			// writeln('Ingrese la cantidad de consultas del proyecto');
			// readln(proyecto.cantidad[2]);
			// writeln('Ingrese la cantidad de vendidos del proyecto');
			// readln(proyecto.cantidad[3]);
			write(docProyectos,proyecto);
			repeat
				writeln('Ingrese 1 para ingresar otro proyecto o 0 para salir');
				readln(next);
			until ((next = 0) or (next = 1)) ;
		until (next = 0);
	end;

procedure altaProducto(); //NOTA: Se debe validar el maximo de productos por proyecto!
	begin
		repeat
			writeln('Ingrese el codigo del producto');
			readln(producto.cod_prod);
			writeln('Ingrese el codigo del producto');
			readln(producto.cod_proy);
			writeln('Ingrese el precio del producto');
			readln(producto.precio);
			writeln('Ingrese el estado de producto');
			readln(producto.estado);
			writeln('Ingrese el detalle del producto');
			readln(producto.detalle);
			write(docProductos,producto);
			repeat
				writeln('Ingrese 1 para ingresar otro producto o 0 para salir');
				readln(next);
			until ((next = 0) or (next = 1)) ;
		until (next = 0);
	end;

//DISPLAYS

procedure mostrarProyecto();
	begin
		//ACA LABURA PEKKE
	end;

procedure mostrarCiudades();
	begin
		//ACA LABURA PEKKE
	end;

procedure mostrarEmpresas();
	begin
		//ACA LABURA PEKKE
		// a. todas las empresas cuyas consultas fueron mayores a 10
		// b. la ciudad con más consultas de proyectos
		// c. los proyectos que vendieron todas las unidades
	end;

//MISC

procedure ordenarCiudades();
	begin
		//ACA LABURA PEKKE
	end;

//MENUS

procedure showEmpresa();
	var
		opt: char;
begin
	repeat
		ClrScr;
	    writeln(Utf8ToAnsi('MENÚ EMPRESAS DESARROLLADORAS:'+#13+#10+'1. Alta de CIUDADES '+#13+#10+'2. Alta de EMPRESAS '+#13+#10+'3. Alta de PROYECTOS'+#13+#10+'4. Alta de PRODUCTOS (mantenimiento)'+#13+#10+'5. Mostrar Ciudades'+#13+#10+'0. Volver al menú principal'));
	    repeat
	    	opt := readKey;
	    until (opt = '1') or (opt = '2') or (opt = '3') or (opt = '4') or (opt = '0') or (opt = '5');
	    case opt of
	    	'1': altaCiudad();
	    	'2': altaEmpresa();
	    	'3': altaProyecto();
	    	'4': ;
	    	'5': mostrarCiudades();
	    end;
	until (opt = '0');
end;
	
procedure showCliente();
	var
		opt: char;
begin
	repeat
		ClrScr;
		writeln(Utf8ToAnsi('MENÚ CLIENTES:'+#13+#10+'1. Alta de CLIENTES '+#13+#10+'2. Consulta de PROYECTOS'+#13+#10+'0. Volver al menú principal'));
		repeat
      opt := readKey;
    until (opt = '1') or (opt = '2') or (opt = '0');
    case opt of
	    '1': altaCliente(); //El alta ahora debe realizarse automaticamente!
	    '2': mostrarProyecto();
    end;
  until (opt = '0');
end;

function login(tipo: char): boolean;
var
  attempts: integer;
  clave, secret1, secret2 : string;
  c: char;
begin
  attempts := 3;
  clave := '';
  secret1 := 'admin123';
  secret2 := 'user123';
  while (attempts > 0) do
    begin
      attempts := (attempts-1);
      ClrScr;
      writeln('Ingrese la clave. ', attempts + 1, ' intentos restantes');
      repeat
        c := readKey;
        ClrScr;
        writeln('Ingrese la clave. ', attempts + 1, ' intentos restantes');
        if c = #08 then
        	begin
	          delete(clave,length(clave),1);
	          for i := 1 to length(clave) do
	            write('*');
        	end
        else
	        begin 
	        	if c <> #13 then
	        		begin
		            	clave := clave + c;
		            	for i := 1 to length(clave) do
		              	write('*')
		        	end;
	        end;
      until (c = #13);
      if tipo = '1' then
      	begin
        	if (clave = secret1) then
          	exit(true)
        	else
       	  	clave := '';
          	writeln('Clave incorrecta');
      	end;
      if tipo = '2' then
      	begin
        	if clave = secret2 then
          	exit(true)
        	else
          	clave := '';
          	writeln('Clave incorrecta');
      	end;
    end;
  writeln('Agotaste los intentos, programa bloqueado temporalmente.');
  Halt(0);
  exit(false);
end;

//MAIN

begin
	initDocs();
  repeat
  	ClrScr;
  	writeln(Utf8ToAnsi('MENÚ PRINCIPAL: '+#13+#10+'1. EMPRESAS'+#13+#10+'2. CLIENTES'+#13+#10+'0. Salir'+#13+#10));
	   //menu principal
		repeat
      option := readKey;
		until (option = '1') or (option = '2') or (option = '0');
		if option <> '0' then
			begin
			  //login
			  access := login(option);
		    if access then
			    begin
			       case option of
		            '1': showEmpresa();
		            '2': showCliente();
			       end;
			    end;
			end;
	until (option = '0');
	closeDocs();
end.