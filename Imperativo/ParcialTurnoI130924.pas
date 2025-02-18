program Turnoi;
type
dias= 1..7;
alquiler=record
	dni:integer;
	nChasis:integer;
	cantDias:dias;
end;

regArbol=record
	nChasis:integer;
	dni:integer;
end;

arbol=^nodo;
nodo=record
	elem:regArbol;
	hi:arbol;
	hd:arbol;
end;

vector = array [dias] of arbol;

 procedure iniv(var v:vector);
 var
 i:integer;
 begin
 for i:=1 to 7 do 
	v[i]:=nil;
 end;

procedure leer (var alq:alquiler);
begin
readln(alq.dni);
readln(alq.nChasis);
readln(alq.cantDias);
end;

procedure  agregarAlquiler (var a:arbol; alq:alquiler);
begin
if a= nil then begin
	new(a);
	a^.elem.nChasis:=alq.nChasis;
	a^.elem.dni:=alq.dni;
	a^.hi:=nil;
	a^.hd:=nil;
end
else begin
	if a^.elem.nChasis>alq.nChasis then
		agregarAlquiler(a^.hi, alq)
	else if a^.elem.nChasis<alq.nChasis then
		agregarAlquiler(a^.hd, alq);
end;
end;

procedure cargarV (var v:vector);
var
alq:alquiler;
begin
leer(alq);
while alq.nChasis<>0 do begin
	agregarAlquiler(v[alq.cantDias], alq);
	leer(alq);
end;
end;


function cantAlqui (a:arbol; d:integer):integer;
begin
if a= nil then
	cantAlqui:=0
else begin
	cantAlqui(a^.hi, d);
	if a^.elem.dni=d then
		cantAlqui:=1+cantAlqui(a^.hi, d)+cantAlqui(a^.hd, d);
	cantAlqui(a^.hd, d);
end;
end;


procedure recorrerV (v:vector; dni:integer; var cant:integer);
var
i:integer;
begin
for i:=1 to 7 do 
	cant:=cant+ cantAlqui(v[i], dni);
end;


function alquisEntreCH (a:arbol; n1:integer; n2:integer):integer;
begin
if a=nil then
	alquisEntreCH:=0
else begin
	if a^.elem.nChasis>n1 then begin
		if a^.elem.nChasis<n2 then
			alquisEntreCH:=1+alquisEntreCH(a^.hi,n1,n2)+alquisEntreCH(a^.hd,n1,n2)
		else
			alquisEntreCH(a^.hi,n1,n2);
	end
	else
		alquisEntreCH(a^.hd,n1,n2);
end;
end;

var
v:vector;
dia, N1, N2, cant, dni:integer;
begin
iniV(v);
cargarV(v);//A
{cant:=0;
writeln('ingrese un dni: ');
readln(dni);
recorrerV(v, dni, cant);//B
writeln('la cantidad de alquileres con el dni ', dni, ' es: ', cant);
}
writeln('ingresar un dia: ');
readln(dia);
writeln('ingresar un numero de chasis: ');
readln(N1);
writeln('ingresar un numero de chasis mas grande que el anterior: ');
readln(N2);

writeln(alquisEntreCH(v[dia], N1, N2));//C


end.
