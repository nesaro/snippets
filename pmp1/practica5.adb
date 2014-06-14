with Text_Io, Ada.Integer_Text_IO;
use Text_Io, Ada.Integer_Text_IO;
with Direct_Io;

--Aquí empieza el procedimiento principal del programa.
procedure practica5 is

   --Excepción que controla si el archivo de indice no tiene contenido
   Vacio: exception;

   --tipo del que esta hecho el fichero de datos
   type datillos is record
      Cadena:String(1..15);
      tama:Natural;
   end record;

   -- me creo los tipos de fichero segun la variable que contenga
   package Fichint is new Direct_Io(integer);
   package Fichrec is new Direct_Io(datillos);
   use Fichrec,fichint;

   findice, fdatos,fsalida: String(1..255); --Nombre de los ficheros

   --Cada fichero es declarado con su tipo ...
   Lindice: Fichint.File_type;
   Ldatos: Fichrec.File_type;
   Lsalida: Text_Io.File_Type;

   --Variables donde guardo el tamaño de las cadenas de nombres de archivo
   tama1,tama2,tama3: natural;

   --Cadenas para guardar los caracteres de punto y espacio
   Punto,espacio: String(1..1);

   --Variables de almacenamiento temporal
   Creacion: Boolean;
   temp: Integer;
   Tempdat:Datillos;


begin

   Punto:=".";
   Espacio:=" ";

   --Pido los nombres de archivo
   Put_Line("Archivo de indice?");
   Get_Line(Findice,Tama1);
   Put_Line("Archivo de datos?");
   Get_Line(Fdatos,Tama2);
   Put_Line("Archivo de salida?");
   Get_Line(Fsalida,Tama3);

   --Creacion es una variable que nos ayuda a saber si estamos creando o abriendo un archivo
   Creacion:=False;

   --Abro los archivos de datos e indice
   Open(Lindice,In_File,Findice(1..Tama1));
   Open(Ldatos,In_File,Fdatos(1..Tama2));

   Creacion:=True;

   --Y ahora creo el archivo de salida
   Create(Lsalida,Name => Fsalida(1..Tama3));

   if (Integer(Size(Lindice))=0) then
      raise Vacio;
   end if;

   --Bucle principal del programa: Recorro el archivo de indice elemento por elemento
   for i in 1..Size(Lindice) loop
      --leo el contenido de cada elemento del indice
      Read(Lindice,Temp,i);
      --leo en datos la posicion que indica el indice (conversion de tipos necesaria)
      Read(Ldatos,Tempdat,Fichrec.Count(temp));
      --guardo la cadena obtenida de datos en el archivo de salida
      Put(Lsalida,Tempdat.Cadena(1..Tempdat.tama));

      --Condicion: Si la palabra acaba en ".", linea nueva, si no, espacio
      if(Tempdat.Cadena(Tempdat.tama..Tempdat.tama)=Punto) then
         New_Line(Lsalida);
      else
         Put(Lsalida,Espacio);
      end if;
   end loop;

   --Todo bien, cierro archivos.
   Close(Lindice);
   Close(Ldatos);
   Close(Lsalida);


   --Bloque de excepciones. He intentado recoger las más tipicas y dar
   --un mensaje acorde a la causa, identificando a su vez si ha sido
   --en la creacion o apertura de ficheros
exception

      when vacio =>
      if Is_Open(Lindice) then
         Close(Lindice);
      end if;
      if Is_Open(Ldatos) then
         Close(Ldatos);
      end if;
      if Is_Open(Lsalida) then
         Close(Lsalida);
      end if;
      Put_Line("Aviso: el fichero de indice esta vacio");

   when Text_Io.Name_Error =>
      if Is_Open(Lindice) then
         Close(Lindice);
      end if;
      if Is_Open(Ldatos) then
         Close(Ldatos);
      end if;
      if Is_Open(Lsalida) then
         Close(Lsalida);
      end if;
      if (Creacion) then
         Put_Line("Error en la creacion del fichero");
      else
         Put_Line("Error en la apertura de archivos");
      end if;
      Put_Line("Nombre incorrecto");

   when Text_Io.Use_error =>
      if Is_Open(Lindice) then
         Close(Lindice);
      end if;
      if Is_Open(Ldatos) then
         Close(Ldatos);
      end if;
      if Is_Open(Lsalida) then
         Close(Lsalida);
      end if;
      if (Creacion) then
         Put_Line("Error en la creacion del archivo");
         Put_Line("No puedo crear el archivo en el directorio");
      else
         Put_Line("Error en la apertura de los archivos");
         Put_Line("No puedo acceder a ellos");
      end if;

   when Text_Io.status_error =>
      if Is_Open(Lindice) then
         Close(Lindice);
      end if;
      if Is_Open(Ldatos) then
         Close(Ldatos);
      end if;
      if Is_Open(Lsalida) then
         Close(Lsalida);
      end if;
      if (Creacion) then
         Put_Line("Error en la creacion del archivo");
         Put_Line("No esta abierto de forma inesperada");
      else
         Put_Line("Error en la apertura de los archivos");
         Put_Line("Estan siendo usados por otros programas");
      end if;

   when Text_Io.Device_error =>
      if Is_Open(Lindice) then
         Close(Lindice);
      end if;
      if Is_Open(Ldatos) then
         Close(Ldatos);
      end if;
      if Is_Open(Lsalida) then
         Close(Lsalida);
      end if;
      if (Creacion) then
         Put_Line("Error en la creacion del archivo de salida");
         Put_Line("Error en el dispositivo");
      else
         Put_Line("Error en la apertura de archivos con mensaje");
         Put_Line("Error en el dispositivo");
      end if;

   when Text_Io.End_Error|Text_Io.Data_error =>
      if Is_Open(Lindice) then
         Close(Lindice);
      end if;
      if Is_Open(Ldatos) then
         Close(Ldatos);
      end if;
      if Is_Open(Lsalida) then
         Close(Lsalida);
      end if;
         Put_Line("Error en la lectura de archivos");
         Put_Line("Probablemente no sea del tipo que se espera");

   when others =>
      if Is_Open(Lindice) then
         Close(Lindice);
      end if;
      if Is_Open(Ldatos) then
         Close(Ldatos);
      end if;
     if Is_Open(Lsalida) then
         Close(Lsalida);
      end if;
      Put_Line("Error imprevisto");
end practica5;

