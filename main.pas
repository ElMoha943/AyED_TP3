//TP3 - Casadidio, Querede, Giordanino
Program tp3;

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
  i, j, next: integer;
  word: string;

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

function StrUpcase(s : string) : string;
var
  i : byte;
  c : string;
begin 
  for i := 1 to length(s) do
      c[i] := upcase(s[i]);
  c[0] := s[0];
  StrUpcase := c;
end;

//Validar que los datos se suban bien.
function DirecValidas(word:string): boolean;
var 
letras:Integer;
begin    
  letras:=0; 
  for i:=1 to length(word) do
    if ((word[i]>='0') and (word[i]<='z')) then letras:=letras+1 //agregar espacio
    else letras:=letras-1;
  if letras=length(word) then DirecValidas := True
  else DirecValidas := False;
END;

function Codigosvalidos(word:string): boolean;
var 
letras:Integer;
begin    
  letras:=0; 
  for i:=1 to length(word) do
    if ((word[i]>='A') and (word[i]<='Z')) then letras:=letras+1
    else letras:=letras-1;
  if letras=length(word) then CodigosValidos := True
  else CodigosValidos := False;
END;

function NombresValidos(word:string): boolean;
var 
  letras:Integer;
begin    
  letras:=0; 
  for i:=1 to length(word) do
    if ((word[i]>='A') and (word[i]<='z')) then letras:=letras+1 //agregar espacio
    else letras:=letras-1;
  if letras=length(word) then NombresValidos := True
  else NombresValidos := False;
END;

function Numerosvalidos(word:string): boolean;
var 
letras:Integer;
begin    
  letras:=0; 
  for i:=1 to length(word) do
    if ((word[i]>='0') and (word[i]<='9')) then letras:=letras+1
    else letras:=letras-1;
  if letras=length(word) then NumerosValidos := True
  else NumerosValidos := False;
END;

function MailValidos(word:string): boolean;
var 
letras, arrobas:Integer;
begin  
  letras:=0; 
  arrobas:=0;
  for i:=1 to length(word) do
    if ((word[i]>='A') and (word[i]<='z')) then letras :=letras+1 //FALTARIA VERICIAR EL .COM
    else if(word[i] = '@') then
    begin
        letras :=letras+1;
        arrobas := arrobas + 1;
    end;
  if ((letras=length(word)) and (arrobas = 1)) then MailValidos := True
  else MailValidos := False;
END;

//ALTAS
Procedure altaCiudad();
  var
    aux: string;
Begin
  Repeat
    repeat
      {textbackground(4);
      textcolor(7);}
      writeln('Ingrese el codigo de la ciudad');
      readln(aux);
      word:= aux;
    until (Codigosvalidos(word));
    if fileSize(docCiudades) > 0 then
    begin
      for i := 0 to filesize(docCiudades) do
        if i > 0 then
        seek(docCiudades,i-1);
        read(docCiudades,ciudad);
        if StrUpcase(aux) = ciudad.cod_ciudad then
          begin
            repeat
              writeln('Este codigo ya existe, selecciona otro');
              readln(aux);
            until StrUpcase(aux) <> ciudad.cod_ciudad;
          end;
    end;
    ciudad.cod_ciudad := StrUpcase(aux);
    Repeat
      writeln('Ingrese el nombre de la ciudad');
      readln(aux);
      word:= aux;
    Until (NombresValidos (word));
    if fileSize(docCiudades) > 0 then
    begin
      for i := 0 to filesize(docCiudades) do
        if i > 0 then 
        seek(docCiudades,i-1);
        read(docCiudades,ciudad);
        if StrUpcase(aux) = ciudad.nombre then
          begin
            repeat
              writeln('Este codigo ya existe, selecciona otro');
              readln(aux);
            until StrUpcase(aux) <> ciudad.nombre;
          end;
    end;
    ciudad.nombre := StrUpcase(aux);
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
    repeat
      writeln('Ingrese el dni del cliente');
      readln(cliente.dni); 
      word:= cliente.dni;
    until (Numerosvalidos(word));
{     repeat
      writeln('Ingrese el nombre del cliente');
      readln(cliente.nombre);
      word:=cliente.nombre;
    until (NombresValidos (word)); }
    repeat
      writeln('Ingrese el mail del cliente');
      readln(cliente.mail); 
      word:=cliente.mail;
    until (MailValidos(word)); 
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
    repeat
      writeln('Ingrese el codigo de la empresa');
      readln(empresa.cod_emp);
      word:=empresa.cod_emp;
    until (Codigosvalidos(word));
    Repeat
      writeln('Ingrese el nombre de la empresa');
      readln(empresa.nombre);
      word:=empresa.nombre;
    Until (NombresValidos (word));
    repeat
      writeln('Ingrese la direccion de la empresa');
      readln(empresa.direccion);
      word:= empresa.direccion;
    until (DirecValidas(word));
    repeat
      writeln('Ingrese el mail de la empresa');
      readln(empresa.mail);
      word:= empresa.mail;
    until (MailValidos(word));
    Repeat
      writeln('Ingrese el telefono de la empresa');
      readln(empresa.telefono);
      word:=empresa.telefono;
    until (Numerosvalidos (word));
    Repeat
    writeln('Ingrese el codigo de la ciudad asociada con la empresa');
      readln(empresa.cod_ciudad);
      word:=empresa.cod_ciudad;
    Until (Codigosvalidos (word));
    write(docEmpresas,empresa);
    Repeat
      writeln('Ingrese 1 para ingresar otra empresa o 0 para salir');
      readln(next);
    Until ((next = 0) Or (next = 1)) ; //SE DEBERIA VALIDAR QUE EL CODIGO DE CIUDAD EXISTA
  Until (next = 0);
