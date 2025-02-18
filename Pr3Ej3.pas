program ej3;
type
finales=record
	codMateria:integer;
	fecha:integer;
	nota:integer;
end;

lista=^nodo2;
nodo2=record
	elem:finales;
	sig:lista;
end;

alumno=record
	leg:integer;
	lis:lista;
end;

arbol=^nodo;
nodo=record
	elem:alumno;
	HI:arbol;
	HD:arbol;
end;

lgYProm=record
	lega:integer;
	prom:integer;
end;

listaProm=^nodo3;
nodo3=record
	elem:lgYProm;
	sig:listaProm;
end;

procedure leer (var leg:integer; var f:finales);
begin
readln(leg);
readln(f.codMateria);
readln(f.fecha);
readln(f.nota);
end;

procedure agregarAdelante (var l:lista; f:finales);
var
nue:lista;
begin
new(nue);
nue^.elem:=f;
nue^.sig:=l;
l:=nue;
end;

procedure agregarFinal (var a:arbol; le:integer; f:finales);
begin
if (a=nil)then begin
	new(A);
	A^.elem.leg:=le;
	A^.HI:=nil;
	A^.HD:=nil;
	A^.elem.lis:=nil;
	agregarAdelante(a^.elem.lis, f);
end
else
	if (le<A^.elem.leg) then
		agregarFinal(a^.HI, le, f)
	else if (le>A^.elem.leg) then
		agregarFinal(a^.HD, le, f)
	else if (le=A^.elem.leg) then
		agregarAdelante(a^.elem.lis, f);
end;


procedure generarA (var a:arbol);
var
f:finales;
leg:integer;
begin
leer(leg, f);
while leg<>0 do begin
	agregarFinal(a, leg, f);
	leer(leg, f);
end;
end;


procedure impar (a:arbol; var cantImpar: integer);
begin

if (a<>nil) then begin
	if a^.elem.leg mod 2<>0 then
		cantImpar:=cantImpar+1;
	impar(a^.HI, cantImpar);
	impar(a^.HD, cantImpar);
end;
end;


procedure recorrerLista (l:lista; var cantApro:integer);
begin
while l<>nil do begin
	if (l^.elem.nota>=4) then	
		cantApro:=cantApro+1;
	l:=l^.sig;
end;
end;

procedure aprobados (a:arbol; var cantApro:integer);
begin
if (a<>nil) then begin
	recorrerLista(a^.elem.lis, cantApro);
	writeln('su numero de legajo es: ', a^.elem.leg);
	writeln('la cantidad de finales aprobados es: ', cantApro);
	cantApro:=0;
	aprobados(a^.HI, cantApro);
	aprobados(a^.HD, cantApro);
end;
end;

procedure recorrerListaProm (l:lista; var cantN:integer; var totalN:integer);
begin
while l<>nil do begin
	cantN:=cantN+1;
	totalN:=totalN+l^.elem.nota;
	l:=l^.sig;
end;
end;


procedure promedio (a:arbol; v:integer);//si los que superan el valor los tengo que agregar a una lista tengo que pasar como parametro:  (var lProm:listaProm)
var 
cantN, totalN, prom:integer;
begin
cantN:=0;
totalN:=0;
prom:=0;
if a<>nil then begin
	recorrerListaProm(a^.elem.lis, cantN, totalN);
	prom:=totalN div cantN;
	if prom>v then begin
		writeln('su numero de legajo es: ', a^.elem.leg);//no se si hacer asi o si supera el promedio agregarlo a una lista que tenga los legajos y premedios de los alumnos que superen el valor ingresado
		writeln('su promedio ', prom,' supera el valor ingresado ', v);
	end;
	promedio(a^.HI, v);
	promedio(a^.HD, v);
end;
end;


var
a:arbol;
v, cantImpar, cantApro:integer;
//lProm:listaProm;
begin
//lprom:=nil;
cantImpar:=0;
cantApro:=0;
generarA(a);
impar(a, cantImpar);
writeln(cantImpar);
aprobados(a, cantApro);
readln(v);
promedio(a, v);
end.
