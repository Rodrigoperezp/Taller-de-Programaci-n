program ej4; 
type

productos=record
	cod:integer;
	rubro:integer;
	pre:integer;
end;

lista=^nodo;
nodo=record
	elem:productos;
	sig:lista;
end;

vector = array [1..8] of lista;
vectorR3 = array [1..3] of productos;



procedure iniV (var v: vector);
var
i:integer;
begin
for i:=1 to 8 do 
	v[i]:=nil;
end;

procedure leer (var p:productos);
begin
readln(p.cod);
readln(p.rubro);
readln(p.pre);
end;

procedure insertarOrdenado (var l:lista; p:productos);
var
nue, act, ant: lista;
begin
new(nue);
nue^.elem:=p;
act:=l;
ant:=l;
while ((act<>nil)and(p.cod>act^.elem.cod)) do begin
	ant:=act;
	act:=act^.sig;
end;
if (ant=act)then
	l:=nue
else
	ant^.sig:=nue;
nue^.sig:=act;
end;

procedure cargarV(var v:vector; var vR3:vectorR3; var dimlVR3:integer);
var
p:productos;

begin
leer(p);
while p.pre<>0 do begin
	insertarOrdenado(v[p.rubro], p);
	if ((p.rubro=3) and (dimlVR3<3)) then begin
		dimlVR3:=dimlVR3+1;
		vR3[dimlVR3]:=p;
	end;
	leer(p);
end;
end;

procedure impL (l:lista);
begin
while l<>nil do begin
	writeln(l^.elem.cod);
	writeln(l^.elem.rubro);
	writeln(l^.elem.pre);
	l:=l^.sig;
end;
end;

procedure impV (v:vector);
var
i:integer;
begin
for i:=1 to 8 do begin
	impL(v[i])
end;
end;


procedure ordenarXPre (var vR3:vectorR3; diml:integer);//insercion
var
i, j:integer;
act:productos;
begin
for i:=2 to diml do begin
	act:=vR3[i];
	j:=i-1;
	while ((j>0)and(vR3[j].pre>act.pre)) do begin
		vR3[j+1]:=vR3[j];
		j:=j-1;
	end;
	vR3[j+1]:=act;
end;
end;


procedure impVR3 (v:vectorR3; diml:integer);
var
i:integer;
begin
for i:=1 to diml do
	writeln(v[i].pre);
end;


function promedio (v: vectorR3; diml:integer):integer;
var
i, prom:integer;
begin
prom:=0;
for i:=1 to diml do begin
	prom:=prom+v[i].pre;
end;
promedio:=prom div diml;
end;


var
v: vector;
vR3: vectorR3;
dimlVR3: integer;
begin
iniV(v);
dimlVR3:=0;
cargarV(v, vR3, dimlVR3);
impV(v);
ordenarXPre(vR3, dimlVR3);
impVR3(vR3, dimlVR3);
writeln(promedio(vR3, dimlVR3));
end.