End;

Procedure altaProyecto();
Begin
  Repeat
    Repeat
      writeln('Ingrese el codigo del proyecto');
      readln(proyecto.cod_proy);
      word:= proyecto.cod_proy;
    Until(Codigosvalidos(word));
    Repeat 
      writeln('Ingrese el codigo de la empresa asociada al proyecto');
      readln(proyecto.cod_emp);
      word:=proyecto.cod_emp;
    Until(Codigosvalidos(word));  
    repeat
      writeln('Ingrese la etapa del proyecto');
      readln(proyecto.etapa);
    until (proyecto.etapa = 'T') or (proyecto.etapa = 'P') or (proyecto.etapa = 'O');
    Repeat
      writeln('Ingrese el tipo de proyecto');
      readln(proyecto.tipo);
    Until (proyecto.tipo = 'C') or (proyecto.tipo = 'D') or (proyecto.tipo = 'L') or (proyecto.tipo = 'O');  
    Repeat
      writeln('Ingrese el codigo de la ciudad asociada con el proyecto');
      readln(proyecto.cod_ciudad);
      word:= proyecto.cod_ciudad;
    Until (Codigosvalidos(word));
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
    Repeat
      writeln('Ingrese el codigo del proyecto');
      readln(producto.cod_proy);
      word:= producto.cod_proy;
    Until (Codigosvalidos(word));
    //VERIFICAR QUE NO SE PUEDAN METER MAS PRODUCTOS QUE LOS ESTABLECIDOS EN EL PROYECTO
    Repeat 
      writeln('Ingrese el codigo del producto');
      readln(producto.cod_prod);
      word:=producto.cod_prod;
    Until (Codigosvalidos(word));
    writeln('Ingrese el precio del producto');
    readln(producto.precio);
    producto.estado := false;
    Repeat
      writeln('Ingrese el detalle del producto');
      readln(producto.detalle);
      word:= producto.detalle;
    until (NombresValidos(word));
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
  cod_proy: string;
