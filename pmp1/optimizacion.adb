with Text_Io, Ada.Integer_Text_Io;
use  Text_Io, Ada.Integer_Text_Io;
with Ada.Real_time; use Ada.Real_Time;

procedure optimizacion is
   subtype Numero_Corto is Integer range -127..128;
   type Matriz is array(Positive range <>, Positive range <>) of Numero_Corto;
   type Vector is array(Integer range <>) of Numero_Corto;
   Pepe,Primern,Ultimon,Iteraciones,d:Integer ;
   Superpepe : Vector(1..100);
   T0,T1,T2,T3,T4,T5,T6,T7 : Time;
   Retardo,Tiempo1,Tiempo2,Tiempo3,Tiempo4: Time_Span;
   Matrizpepe: Matriz(1..128,1..128);
begin
   Iteraciones:=100;
   for I in 1..128 loop
      for j in 1..128 loop
         Matrizpepe(I,J):=3;
      end loop;
   end loop;
   T0:=Clock;
   Primern:=Numero_Corto'First;
   Ultimon:=Numero_Corto'Last;
   for Pe in 2..Iteraciones loop
   for C in 2..Iteraciones loop
      D:=C-1;
      Superpepe(C):=Primern;
      Superpepe(D):=Ultimon;
   end loop;
   end loop;
   T1:=Clock;
   Retardo:=Milliseconds(2000);
   delay (To_Duration(Retardo));

   T2:=Clock;
   for Pe in 2..Iteraciones loop
      for C in 2..Iteraciones loop
         D:=C-1;
         SuperPepe(C):=Numero_Corto'First;
         SuperPepe(D):=Numero_Corto'Last;
      end loop;
   end loop;
   T3:=Clock;

   -- Segunda parte

   T4:=Clock;
   Primern:=Matrizpepe'First;
   Ultimon:=Matrizpepe'Last;
      for C in 2..Iteraciones loop
         D:=C-1;
         SuperPepe(C):=Primern;
         SuperPepe(D):=Ultimon;
   end loop;

   T5:=Clock;
   Retardo:=Milliseconds(2000);
   delay (To_Duration(Retardo));

   T6:=Clock;
   for C in 2..Iteraciones loop
      D:=C-1;
      SuperPepe(C):=Matrizpepe'First;
      SuperPepe(D):=Matrizpepe'Last;
   end loop;
   T7:=Clock;


   --resumenes
   Tiempo1:=T1-T0;
   Tiempo2:=T3-T2;
   Tiempo3:=T5-T4;
   Tiempo4:=T7-T6;
   Put_Line("Diferencia para tipos escalares Metodo entero: " & Duration'Image(To_Duration(Tiempo1)));
   Put_Line("Diferencia para tipos escalares Metodo directo: " & Duration'Image(To_Duration(Tiempo2)));
   Put_Line("Diferencia para tipos array Metodo entero: " & Duration'Image(To_Duration(Tiempo3)));
   Put_Line("Diferencia para tipos array Metodo directo: " & Duration'Image(To_Duration(Tiempo4)));
end Optimizacion;

