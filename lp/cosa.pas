Program cosa;
TYPE
arrtyp1 = ARRAY [3..5, 8] OF INTEGER;                      { arrtyp1 = ARRAY [3..5, 8] OF INTEGER; }
arrtyp2 = ARRAY [2..10, 5..12] OF REAL;                      { arrtyp2 = ARRAY [2..10, 5..12] OF REAL; }
VAR
p_arr1, p_arr2 : ARRAY [2..5] OF
REAL;                         { p_arr1, p_arr2 : ARRAY [2..5] OF REAL; }
pp_arr3 : ARRAY [10] OF ^INTEGER; { pp_arr3 : ARRAY [10] OF ^INTEGER; }
pp_arr4 : ARRAY [6, 2..5] OF INTEGER; { pp_arr4 : ARRAY [6, 2..5] OF INTEGER; }

p_arr5 : arrtyp1;               { p_arr5 : arrtyp1; }
p_arr6, p_arr7 : arrtyp2;       { p_arr6, p_arr7 : arrtyp2; }
i, j : INTEGER;                 { i, j : INTEGER; }

BEGIN
i := 2;                         { i := 2; }
j := 1;                         { j := 1; }
p_arr1[i] := p_arr2[2];         { p_arr1[i] := p_arr2[2]; }
pp_arr3[i] := ^(pp_arr4[4, i]); { pp_arr3[i] := ^(pp_arr4[4, i]); }
p_arr5[i, j] := p_arr5[4, 4];   { p_arr5[i, j] := p_arr5[4, 4]; }
p_arr6[2, i] := p_arr7[j, 8]    { p_arr6[2, i] := p_arr7[j, 8] }
END;
