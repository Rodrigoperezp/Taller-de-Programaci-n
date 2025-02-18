program  ej4;
type



lista=^nodo;
nodo=record
elem:integer;
sig:lista;
end;


procedure cargarListaOrdenada(var l:lista; r:integer);
var
nue, act, ant:lista;
begin
new(nue);
nue^.elem:=r;
ant:=l;
act:=l;

while((act<>nil)and (r>act^.elem))do begin;
	ant:=act;
	act:=act^.sig;
	end;
if (act=ant)then
	l:=nue
else
	ant^.sig:=nue;
nue^.sig:=act;

end;

procedure cargarL(var l:lista);
var
r:integer;
begin
r:=random(51)+100;
while r<>120 do begin
	cargarListaOrdenada(l, r);
	r:=random(51)+100;
end;
end;

procedure imprimirLista(l:lista);
begin
while l<>nil do begin
	writeln(l^.elem);
	l:=l^.sig;
end;
end;

procedure buscarElementoOrdenado(l:lista; n:integer;  var ok:boolean);
begin
while  ((l<>nil) and (n>l^.elem)) do 
	l:=l^.sig;
	
if  ((l<>nil)and (l^.elem=n))   then
	ok:=true
end;


var
l:lista;
n:integer;
ok:boolean;
begin
l:=nil;
randomize;
cargarL(l);
imprimirLista(l);
readln(n);
buscarElementoOrdenado(l, n, ok);
writeln(ok);
end.
