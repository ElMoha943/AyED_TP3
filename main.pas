// Trabajo Práctico 3 - AyED comisión 102
// Integrantes: Valentino Casadidio, Sebastian Giordanino, Mateo Querede

Program tpayed2;

Uses crt, sysutils;

Type 
  empresas = Record
    cod_emp : string;
    nombre : string;
    direccion : string;
    mail : string;
    telefono : string;
    cod_ciudad : string;
    consultas: integer;
  End;

  ciudades = Record
    cod_ciudad : string;
    nombre: string;
    consultas: integer;
  End;

  clientes = Record
    dni : string;
    nombre : string;
    mail : string
  End;

  proyectos = Record
    cod_proy : string;
    cod_emp : string;
    etapa : char;
    tipo : char;
    cod_ciudad : string;
    cantidad : array[1..3] Of integer;
  End;

  productos = Record
    cod_prod : string;
    cod_proy : string;
    precio : integer;
    estado : boolean;
    //bool?
    detalle: string;
  End;

Var 
  option: char;
  access, pass: boolean;
  i, j: integer;
  next: integer;

  empresa: empresas;
  ciudad: ciudades;
  cliente: clientes;
  proyecto: proyectos;
  producto: productos;

  docEmpresas: file Of empresas;
  docCiudades: file Of ciudades;
  docClientes: file Of clientes;
  docProyectos: file Of proyectos;
  docProductos: file Of productos;

  //MANEJO DE ARCHIVOS

Procedure initDocs();
Begin
  //Ciudades
  assign(docCiudades,'Ciudades.dat');
  {$I-}
  // Errors will lead to an EInOutError exception (default)
  reset(docCiudades);
  If ioresult = 2 Then
    rewrite(docCiudades);
  {$I+}
  // Suppress I/O errors: check the IOResult variable for the error code

  //Clientes
  assign(docClientes,'Clientes.dat');
  {$I-}
  reset(docClientes);
  If ioresult = 2 Then
    rewrite(docClientes);
  {$I+}

  //Empresas
  assign(docEmpresas,'Empresas.dat');
  {$I-}
  reset(docEmpresas);
  If ioresult = 2 Then
    rewrite(docEmpresas);
  {$I+}

  //Proyectos
  assign(docProyectos,'Proyectos.dat');
  {$I-}
  reset(docProyectos);
  If ioresult = 2 Then
    rewrite(docProyectos);
  {$I+}

  //Productos
  assign(docProductos,'Productos.dat');
  {$I-}
  reset(docProductos);
  If ioresult = 2 Then
    rewrite(docProductos);
  {$I+}
End;

Procedure closeDocs();
Begin
  close(docCiudades);
  close(docClientes);
  close(docEmpresas);
  close(docProyectos);
  close(docProductos);
End;

//ALTAS

Procedure altaCiudad();
Begin
  Repeat
    writeln('Ingrese el codigo de la ciudad');
    readln(ciudad.cod_ciudad);
    writeln('Ingrese el nombre de la ciudad');
    readln(ciudad.nombre);
    write(docCiudades,ciudad);
    Repeat
      writeln('Ingrese 1 para ingresar otra ciudad o 0 para salir');
      readln(next);
    Until ((next = 0) Or (next = 1)) ;
  Until (next = 0);
End;

Procedure altaCliente();
Begin
  Repeat
    writeln('Ingrese el dni del cliente');
    readln(cliente.dni);
    writeln('Ingrese el nombre del cliente');
    readln(cliente.nombre);
    writeln('Ingrese el mail del cliente');
    readln(cliente.mail);
    write(docClientes,cliente);
    Repeat
      writeln('Ingrese 1 para ingresar otro cliente o 0 para salir');
      readln(next);
    Until ((next = 0) Or (next = 1)) ;
  Until (next = 0);
End;

