with Text_Io, Ada.Integer_Text_IO;
use Text_Io, Ada.Integer_Text_IO;
with Direct_Io;

--Aquí empieza el procedimiento principal del programa.
procedure practica5 is
    noHayerror: Boolean;
    type datillos is record
        Cadena:String(1..15);
        Indice:Natural;
    end record;
    package Fichint is new Direct_Io(integer);
    package Fichrec is new Direct_Io(datillos);
    use Fichrec,fichint;
    temp: Integer;
    findice, fdatos,fsalida: String(1..255); --nombre ficheros
    Lindice: Fichint.File_type;
    Ldatos: Fichrec.File_type;
    Lsalida: Text_Io.File_Type;
    tama1,tama2,tama3: natural;
    Tempdat:Datillos;
    Punto,espacio: String(1..1);

    function Abrir (Findice,Fdatos,Fsalida: in String;tama1,Tama2,tama3: in Integer) return Boolean is
        Creacion: Boolean;
    begin
        Creacion:=False;
        Open(Lindice,In_File,Findice(1..Tama1));
        Open(Ldatos,In_File,Fdatos(1..Tama2));
        Creacion:=True;
        Create(Lsalida,Name => Fsalida(1..Tama3));
        return true;

    exception
        when Text_Io.Name_Error =>
            if (Creacion) then
                Put_Line("Error en la creacion del fichero");
            else
                Put_Line("Error en la apertura de archivos");
            end if;
            Put_Line("Nombre incorrecto");
            return false;

        when Text_Io.Use_error =>
            if (Creacion) then
                Put_Line("Error en la creacion del archivo");
                Put_Line("No puedo crear el archivo en el directorio");
            else
                Put_Line("Error en la apertura de los archivos");
                Put_Line("No puedo acceder a ellos");
            end if;
            return false;

        when Text_Io.status_error =>
            if (Creacion) then
                Put_Line("Error en la creacion del archivo");
                Put_Line("No esta abierto de forma inesperada");
            else
                Put_Line("Error en la apertura de los archivos");
                Put_Line("Estan siendo usados por otros programas");
            end if;
            return false;

        when Text_Io.Device_error =>
            if (Creacion) then
                Put_Line("Error en la creacion del archivo de salida");
                Put_Line("Error en el dispositivo");
            else
                Put_Line("Error en la apertura de archivos con mensaje");
                Put_Line("Error en el dispositivo");
            end if;
            return false;

        when Text_Io.End_error =>
            Put_Line("Error en la lectura de archivos");
            Put_Line("Probablemente no sea del tipo que se espera");
            return false;

        when others =>
            Put_Line("error desconocido");
            return false;
    end Abrir;

begin
    Punto:=".";
    Espacio:=" ";
    Put_Line("Archivo de indice?");
    Get_Line(Findice,Tama1);
    Put_Line("Archivo de datos?");
    Get_Line(Fdatos,Tama2);
    Put_Line("Archivo de salida?");
    Get_Line(Fsalida,Tama3);
    nohayerror:=Abrir(Findice,Fdatos,Fsalida,Tama1,Tama2,Tama3);
    if (nohayerror) then
        for i in 1..Size(Lindice) loop
            Read(Lindice,Temp,i);
            Read(Ldatos,Tempdat,Fichrec.Count(temp));
            Put(Lsalida,Tempdat.Cadena(1..Tempdat.Indice));
            if(Tempdat.Cadena(Tempdat.Indice..Tempdat.Indice)=Punto) then
                New_Line(Lsalida);
            else
                Put(Lsalida,Espacio);
            end if;
      end loop;
   end if;

   if Is_Open(Lindice) then
      Close(Lindice);
   end if;
   if Is_Open(Ldatos) then
      Close(Ldatos);
   end if;
   if Is_Open(Lsalida) then
      Close(Lsalida);
   end if;


end;

