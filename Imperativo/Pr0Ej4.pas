program listaOrdenada;
type

lista=^nodo;
nodo=record
elem:integer;
sig:lista;
end;

procedure cargarListaOrdenada (var l:lista; ale:integer);
var
nue, act, ant: lista;
begin
new(nue);
nue^.elem:=ale;
act:=l;
ant:=l;

while ((act<>nil)and (ale>act^.elem)) do begin
	ant:=act;
	act:=act^.sig;
end;

if (act=ant)then
	l:=nue
else 
	ant^.sig:=nue;
nue^.sig:=act;
end;

procedure cargarL (var l:lista);
var
ale:integer;
begin
ale:=random(51)+100;
while ale<>120 do begin	
	cargarListaOrdenada(l, ale);
	ale:=random(51)+100;
end;
end;


procedure impL (l:lista);
begin
while l<>nil do begin
	writeln(l^.elem);
	l:=l^.sig;
end;
end;

function buscarElementoOrdenado (l:lista; n:integer): boolean;
var 
ok:boolean;
begin
ok:=false;
while ((l<>nil)and(l^.elem<n))do
	l:=l^.sig;
if (l^.elem=n) then
	ok:=true;
buscarElementoOrdenado:=ok;
end;

var
l:lista;
n:integer;

begin
l:=nil;
randomize;

cargarL(l);
impL(l);
readln(n);
writeln(buscarElementoOrdenado(l,n))


end.
