package body Números_Racionales is

   --Declaracion de funciones que no estan incluidas --
   --en la especificacion.                           --


   function MCD(Pri,Sec: in Integer) return integer is
      Temp,Div,dis: Integer;
   begin
      if (Pri = 0) or (Sec=0) then
         Div:=1;
      else
         if Pri < Sec then
            div := Sec;
            dis := Pri;
         else
            Div := Pri;
            Dis := Sec;
         end if;
         Temp :=1;
         while (temp /= 0) loop
            Temp := div/dis;
            Temp := (Temp*dis)-div;
            div := dis;
            dis := Temp;
         end loop;
      end if;
      return div;
   end MCD;

   Procedure Reducir(R: in out Racional) is
      Temp: Integer;
   begin
      if R.Denominador=0 then
         raise Denominador_Cero;
      else
         if R.Numerador=0 then
            R.Denominador:=1;
         end if;
         Temp:=mcd(abs(R.Numerador),abs(R.Denominador));
         R.Numerador:=R.Numerador/Temp;
         R.Denominador:=R.Denominador/Temp;
         if ((R.Numerador<0 and R.Denominador<0) or
             (R.Numerador>0 and R.Denominador<0)) then
            R.Numerador := R.Numerador*(-1);
            R.Denominador := R.Denominador*(-1);
         end if;
      end if;
   end Reducir;

   function "/"(Pri,Sec: in integer) return Racional is
      Temp: Racional;
   begin
      Temp.Numerador:=Pri;
      Temp.denominador:=Sec;
      Reducir(Temp);
      return Temp;
   end "/";

   function "+"(Pri,Sec: in Racional) return Racional is
      R1,R2,Temp: Racional;
   begin
      R1:=Pri;
      R2:=Sec;
      R1.Numerador:=R1.Numerador*sec.Denominador;
      R1.Denominador:=R1.Denominador*sec.Denominador;
      R2.Numerador:=R2.Numerador*pri.Denominador;
      R2.Denominador:=R2.Denominador*pri.Denominador;
      Temp.Numerador:=R1.Numerador+R2.Numerador;
      Temp.Denominador:=R1.Denominador;
      Reducir(Temp);
      return Temp;
   end "+";

   function "-"(Pri,Sec: in Racional) return Racional is
      R1,R2,Temp: Racional;
   begin
      R1:=Pri;
      R2:=Sec;
      R1.Numerador:=R1.Numerador*sec.Denominador;
      R1.Denominador:=R1.Denominador*sec.Denominador;
      R2.Numerador:=R2.Numerador*pri.Denominador;
      R2.Denominador:=R2.Denominador*pri.Denominador;
      Temp.Numerador:=R1.Numerador-R2.Numerador;
      Temp.Denominador:=R1.Denominador;
      Reducir(Temp);
      return Temp;
   end "-";

   function "*"(Pri,Sec: in Racional) return Racional is
      Temp: Racional;
   begin
      Temp:=Pri;
      Temp.Numerador:=Temp.Numerador*Sec.Numerador;
      Temp.Denominador:=Temp.Denominador*Sec.Denominador;
      Reducir(Temp);
      return Temp;
   end "*";

   function "/"(Pri,Sec: in Racional) return Racional is
      Temp: Racional;
   begin
      Temp:=Pri;
      Temp.Numerador:=Temp.Numerador*Sec.Denominador;
      Temp.Denominador:=Temp.Denominador*Sec.Numerador;
      Reducir(Temp);
      return Temp;
   end "/";

   function "="(Pri,Sec: in Racional) return Boolean is
      Temp: boolean;
   begin
      Temp:=True;
      return Temp;
   end "=";

   function Numerador(R: in Racional) return Integer is
      Temp : Integer;
   begin
      Temp:=R.Numerador;
      return Temp;
   end Numerador;

   function Denominador(R: in Racional) return Integer is
      Temp : Integer;
   begin
      Temp:=R.denominador;
      return Temp;
   end denominador;

end Números_Racionales;
