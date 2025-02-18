program ej2;
type

venta=record
	cod:integer;
	fecha:integer;
	cantU:integer;
end;

arbol=^nodo;
nodo=record
	elem:venta;
	HI:arbol;
	HD:arbol;
end;

procedure crearV (var v:venta);
begin
v.cod:=random(11);
v.fecha:=random(32);
v.cantU:=random(11);
end;

procedure agregar (var a:arbol; v:venta);
begin
if (a=nil) then begin
	new(A);
	a^.elem:=v;
	a^.HI:=nil;
	a^.HD:=nil;
end
else
	if (v.cod<=A^.elem.cod) then
		agregar(a^.HI, v)
	else
		agregar(a^.HD, v);
end;

procedure generarA (var a:arbol);
var
v:venta;
begin
crearV(v);
while (v.cod<>0)do begin
	agregar(a,v);
	crearV(v);
end;
end;

procedure impA (a:arbol);
begin
if (a<>nil)then begin
	impA(a^.HI);
	writeln(a^.elem.cod);
	writeln(a^.elem.fecha);
	writeln(a^.elem.cantU);
	impA(a^.HD);
end;
end;

var 
a1, a2:arbol;
begin
generarA(a1);
writeln('ARBOL 1 ');
impA(a1);
generarA(a2);
writeln ('ARBOL 2 ');
impA(a2);

end.
