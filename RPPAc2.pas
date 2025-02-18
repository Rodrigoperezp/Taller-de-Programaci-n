program act2;
type 


vector = array [1..50] of integer;


procedure cargarVector (var v:vector; a, b:integer; var diml:integer);
var
ale, rango: integer;
begin
rango:=b-a+1;

ale := a + random (rango);
while ale<>0 do begin
	diml:=diml+1;
	v[diml]:=ale;
	ale := a + random (rango);
	
end;
end;

procedure imprimirVector (v:vector; diml:integer);
var
i:integer;
begin
for i:=1 to diml do
	writeln(v[i]);

end;

procedure impVecInverso(v:vector; diml:integer);
var
i:integer;
begin
for i:= diml downto 1 do
	writeln(v[i]);
end;


var 
v:vector;
a, b, diml:integer;

begin
diml:=0;
readln(a);
readln(b);
randomize;
cargarVector(v, a, b, diml);
writeln('vector original ');
imprimirVector(v, diml);
writeln('vector inverso ');
impVecInverso(v, diml);


end.