Procedure altaEmpresa();
Begin
  Repeat
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
    Repeat
      writeln('Ingrese 1 para ingresar otra empresa o 0 para salir');
      readln(next);
    Until ((next = 0) Or (next = 1)) ;
  Until (next = 0);
End;

Procedure altaProyecto();
Begin
  Repeat
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
    proyecto.cantidad[2] := 0;
    proyecto.cantidad[3] := 0;
    write(docProyectos,proyecto);
    Repeat
      writeln('Ingrese 1 para ingresar otro proyecto o 0 para salir');
      readln(next);
    Until ((next = 0) Or (next = 1)) ;
  Until (next = 0);
End;

Procedure altaProducto();
Begin
  Repeat
    writeln('Ingrese el codigo del proyecto');
    readln(producto.cod_proy);
    //VERIFICAR QUE NO SE PUEDAN METER MAS PRODUCTOS QUE LOS ESTABLECIDOS EN EL PROYECTO
    writeln('Ingrese el codigo del producto');
    readln(producto.cod_prod);
    writeln('Ingrese el precio del producto');
    readln(producto.precio);
    producto.estado := false;
    writeln('Ingrese el detalle del producto');
    readln(producto.detalle);
    write(docProductos,producto);
    Repeat
      writeln('Ingrese 1 para ingresar otro producto o 0 para salir');
      readln(next);
    Until ((next = 0) Or (next = 1)) ;
  Until (next = 0);
End;

//DISPLAYS
Procedure mostrarProyecto();

Var 
  i, j: integer;
  opt: char;