Begin
  ClrScr;
  Repeat
    writeLn('¿Que tipo de proyecto quieres consultar?'+#13+#10+'C. Casa'+#13+#10+'D. Edificio departamentado'+#13+#10+'O. Edificio oficina'+#13+#10+'L. Loteos respectivamente?');
    opt := readKey;
    ClrScr;
  Until (opt = 'C') Or (opt = 'D') Or (opt = 'O') Or (opt = 'L') Or (opt = 'c') Or (opt = 'd') Or (opt = 'o') Or (opt = 'l');
  For i := 0 To filesize(docProyectos)-1 Do
    Begin
      seek(docProyectos,i);
      read(docProyectos,proyecto);
      If proyecto.tipo = opt Then
        Begin
          writeln('Codigo de proyecto: ' + proyecto.cod_proy);
          For j := 0 To filesize(docEmpresas)-1 Do
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
          For j := 0 To filesize(docCiudades)-1 Do
            seek(docCiudades,j);
            read(docCiudades,ciudad);
          If ciudad.cod_ciudad = proyecto.cod_ciudad Then
            Begin
              writeln('Ciudad: '+ ciudad.nombre);
              ciudad.consultas := ciudad.consultas + 1;
            End;
          writeln('');
        End;
    End;
  repeat
    writeLn('Ingrese el codigo del proyecto que quiera ver');
    readln(cod_proy);
    word:=cod_proy;
  until (Codigosvalidos(word));  
  For i := 0 To filesize(docProyectos)-1 Do
    Begin
      seek(docProyectos,i);
      read(docProyectos,proyecto);
      If (cod_proy = proyecto.cod_proy) Then
        Begin
          pass := true;
          proyecto.cantidad[2] := proyecto.cantidad[2] + 1;
          seek(docProyectos,i);
          write(docProyectos,proyecto);
        End;
    End;
  If pass = true Then
    Begin
      For i := 0 To filesize(docProductos)-1 Do
        Begin
          seek(docProductos,i);
          read(docProductos, producto);
          If ((producto.cod_proy = cod_proy) And (producto.estado = false)) Then
            Begin
              writeLn('Codigo: ' + producto.cod_prod);
              writeLn('Precio: ' + IntToStr(producto.precio));
              writeLn('Detalles: ' + producto.detalle);
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
//    producto, mostrarle el precio y si confirma la compra, mostrar un cartel que la venta
//    le llegará al mail: xxxx, cambiar el estado de situación del producto a “vendido”, y
//    actualizar el acumulador de vendidos en el archivo proyectos.
Procedure comprarProducto(user: clientes);
Var
  cod, opt: string;
Begin
  Repeat
    writeln('Ingresa el codigo del producto');
    readln(cod);
    word:= cod;
  Until(Codigosvalidos (word));
  For i := 0 To filesize(docProductos)-1 Do
  Begin
    seek(docProductos,i);
    read(docProductos,producto);
    If cod = producto.cod_prod then
    Begin
      writeln('Este producto sale $' + IntToStr(producto.precio) + ', estas seguro que quieres comprarlo? (SI/NO)');
      read(opt);
        if opt = 'SI' Then
          begin
            writeln('La venta llegara al mail ' + user.mail);
            // producto.estado := true;
            // seek(docProductos,i);
            // write(docProductos,producto);
            readkey;
            // for j := 0 to filesize(docProyectos)-1 Do
            //   begin
            //     seek(docProyectos,i);
            //     read(docProyectos,proyecto);
            //     if proyecto.cod_proy = producto.cod_proy then
            //       proyecto.cantidad[3] := proyecto.cantidad[3] + 1;
            //       write(docProyectos, proyecto);
            //   end;
          end
      // readkey
    end
  end
End;

Procedure mostrarEstadisticas();
Var
  max, id: Integer;   
Begin
  ClrScr;
  max := 0;
  id := 0;
  For i := 0 To filesize(docEmpresas)-1 Do
  Begin
    seek(docEmpresas,i);
    Read(docEmpresas,empresa);
    writeln('Empresas con mas de 10 consultas');
  If (empresa.consultas > 10) Then
    writeln(empresa.nombre);
  End;
  For i := 0 To filesize(docCiudades)-1 Do
    Begin
      seek(docCiudades,i);
      read(docCiudades,ciudad);
      If ciudad.consultas > max Then
        Begin
          max := ciudad.consultas;
          id := i;
        End;
    End;
  writeln('La ciudad con mas consultas es '+ciudad.nombre+', con un total de '+ //AGREGAR VALIDACION DE 0 CONSULTAS Y DE 2 CANTIDADES IGUALES...
          IntToStr(ciudad.consultas)+' consultas registradas.');
  For i := 0 To filesize(docProyectos)-1 Do
    Begin
      seek(docCiudades,i);
      read(docCiudades,ciudad);
      writeln('Proyectos que vendieron todas las unidades'); //AGREGAR UN VALOR DE "NINGUNO"
      If (proyecto.cantidad[1] = proyecto.cantidad[3]) Then
        writeln(proyecto.cod_proy);
    End;
  writeLn('Pulse cualquier tecla para continuar.');
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
      begin
        seek(docCiudades, i);
        read(docCiudades, ciudad);
        seek(docCiudades,j);
        read(docCiudades, aux);
      end;
  If (ciudad.cod_ciudad > aux.cod_ciudad) Then
    begin
      seek(docCiudades, i);
      write(docCiudades, aux);
      seek(docCiudades,j);
      write(docCiudades, ciudad);
    End;
end;

//MENUS
Procedure showEmpresa();
  Var 
    opt: char;
  Begin
    Repeat
      ClrScr;
      writeln(Utf8ToAnsi('MENÚ EMPRESAS DESARROLLADORAS:'+#13+#10+'1. Alta de CIUDADES '+#13+#10+'2. Alta de EMPRESAS '+#13+#10+'3. Alta de PROYECTOS'+#13+#10+'4. Alta de PRODUCTOS'+#13+#10+'5. Mostrar estadisticas'+#13+#10+'0. Volver al menú principal'));
      Repeat
        opt := readKey;
      Until (opt = '1') Or (opt = '2') Or (opt = '3') Or (opt = '4') Or (opt ='0') Or (opt = '5');
      Case opt Of 
        '1': altaCiudad();
        '2': altaEmpresa();
        '3': altaProyecto();
        '4': altaProducto();
        '5': mostrarEstadisticas();
      End;
    Until (opt = '0');
  End;

  Procedure showCliente();
  Var 
    opt: char;
    username: string;
    user: clientes;
  Begin
    Repeat
      writeln('Ingrese su nombre de usuario.');
      readln(username);
      word:= username;
    Until (NombresValidos(word));  
    For i := 0 To filesize(docClientes)-1 Do
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
    If (pass = true) Then writeLn('Bienvenido!')
    Else
    begin
    cliente.nombre := username;
      altaCliente();
    end;
    Repeat
      ClrScr;
      writeln(Utf8ToAnsi('MENÚ CLIENTES:'+#13+#10+'1. Consulta de Proyectos '+#13+#10+'2. Comprar Productos'+#13+#10+'0. Volver al menú principal'));
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
      writeln(Utf8ToAnsi('MENÚ PRINCIPAL: '+#13+#10+'1. EMPRESAS'+#13+#10+'2. CLIENTES'+#13+#10+'0. Salir'+#13+#10));
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
