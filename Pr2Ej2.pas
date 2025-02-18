program ej2;
type

lista=^nodo;
nodo=record
	elem:integer;
	sig:lista
end;


procedure agregarAdelante (var l:lista; r:integer);
var
nue:lista;
begin
new(nue);
nue^.elem:=r;
nue^.sig:=l;
l:=nue;
end;


procedure generarL (var l:lista);
var
r:integer;
begin
r:=random(101)+100;
if r<>100 then begin
	agregarAdelante(l, r);
	generarL(l);
end;
end;

procedure impL (l:lista);
begin
if l<>nil then begin
	writeln(l^.elem);
	impL(l^.sig);
end;
end;

procedure impInverso (l:lista);
begin
if l<>nil then begin
	impInverso(l^.sig);
	writeln(l^.elem);
end;
end;

procedure minimo (l:lista; var min: integer);
begin
if l<>nil then begin
	if l^.elem<min then
		min:=l^.elem;
	minimo(l^.sig,min);
end;
end;

procedure buscarValor (l:lista; v:integer; var esta:boolean);
begin
if l<>nil then begin
	if l^.elem=v then
		esta:=true
	else 
		buscarValor(l^.sig,v,esta);	
end;
end;

var
l:lista;
v, min:integer;
esta:boolean;
begin
l:=nil;
generarL(l);
impL(l);
writeln('INVERSO');
impInverso(l);
min:=999;
minimo(l, min);
writeln ('MINIMO ', min);
readln(v);
buscarValor(l,v, esta);
writeln(esta);
end.
