program ej1;
type

info=record
dia:integer;
cod:integer;
cantV:integer;
end;


vector = array [1..50] of info;

datos=record
cod:integer;
cantT:integer;
end;

lista=^nodo;
nodo=record
elem:datos;
sig:lista;
end;

procedure leer (var i:info);
begin
readln(i.dia);
i.cod:=1+random(15);
readln(i.cantV);
end;

procedure cargarV (var v:vector; var diml:integer);
var
inf:info;

begin

leer(inf);
while ((diml<50) and(inf.dia <>0)) do begin
	diml:=diml+1;
	v[diml]:=inf;
	leer(inf);
end;

end;

procedure seleccion (var v:vector; diml:integer);
var
i, j, pos:integer;
item:info;
begin
for i:=1 to diml-1 do  begin
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

procedure  eliminarV (var v:vector; var diml:integer; a, b:integer);
var
i, pos:integer;
begin
pos:=1;
while (v[pos].cod<=a) do 
	pos:=pos+1;
	while v[pos].cod<b do begin
		for i:=pos to (diml-1) do	
			v[i]:=v[i+1];
		diml:=diml-1;
	end;
end;




procedure imprimirV (v:vector; diml:integer);
var
i:integer;

begin
for i:=1 to diml do begin
	writeln(v[i].dia);
	writeln(v[i].cod);
	writeln(v[i].cantV);
	
end;

end;

procedure agregarAdelante (var l:lista; codigo:integer; cant:integer);
var
nue:lista;
begin
if ((l<>nil)and (l^.elem.cod=codigo)) then
	l^.elem.cantT:=l^.elem.cantT+cant
else begin
	new(nue);
	nue^.elem.cod:=codigo;
	nue^.elem.cantT:=cant;
	nue^.sig:=l;
	l:=nue;
end;
end;

procedure cargarL(var l:lista; v:vector; diml:integer);
var
i:integer;
begin
for i:=1 to diml do begin
	if v[i].cod MOD 2 = 0 then
		agregarAdelante(l, v[i].cod, v[i].cantV);
end;
end;

procedure impL (l:lista);
begin
while l<>nil do begin
	writeln('imprimir lista');
	writeln(l^.elem.cod);
	writeln(l^.elem.cantT);	
	l:=l^.sig;
end;
end;


var
a,b, diml:integer;
v:vector;
l:lista;
begin
diml:=0;
l:=nil;
randomize;
cargarV(v, diml);
seleccion(v, diml);
imprimirV(v, diml);
readln(a);
readln(b);
eliminarV(v, diml, a, b);
imprimirV(v, diml);
cargarL(l, v, diml);
impL(l);
end.
