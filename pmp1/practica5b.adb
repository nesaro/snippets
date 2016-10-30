with Text_Io, Ada.Integer_Text_IO;
use Text_Io, Ada.Integer_Text_IO;
with Direct_Io;

--Aquí empieza el procedimiento principal del programa.
procedure practica5 is
    Creacion: Boolean;
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


begin
    Punto:=".";
    Espacio:=" ";
    Put_Line("Archivo de indice?");
    Get_Line(Findice,Tama1);
    Put_Line("Archivo de datos?");
    Get_Line(Fdatos,Tama2);
    Put_Line("Archivo de salida?");
    Get_Line(Fsalida,Tama3);
    Creacion:=False;
    Open(Lindice,In_File,Findice(1..Tama1));
    Open(Ldatos,In_File,Fdatos(1..Tama2));
    Creacion:=True;
    Create(Lsalida,Name => Fsalida(1..Tama3));

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
    Close(Lindice);
    Close(Ldatos);
    Close(Lsalida);

exception

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

    when Text_Io.End_error =>
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
        Put_Line("error desconocido");
end;

