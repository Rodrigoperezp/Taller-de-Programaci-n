program ej3;
type
producto=record
cod:integer;
cantTotalUniVen:integer;
montoTotal:integer;
end;

ventas=record
codV:integer;
codP:integer;
cantUniVen:integer;
preUni:integer;
end;

arbol=^nodo;
nodo=record
elem:producto;
HI:arbol;
HD:arbol;
end;

procedure leer (var v:ventas);
begin
readln(v.codV);
readln(v.codP);
readln(v.cantUniVen);
readln(v.preUni);
end;

procedure insertarElem(var a:arbol; v:ventas);
begin
if (a = nil) then begin
	new(a);
    a^.elem.cod:= v.codP; 
    a^.elem.cantTotalUniVen:=v.cantUniVen;
    a^.elem.montoTotal:=v.cantUniVen*v.preUni;
    a^.HI:= nil; 
    a^.HD:= nil;
end
else if (v.codP < a^.elem.cod) then 
	insertarElem(a^.HI, v)
else if (v.codP> a^.elem.cod) then
	insertarElem(a^.HD, v)
else if (v.codP=a^.elem.cod) then begin
	a^.elem.cantTotalUniVen:=a^.elem.cantTotalUniVen+v.cantUniVen;
    a^.elem.montoTotal:=a^.elem.montoTotal+(v.cantUniVen*v.preUni);
end;

end;

procedure generarA (var a:arbol);
var
v:ventas;
begin
writeln('Ingrese las ventas ');
leer(v);
while v.codV<>-1 do begin
		insertarElem(a, v);
		writeln('Ingrese las ventas ');
		leer(v);
end;
end;

procedure impA (a:arbol);
begin
if a<>nil then begin
	impA(a^.HI);
	writeln('codigo ', a^.elem.cod);
	write('cantidad total de unidades vendidas ', a^.elem.cantTotalUniVen);
	writeln('  monto total ', a^.elem.montoTotal);
	impA(a^.HD);
end;
end;

procedure maxUVendidas (a:arbol; var codMax:integer; var maxUV:integer);//C)
begin
if a<>nil then begin
	maxUVendidas(a^.HI, codMax, maxUV);
	if a^.elem.cantTotalUniVen> maxUV then begin
		maxUV:=a^.elem.cantTotalUniVen;
		codMax:=a^.elem.cod;
	end;
	maxUVendidas(a^.HD, codMax, maxUV);
end;
end;



procedure menoresAUnValor (a:arbol; v:integer; var cantM:integer);
begin
if a<>nil then begin
	menoresAUnValor(a^.HI, v, cantM);
	if a^.elem.cod<v then
		cantM:=cantM+1;
	menoresAUnValor(a^.HD, v, cantM);
end;
end;

procedure MTEntre2Valores (a:arbol; c1, c2:integer; var MT:integer);
begin
if (a<>nil)  then begin
	MTEntre2Valores(a^.HI, c1, c2, MT);
	if ((a^.elem.cod>c1)and(a^.elem.cod<c2)) then
		MT:=MT+a^.elem.montoTotal;
	MTEntre2Valores(a^.HD, c1, c2, MT);
	
end;
end;

var
a:arbol;
MT, c1, c2, cantM, v, maxUV, codMax:integer;

begin
a:=nil;
maxUV:=0;
codMax:=0;
cantM:=0;
MT:=0;
generarA(a);
writeln('/////////////////////PUNTO B///////////////////////////////');
impA(a);
writeln('/////////////////////PUNTO C///////////////////////////////');
maxUVendidas(a, codMax, maxUV);//C)
writeln('el codigo del producto con mas unidades vendidas es: ', codMax);
writeln('/////////////////////PUNTO D///////////////////////////////');
writeln('ingrese un codigo: ');
readln(v);
menoresAUnValor(a, v, cantM);//D)
writeln('la cantidad de codigos menores al recien inngresado son: ', cantM);
writeln('/////////////////////PUNTO E///////////////////////////////');
writeln('ingresar un codigo: ');
readln(c1);
writeln('ingresar otro codigo mayor al anterior: ');
readln(c2);
MTEntre2Valores(a, c1, c2, MT);
writeln('el monto total entre los 2 codigos ingresados es: ', MT);
end.
