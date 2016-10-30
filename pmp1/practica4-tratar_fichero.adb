separate (Practica4)
function Tratar_Fichero(Nom_F_Ent: in Unbounded_String;
                        Nom_F_Let: in Unbounded_String;
                        Nom_F_Num: in Unbounded_String) return Natural is

   -- Archivos Lógicos usados en la funcion
   Atotal,Aletras,Anumeros: File_Type;

   -- Cadena fija donde guardare cada linea
   Ctotal: String(1..126);

   -- Cadenas de tamaño dinámico necesarias para usar la función separar
   UCtotal,UCletras,UCnumeros: Unbounded_String;

   -- Número natural que guardara la posicion de la ultima columna
   Last: Natural;

   -- Variable lógica para determinar si fue un error en apertura o en creación
   Creacion: Boolean;

   -- Excepcion que manejara las filas de mas de 125 columnas
   Error_Suma : Exception;

   -- Caracter para comprobar si no nos hemos saltado una linea
   Caracter: Character;

   -- Comienzo de la funcion

begin
   Creacion:=False;

   -- Apertura del archivo original
   Open(Atotal,In_File,To_String(Nom_F_Ent));

   -- Ya estamos seguros de que no ha habido problema en la apertura,
   -- Asi que cambio el valor de la variable lógica
   Creacion:=True;

   -- Creación de los archivos de letras y numeros
   Create(Aletras,Name => To_String(Nom_F_Let));
   Create(Anumeros,Name => To_String(Nom_F_Num));

   --Bucle principal de la funcion. Recorre linea por linea y llama
   --al procedimiento separar en cada una de ellas

   while not End_Of_File(Atotal) loop

      -- Tomo una linea y la guardo en Ctotal, quedando en last la posicion
      -- de la ultima columna con caracter.
      Get_Line(Atotal,Ctotal,last);

      -- Guardo en UCtotal, que es una ristra de tamaño variable,
      -- el contenido util de Ctotal. Es necesario hacer esto para
      -- poder emplear el procedimiento separar
      UCtotal:=To_Unbounded_String(Ctotal(1..Last));

      -- Antes de Separar,vamos a detectar si hay mas de 125 columnas

      if (Last > 125) then
         raise Error_Suma;
      end if;

      --Vaciado de las cadenas de longitud variable, necesario para que
      --no quede el valor de la anterior iteracion

      UCletras := To_Unbounded_String("");
      UCnumeros := To_Unbounded_String("");

      -- Separo las cadenas..
      Separar(UCtotal,UCletras,UCnumeros);

      -- Y ahora introduzco en cada archivo logico lo que he obtenido
      -- en separar (previa conversion de cadenas variables en fijas)
      --
      Put(Aletras,To_String(UCletras));
      New_Line(Aletras);
      --
      Put(Anumeros,To_String(UCnumeros));
      New_Line(Anumeros);
      --

   end loop; -- Fin del bucle

   -- Por algun extraño motivo, la funcion end_of_file considera
   -- que el archivo se ha acabado en la penultima linea si la
   -- ultima linea no contiene nada. Para remediarlo, la funcion
   -- Get_inmediate obtiene el siguiente caracter, que en caso de
   -- que la ultima linea haya sido omitida, devolvera
   -- retorno de carro. Si lo ha devuelvo, añadire a los
   -- ficheros de salida la linea que necesitan para estar igual
   -- que el principal

   Get_Immediate(Atotal,caracter);
   if(Caracter=caracter) then
      New_Line(Aletras);
      New_Line(Anumeros);
   end if;

   -- Cierre de archivos
   Close(Atotal);
   Close(Aletras);
   Close(Anumeros);
   -- Todo bien, devuelvo 0
   return 0;

exception

   -- Errores compartidos por abrir y crear: en estos casos
   -- Cierro los archivos que estan abiertos, compruebo en
   -- que situacion se ha dado gracias a la variable lógica
   -- y devuelvo lo que tengo que devolver

   when Name_Error|Status_error|Use_Error =>
      if Is_Open(ATotal) then
         Close(Atotal);
      end if;
      if Is_Open(ALetras) then
         Close(Aletras);
      end if;
      if Is_Open(Anumeros) then
         Close(Anumeros);
      end if;
      if Creacion then
         return 2;
      else
         return 1;
      end if;

      -- Error de desbordamiento de linea, cierra archivos y devuelve 3

   when Error_suma =>
      if Is_Open(ATotal) then
         Close(Atotal);
      end if;
      if Is_Open(ALetras) then
         Close(Aletras);
      end if;
      if Is_Open(Anumeros) then
         Close(Anumeros);
      end if;
      Put_Line("No puede haber mas de 125 columnas");
      return 3;

      -- Resto de errores posibles, cierro archivos y devuelvo 3
   when others =>
      if Is_Open(ATotal) then
         Close(Atotal);
      end if;
      if Is_Open(ALetras) then
         Close(Aletras);
      end if;
      if Is_Open(Anumeros) then
         Close(Anumeros);
      end if;
      return 3;

end Tratar_Fichero; -- Fin de función
