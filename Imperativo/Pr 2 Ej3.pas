program ej3;
type


vector = array [1..20] of integer;


procedure cargarV(var  v:vector;var diml:integer);
var
ale:integer;
begin
ale:=300+random(1251);//1550-300+1=1251
if diml<20 then begin
	diml:=diml+1;	
	v[diml]:=ale;
	cargarV(v, diml);
end;
end;

procedure impV (v:vector;  var diml:integer);
begin
if diml<20 then  begin
	diml:=diml+1;
	writeln(v[diml]);
	impV(v, diml);
end;
end;



procedure seleccion (var v:vector; diml:integer);//B)
var
i, j, pos:integer;
item:integer;
begin
for i:=1 to diml-1 do  begin
	pos:=i;
	for j:=i+1 to diml do begin
		if v[j]<v[pos] then
			pos:=j;
	end;
	item:=v[pos];
	v[pos]:=v[i];
	v[i]:=item;
end;
end;

Procedure busquedaDicotomica (v: vector; ini,fin: integer; dato:integer; var pos: integer);
var
medio:integer;
begin
if(ini > fin) then
	pos := -1
else begin
	medio := (ini + fin) div 2;
	if(v[medio] = dato) then begin
		pos := medio;
		WriteLn('esta en  el medio');
	end
	else if(v[medio] > dato) then begin
		WriteLn('es mas  chico que  la mitad');
		busquedaDicotomica(v,ini,medio-1,dato,pos)
	end
	else begin
		WriteLn('es mas grande que la  mitad');
		busquedaDicotomica(v,medio+1,fin,dato,pos);
		end;
end;
end;

var
v:vector;
ini, fin,dato, pos, diml:integer;
begin
ini:=1;
fin:=20;
randomize;
diml:=0;
cargarV(v, diml);
diml:=0;
impV(v, diml);
seleccion(v,diml);
writeln('vector ordenado');
diml:=0;
impV(v, diml);
readln(dato);
busquedaDicotomica(v, ini, fin, dato, pos);
writeln (pos);
end.
