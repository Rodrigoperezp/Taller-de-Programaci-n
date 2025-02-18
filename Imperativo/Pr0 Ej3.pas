program ej3;
type

lista=^nodo;
nodo=record
elem:integer;
sig:lista;
end;

procedure insertarOrdenado(var l:lista; r:integer);
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

procedure cargarL (var  l:lista);
var
r:integer;
begin
r:=random(51)+100;
if r<>120 then  begin
	insertarOrdenado(l, r);
	cargarL(l);
end;
end;

procedure impl(l:lista);
begin
if l<>nil  then begin
	writeln(l^.elem);
	l:=l^.sig;
	impl(l);
end;
end;

procedure buscarElemento (l:lista; n:integer; var ok:boolean);
begin
while  ((l<>nil) and (ok=false)) do  begin
if  l^.elem=n   then
	ok:=true
else
l:=l^.sig;
end;
end;


var
l:lista;
n:integer;
ok:boolean;
begin
l:=nil;
ok:=false;
randomize;
cargarL(l);
impL(l);
readln(n);
buscarElemento(l, n, ok);
writeln(ok);

end.
