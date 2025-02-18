program  ej2;
type
ventas= record
cod:integer;
fecha:integer;
uVendidas:integer;
end;

arbol1 = ^nodo;
nodo = record 
elem:ventas;
HI:arbol1;
HD:arbol1;
end;

ventas2=record
cod:integer;
uVen:integer;
end;

arbol2=^nodo1;
nodo1=record
elem:ventas2;
HI:arbol2;
HD:arbol2;
end;

venta3= record
fecha:integer;
uVendidas:integer;
end;

lista=^nodo2;
nodo2=record
elem:venta3;
sig:lista;
end;

regarbol3 = record
	cod : integer;
	l : lista;
end;

arbol3 = ^nodo3;
nodo3 = record 
elem:regarbol3;
HI:arbol3;
HD:arbol3;
end;

procedure agregar1 (var a1:arbol1; v:ventas);//2i)
begin
if (a1=nil) then begin
	new(a1);
	a1^.elem.cod:=v.cod;
	a1^.elem.fecha:=v.fecha;
	a1^.elem.uVendidas:=v.uVendidas;
	a1^.HI:=nil;
	a1^.HD:=nil;
end
else if (v.cod<a1^.elem.cod) then
	agregar1(a1^.HI, v)
else 
	agregar1(a1^.HD, v);
end;

procedure agregar2  (var  a2:arbol2;  cod:integer; uV:integer);//2ii)
begin
if (a2=nil) then begin
	new(a2);
	a2^.elem.cod:=cod;
	a2^.elem.uVen:=uV;
	a2^.HI:=nil;
	a2^.HD:=nil;
end
else if (cod<a2^.elem.cod) then
	agregar2(a2^.HI, cod, uV)
else if (cod>a2^.elem.cod) then
	agregar2(a2^.HD, cod, uV)
else if (cod=a2^.elem.cod) then
	a2^.elem.uVen:=a2^.elem.uVen+uV;
end;

procedure agregarAdelante (var l:lista; v:ventas);
var
nue:lista;
begin
new(nue);
nue^.elem.fecha:=v.fecha;
nue^.elem.uVendidas:=v.uVendidas;
nue^.sig:=l;
l:=nue;
end;

procedure agregar3 (var a3:arbol3; v:ventas);
begin
if (a3=nil) then begin
	new(a3);
	a3^.elem.cod:=v.cod;
	agregarAdelante(a3^.elem.l, v);
	a3^.HI:=nil;
	a3^.HD:=nil;
end
else if (v.cod<a3^.elem.cod) then
	agregar3(a3^.HI, v)
else if (v.cod>a3^.elem.cod) then
	agregar3(a3^.HD, v)
else if (v.cod=a3^.elem.cod) then
	agregarAdelante(a3^.elem.l, v);
end;

procedure impA1 (a1:arbol1);
begin
if (a1<>nil) then begin
	impA1(a1^.HI);
	write (a1^.elem.cod);
	writeln('codigo del producto');
	impA1(a1^.HD);
end;
end;

procedure impA2 (a2:arbol2);
begin
if (a2<>nil) then begin
	impA2(a2^.HI);
	writeln('producto ');
	write (' codigo ', a2^.elem.cod);
	writeln (' unidades vendidas ', a2^.elem.uVen);
	impA2(a2^.HD);
end;
end;

procedure impL (l:lista);
begin
while l<> nil do begin
	writeln('fecha ', l^.elem.fecha);
	writeln('unidades vendidas ', l^.elem.uVendidas);
	l:=l^.sig;
end;
end;

procedure recorrerA (a3:arbol3);
begin
if (a3<>nil) then begin
	recorrerA(a3^.HI);
	writeln('ventas realizadas de este producto ', a3^.elem.cod);
	impL(a3^.elem.l);
	recorrerA(a3^.HD);
end;
end;

procedure fechaVendi (a1:arbol1; f:integer; var cantV:integer);//2B)
begin
if (a1<>nil) then begin
	fechaVendi(a1^.HI, f, cantV);
	if f=a1^.elem.fecha then begin
		writeln('suma fecha');
		cantV:=a1^.elem.uVendidas+cantV;
	end;
	fechaVendi(a1^.HD, f, cantV);
end;
end;

procedure maxVendidas (a2:arbol2; var uMax:integer; var codMax:integer);//C
begin
if (a2<>nil) then begin
	maxVendidas(a2^.HI, uMax, codMax);
	if uMax<a2^.elem.uVen then begin
		uMax:=a2^.elem.uVen;
		codMax:=a2^.elem.cod;
	end;
	maxVendidas(a2^.HD, uMax, codMax);
end;
end;



procedure recorrerL (l:lista; var cV:integer);
begin
if l<>nil then begin
	cV:=cV+1;
	l:=l^.sig;
	recorrerL(l, cV);
end;
end;



procedure  recorrerA3 (a3:arbol3; var cMax:integer; var cantMax:integer);//D)
var
cantV:integer;
begin
cantV:=0;
if a3<>nil then begin
	recorrerA3(a3^.HI, cMax, cantMax);
	recorrerL(a3^.elem.l, cantV);	
	if cantV>cantMax then begin
		cantMax:=cantV;
		cMax:=a3^.elem.cod;
	end;
	recorrerA3(a3^.HD, cMax, cantMax);
end;
end;

var
abb1:arbol1;
abb2:arbol2;
abb3:arbol3;
v:ventas;
cantMax, cMax, codMax,  uMax, cantV, f:integer;
begin
abb1:=nil;
abb2:=nil;
uMax:=0;
cantV:=0;
cantMax:=0;
cMax:=0;
randomize;
v.cod:=random(11);
v.fecha:=random(31)+1;
v.uVendidas:=random(50)+1;
while v.cod<>0  do  begin
	agregar1(abb1, v);
	agregar2(abb2, v.cod, v.uVendidas);
	agregar3(abb3, v);
	v.cod:=random(11);
	v.fecha:=random(31)+1;
	v.uVendidas:=random(51);
end; 
impA1(abb1);
//impA2(abb2);
recorrerA(abb3);
readln(f);
fechaVendi(abb1, f, cantV);
writeln('la cantidad total de productos vendidos en la fecha ', f,   ' es: ', cantV);
maxVendidas(abb2, uMax, codMax);
writeln('el codigo del producto con mas unidades vendidas: ', codMax);
recorrerA3(abb3, cMax, cantMax);
writeln('el codigo del producto con   mas  ventas  es: ',   cMax);
end.