Begin
  ClrScr;
  Repeat
    writeLn('¿Que tipo de proyecto quieres consultar?'+#13+#10+'C. Casa'+#13+#10+'D. Edificio departamentado'+#13+#10+'O. Edificio oficina'+#13+#10+'L. Loteos respectivamente?');
    opt := readKey;
    ClrScr;
  Until (opt = 'C') Or (opt = 'D') Or (opt = 'O') Or (opt = 'L');

  For i := 0 To filesize(docProyectos) Do
    Begin
      seek(docProyectos,i);
      read(docProyectos,proyecto);
      If proyecto.tipo = opt Then
        Begin
          writeln('Codigo de proyecto: ' + proyecto.cod_emp);
          For j := 0 To filesize(docEmpresas) Do
            Begin
              seek(docEmpresas,j);
              read(docEmpresas,empresa);
              If empresa.cod_emp = proyecto.cod_emp Then
                writeln('Empresa: '+ empresa.nombre);
              empresa.consultas := empresa.consultas + 1;
            End;
          Case proyecto.etapa Of 
            'P': writeln('Etapa: Preventa');
            'O': writeln('Etapa: Obra');
            'T': writeln('Etapa: Terminado');
          End;
          Case proyecto.tipo Of 
            'C': writeln('Tipo: Casa');
            'D': writeln('Tipo: Departamento');
            'O': writeln('Tipo: Oficina');
            'L': writeln('Tipo: Lote');
          End;
          For j := 0 To filesize(docCiudades) Do
            seek(docCiudades,j);
          read(docCiudades,ciudad);
          If ciudad.cod_ciudad = proyecto.cod_ciudad Then
            Begin
              writeln('Ciudad: '+ ciudad.nombre);
              ciudad.consultas := ciudad.consultas + 1;
            End;
        End;
    End;
  writeLn('Ingrese el codigo del proyecto que quiera ver');
  readln(opt);
  For i := 0 To filesize(docProyectos) Do
    Begin
      seek(docProyectos,i);
      read(docProyectos,proyecto);
      If (opt = proyecto.cod_proy) Then
        Begin
          pass := true;
          proyecto.cantidad[2] := proyecto.cantidad[2] + 1;
          break;
        End;
    End;
  If pass = true Then
    Begin
      For i := 0 To filesize(docProductos) Do
        Begin
          seek(docProductos,i);
          read(docProductos, producto);
          If ((producto.cod_proy = opt) And (producto.estado = false)) Then
            Begin
              writeLn('Codigo: '+producto.cod_prod);
              writeLn('Precio: '+IntToStr(producto.precio));
              writeLn('Detalles: '+producto.detalle);
            End;
        End;
    End
  Else
    Begin
      writeLn('Ese codigo no existe.');
    End;
  writeln('Toque cualquier tecla para continuar');
  readKey;
End;


//     B. Si un cliente se decide a comprar un producto, deberá ingresar el código del

// 		producto, mostrarle el precio y si confirma la compra, mostrar un cartel que la venta

// 		le llegará al mail: xxxx, cambiar el estado de situación del producto a “vendido”, y
// 		actualizar el acumulador de vendidos en el archivo proyectos.
Procedure comprarProducto(user: clientes);

Var
  cod, opt: String;
Begin
  writeln('Ingresa el código del producto');
  read(cod);
  For i := 0 To filesize(docProductos) Do
  Begin
    seek(docProductos,i);
    read(docProductos,producto);
    If cod = producto.cod_prod then
    Begin
      writeln('Este producto sale $' + IntToStr(producto.precio) + ', estas seguro que quieres comprarlo? (SI/NO)');
      read(opt);
      repeat
        if opt = 'SI' Then
          writeln('La venta llegará al mail' + user.mail);
          producto.estado := true;
          write(docProductos, producto);

          for j := 0 to filesize(docProyectos) Do
            begin
              seek(docProyectos,i);
              read(docProyectos,proyecto);
              if proyecto.cod_proy = producto.cod_proy then
                proyecto.cantidad[3] := proyecto.cantidad[3] + 1;
                write(docProyectos, proyecto);
            end;
      until (opt = 'SI') or (opt = 'NO');
    End
    else
    begin
      
    end;
  End;
End;

Procedure mostrarEstadisticas();
Var
  max, id: Integer;   
Begin
  ClrScr;
  max := 0;
  id := 0;
  For i := 0 To filesize(docEmpresas) Do
  Begin
    seek(docEmpresas,i);
    Read(docEmpresas,empresa);
    writeln('Empresas con mas de 10 consultas');
  End;
  If (empresa.consultas > 10) Then
    writeln(empresa.nombre);

  For i := 0 To filesize(docCiudades) Do
    Begin
      seek(docCiudades,i);
      read(docCiudades,ciudad);
      If ciudad.consultas > max Then
        Begin
          max := ciudad.consultas;
          id := i;
        End;
    End;
  writeln('La ciudad con mas consultas es '+ciudad.nombre+', con un total de '+
          IntToStr(ciudad.consultas)+' consultas registradas.');

  For i := 0 To filesize(docProyectos) Do
    Begin
      seek(docCiudades,i);
      read(docCiudades,ciudad);
      writeln('Proyectos que vendieron todas las unidades');
      If (proyecto.cantidad[1] = proyecto.cantidad[3]) Then
        writeln(proyecto.cod_proy);
    End;
  readkey;
End;

//MISC
Procedure ordenarCiudades();
Var 
  aux: ciudades;
Begin
  reset(docCiudades);
  For i := 0 To filesize(docCiudades)-2 Do
    For j := 0 To filesize(docCiudades)-1 Do
      seek(docCiudades, i);
      read(docCiudades, ciudad);
      seek(docCiudades,j);
      read(docCiudades, aux);
      If (ciudad.cod_ciudad > aux.cod_ciudad) Then
      begin
        seek(docCiudades, i);
        write(docCiudades, aux);
        seek(docCiudades,j);
        write(docCiudades, ciudad);
      end;
    end;

//MENUS
Procedure showEmpresa();
  Var 
    opt: char;
  Begin
    Repeat
      ClrScr;
      writeln(Utf8ToAnsi('MENÚ EMPRESAS DESARROLLADORAS:'+#13+#10+
              '1. Alta de CIUDADES '+#13+#10+'2. Alta de EMPRESAS '+#13+#10+
              '3. Alta de PROYECTOS'+#13+#10+
              '4. Alta de PRODUCTOS (mantenimiento)'
              +#13+#10+'0. Volver al menú principal'));
      Repeat
        opt := readKey;
      Until (opt = '1') Or (opt = '2') Or (opt = '3') Or (opt = '4') Or (opt =
            '0'
            ) Or (opt = '5');
      Case opt Of 
        '1': altaCiudad();
        '2': altaEmpresa();
        '3': altaProyecto();
        '4': mostrarEstadisticas();
      End;
    Until (opt = '0');
  End;

  Procedure showCliente();

  Var 
    opt: char;
    username: string;
    user: clientes;
  Begin
    writeln('Ingrese su nombre de usuario.');
    readln(username);
    cliente.nombre := 'Jorge';
    cliente.mail := 'puta@gmail';
    cliente.dni := '123';
    write(docClientes,cliente);
    For i := 0 To filesize(docClientes) Do
      Begin
        seek(docClientes,i);
        read(docClientes,cliente);
        If (cliente.nombre = username) Then
          Begin
            user := cliente;
            pass := true;
            break;
          End;
      End;
    If (pass = true) Then
    	begin
    		writeLn('Bienvenido!');
    	end
    Else
      altaCliente();
    Repeat
      ClrScr;
      writeln(Utf8ToAnsi('MENÚ CLIENTES:'+#13+#10+'1. Consulta de Proyectos '+#13+#10+
              '2. Comprar Productos'+#13+#10+'0. Volver al menú principal'));
      Repeat
        opt := readKey;
      Until (opt = '1') Or (opt = '2') Or (opt = '0');
      Case opt Of 
        '1': mostrarProyecto();
        '2': comprarProducto(user);
      End;
    Until (opt = '0');
  End;

  Function login(tipo: char): boolean;

  Var 
    attempts: integer;
    clave, secret1, secret2 : string;
    c: char;
  Begin
    attempts := 3;
    clave := '';
    secret1 := 'admin123';
    secret2 := 'user123';
    While (attempts > 0) Do
      Begin
        attempts := (attempts-1);
        ClrScr;
        writeln('Ingrese la clave. ', attempts + 1, ' intentos restantes');
        Repeat
          c := readKey;
          ClrScr;
          writeln('Ingrese la clave. ', attempts + 1, ' intentos restantes');
          If c = #08 Then
            Begin
              delete(clave,length(clave),1);
              For i := 1 To length(clave) Do
                write('*');
            End
          Else
            Begin
              If c <> #13 Then
                Begin
                  clave := clave + c;
                  For i := 1 To length(clave) Do
                    write('*')
                End;
            End;
        Until (c = #13);
        If tipo = '1' Then
          Begin
            If (clave = secret1) Then
              exit(true)
            Else
              clave := '';
            writeln('Clave incorrecta');
          End;
        If tipo = '2' Then
          Begin
            If clave = secret2 Then
              exit(true)
            Else
              clave := '';
            writeln('Clave incorrecta');
          End;
      End;
    writeln('Agotaste los intentos, programa bloqueado temporalmente.');
    Halt(0);
    exit(false);
  End;

  //MAIN
  Begin
    initDocs();
    Repeat
      ClrScr;
      writeln(Utf8ToAnsi('MENÚ PRINCIPAL: '+#13+#10+'1. EMPRESAS'+#13+#10+
              '2. CLIENTES'+#13+#10+'0. Salir'+#13+#10));
      //menu principal
      Repeat
        option := readKey;
      Until (option = '1') Or (option = '2') Or (option = '0');
      If option <> '0' Then
        Begin
          //login
          access := login(option);
          If access Then
            Begin
              Case option Of 
                '1': showEmpresa();
                '2': showCliente();
              End;
            End;
        End;
    Until (option = '0');
    closeDocs();
  End.
