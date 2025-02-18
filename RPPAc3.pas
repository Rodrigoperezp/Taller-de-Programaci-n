program act3;
type


lista=^nodo;
nodo=record
elem:integer;
sig:lista;
end;

procedure agregarAdelante (var l:lista; ale:integer);
var
nue:lista;
begin
new(nue);
nue^.elem:=ale;
nue^.sig:=l;
l:=nue;

end;
procedure cargarLista (var l:lista);
var
ale:integer;
begin
ale:= 100 + random(51);
while ale<>120 do begin
	agregarAdelante(l, ale);
	ale:= 100 + random (51);
end;
end;

procedure imprimirLista(l:lista);
begin
while l<>nil do begin
	writeln (l^.elem);
	l:=l^.sig;
end;
end;

function buscarElemento (l:lista; a:integer):boolean;
var

begin
while ((l<>nil) and (l^elem<> a)) do begin
	l:=l^.sig;	
end;
if l= nil then
	buscarElemento:= false;
else if 
end;


var
l:lista;
a:integer;

begin
l:=nil;
randomize;
cargarLista(l);
imprimirLista(l);
readln(a);
writeln(buscarElemento(l, a));

end.
