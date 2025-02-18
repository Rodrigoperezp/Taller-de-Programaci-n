program ej3;
type

producto=record
	codV:integer;
	codP:integer;
	uVendi:integer;
	preUni:integer;
end;

regA=record
	cod:integer;
	totUVendi:integer;
	montoTotal:integer;
end;


arbol=^nodo;
nodo=record
	elem:regA;
	HI:arbol;
	HD:arbol;
end;


procedure leer (var p:producto);
begin
readln(p.codV);
readln(p.codP);
readln(p.uVendi);
readln(p.preUni);
end;

procedure agregarVenta(var a:arbol; p:producto);
begin
if a=nil then begin
	new(A);
	A^.elem.cod:=p.codP;
	A^.elem.totUVendi:=p.uVendi;
	A^.elem.montoTotal:=p.uVendi*p.preUni;
	A^.HI:=nil;
	A^.HD:=nil;
end
else
	if A^.elem.cod>p.codP then
		agregarVenta(A^.HI, p)
	else if A^.elem.cod<p.codP then
		agregarVenta(A^.HD, p)
	else if A^.elem.cod=p.codP then begin
		A^.elem.totUVendi:=A^.elem.totUVendi+p.uVendi;
		A^.elem.montoTotal:=A^.elem.montoTotal+(p.uVendi*p.preUni);
end;
end;


procedure generarA (var a:arbol);
var
p:producto;
begin
leer(p);
while p.codV<>-1 do begin
	agregarVenta(a, p);
	leer(p);
end;
end;

procedure impA (a:arbol);
begin
if a<>nil then begin
	impA(a^.HI);
	writeln(a^.elem.cod);
	writeln(a^.elem.totUVendi);
	writeln(a^.elem.montoTotal);
	impA(a^.HD);
end;
end;

procedure masUVendi (a:arbol; var cM:integer; var uM: integer);
begin
if a<>nil then begin
	masUVendi(a^.HI, cM, uM);
	if uM<a^.elem.totUVendi then begin
		uM:=a^.elem.totUVendi;
		cM:=a^.elem.cod;
	end;
	masUVendi(a^.HD,cM,uM);
end;
end;

function codMenores (a:arbol; v:integer):integer;
begin
if a=nil then 
	codMenores:=0
else begin
	if a^.elem.cod<v then 
		codMenores:=codMenores(a^.HI, v)+codMenores(a^.HD, v)+1
	else
		codMenores:=codMenores(a^.HI, v)+codMenores(a^.HD, v);
		
end;
end;

function montoTotal(a:arbol; v1:integer; v2:integer):integer;
begin
if (a=nil) then 
	montoTotal:=0
else begin 
	if a^.elem.cod>v1 then begin
		if a^.elem.cod<v2 then
			montoTotal:=a^.elem.montoTotal+montoTotal(a^.HI, v1, v2)+montoTotal(a^.HD, v1, v2)
		else
			montoTotal:=montoTotal(a^.HI, v1, v2);
	end
	else
		montoTotal:=montoTotal(a^.HD, v1, v2);	
end;
end;




var
a:arbol;
v1, v2, v, codMax, uMax:integer;
begin
codMax:=-1;
uMax:=-1;
generarA(a);
impA(a);
masUVendi(a, codMax, uMax);
writeln('el codigo del producto con mayor cantidad de unidades vendidas es: ', codMax);
readln(v);
writeln(codMenores(a, v));
readln(v1);
readln(v2);
writeln(montoTotal(a, v1, v2));
end.
