program act1;
var 
i, f, rango, a, b, ale: integer;
begin
readln(a);
readln(b);
readln(f);
randomize;
rango:=b-a+1;
for i:=1 to 20 do begin

	ale := a + random (rango);
	if f<>ale then
		writeln ('El numero aleatorio generado es: ', ale);
end;
end.
