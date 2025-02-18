program ej2;
type

oficinas=record
	cod:integer;
	DNI:integer;
	valorE:integer;
end;

vector = array [1..5]of oficinas;


procedure leer (var o: oficinas);
begin
readln(o.cod);
readln(o.DNI);
readln(o.valorE);
end;


procedure cargarV (var v: vector; var diml:integer);
var
o: oficinas;

begin
leer(o);
while o.cod<>-1 do begin
	diml:=diml+1;
	v[diml]:=o;
	leer(o);	
end;
end;

procedure insercion (var v:vector; diml:integer);
var
act: oficinas;
i, j:integer;

begin
for i:=2 to diml do begin
	act:=v[i];
	j:=i-1;
	while((j>0)and(v[j].cod>act.cod))do begin
		v[j+1]:=v[j];
		j:=j-1;
	end;
	v[j+1]:=act;
end;
end;


procedure seleccion (var v:vector; diml: integer);
var
item: oficinas;
i,j,pos:integer;
begin
for i:=1 to (diml-1) do begin
	pos:=i;
	for j:=i+1 to diml do begin
		if v[j].cod<v[pos].cod then
			pos:=j;
	end;
	item:=v[pos];
	v[pos]:=v[i];
	v[i]:=item;
end;
end;


procedure impV (v:vector; diml:integer);
var
i:integer;
begin
for i:=1 to diml do begin
	writeln(v[i].cod);
	writeln(v[i].DNI);
	writeln(v[i].valorE);
end;
end;

var
v:vector;
diml:integer;

begin
diml:=0;
cargarV(v, diml);
//insercion(v, diml);
seleccion(v, diml);
impV(v, diml);
end.




