program ej4;
type
prestamo=record
isbn:integer;
num:integer;
diaYMes:integer;
cantDias:integer;
end;

arbol1=^nodo;
nodo=record
elem:prestamo;
HI:arbol1;
HD:arbol1;
end;

reglista=record
isbn:integer;
cantTotalPresto:integer;
end;

lista2=^nodo3;
nodo3=record
elem:reglista;
sig:lista2
end;

prestamoA2=record
num:integer;
diaYMes:integer;
cantDias:integer;
end;

lista=^nodo1;
nodo1=record
dato:prestamoA2;
sig:lista
end;

regArbol2=record
isbn:integer;
l:lista;
end;

arbol2=^nodo2;
nodo2=record
dato:regArbol2;
HI:arbol2;
HD:arbol2;
end;


procedure leer (var p:prestamo);
begin
writeln('Ingrese la informacion de cada prestamo');
readln(p.isbn);
readln(p.num);
readln(p.diaYMes);
readln(p.cantDias);
end;

procedure insertarEstruc1  (var a1:arbol1; p:prestamo);
begin
if (a1 = nil) then begin
	new(a1);
    a1^.elem.isbn:= p.isbn; 
    a1^.elem.num:=p.num;
    a1^.elem.diaYMes:=p.diaYMes;
    a1^.elem.cantDias:=p.cantDias;
    a1^.HI:= nil; 
    a1^.HD:= nil;
end
else if (p.isbn>= a1^.elem.isbn) then 
	insertarEstruc1(a1^.HD, p)
else 
	insertarEstruc1(a1^.HI, p)
end;

procedure agregarAdelante(var l:lista; p:prestamo);
var
nue:lista;
begin
new(nue);
nue^.dato.num:=p.num;
nue^.dato.diaYMes:=p.diaYMes;
nue^.dato.cantDias:=p.cantDias;
nue^.sig:=l;
l:=nue;
end;

procedure insertarEstruc2 (var a2:arbol2; p:prestamo);
begin
if (a2 = nil) then begin
	new(a2);
    a2^.dato.isbn:= p.isbn; 
    agregarAdelante(a2^.dato.l, p);
    a2^.HI:= nil; 
    a2^.HD:= nil;
end
else if (p.isbn< a2^.dato.isbn) then 
	insertarEstruc2(a2^.HI, p)
else if (p.isbn> a2^.dato.isbn) then
	insertarEstruc2(a2^.HD, p)
else if (p.isbn= a2^.dato.isbn) then
	agregarAdelante(a2^.dato.l, p);
end;

procedure cargarA (var a1:arbol1; var a2:arbol2);
var
p:prestamo;
begin
leer(p);
while p.isbn<>0 do begin
	insertarEstruc1(a1, p);
	insertarEstruc2(a2, p);
	leer(p);
end;
end;


procedure impEstruc1 (a1:arbol1);
begin
if a1<>nil then begin
	impEstruc1(a1^.HI);
	writeln(a1^.elem.isbn);
	writeln(a1^.elem.num);
	writeln(a1^.elem.diaYMes);
	writeln(a1^.elem.cantDias);
	impEstruc1(a1^.HD);
end;
end;

procedure impL (l:lista);
begin
while l<> nil do begin
	writeln('numero ', l^.dato.num);
	writeln('fecha ', l^.dato.diaYMes);
	writeln('cantidad de dias ', l^.dato.cantDias);
	l:=l^.sig;
end;
end;

procedure impEstruc2 (a2:arbol2);
begin
if a2<>nil then begin
	impEstruc2(a2^.HI);
	writeln('el isbn: ', a2^.dato.isbn);
	impL(a2^.dato.l);
	impEstruc2(a2^.HD);
end;
end;

procedure isbnMasGrande (a1:arbol1; var isbnMax:integer);
begin
if a1<>  nil then begin
	isbnMasGrande(a1^.HI, isbnMax);
	if isbnMax<a1^.elem.isbn then
		isbnMax:=a1^.elem.isbn;
	isbnMasGrande(a1^.HD, isbnMax);
end;
end;

procedure isbnMasChico (a2:arbol2; var isbnMin:integer);
begin
if a2<>nil then begin
	if isbnMin>a2^.dato.isbn then
		isbnMin:=a2^.dato.isbn;
	isbnMasChico(a2^.HI, isbnMin);
end;
end;

procedure cantPrestamos (a1:arbol1; n:integer; var cantP1:integer);
begin
if a1<>nil then begin
	cantPrestamos(a1^.HI, n, cantP1);
	if a1^.elem.num=n then
		cantP1:=cantP1+1;
	cantPrestamos(a1^.HD, n, cantP1);
end;
end;
procedure recorrerL (l:lista; n2:integer; var cantP2:integer);
begin
if l<>nil then begin
	if l^.dato.num=n2 then
		cantP2:=cantP2+1;
	recorrerL(l^.sig, n2, cantP2);
end;
end;


procedure cantPrestamos2 (a2:arbol2; n2:integer; var cantP2:integer);
begin
if a2<>nil then begin
	cantPrestamos2(a2^.HI, n2, cantP2);
	recorrerL(a2^.dato.l, n2, cantP2);
	cantPrestamos2(a2^.HD, n2, cantP2);
end;
end;

procedure agregarAdelante (var l2:lista2; isbn:integer);
var
nue:lista2;
begin
new(nue);
nue^.elem.isbn:=isbn;
nue^.elem.cantTotalPresto:=1;
nue^.sig:=l2;
l2:=nue;
end;



procedure cargarL2 (a1:arbol1; var l2:lista2);
begin
if a1<>nil then begin
	cargarL2(a1^.HI, l2);
	if  ((l2=nil) or (a1^.elem.isbn<>l2^.elem.isbn)) then
		agregarAdelante(l2, a1^.elem.isbn)
	else 
		l2^.elem.cantTotalPresto:=l2^.elem.cantTotalPresto+1;
	cargarL2(a1^.HD, l2);
end;
end;

procedure impL (l2:lista2);
begin
while l2<> nil do begin
	writeln('isbm ', l2^.elem.isbn);
	writeln('la cantidad total de veces que se prestó ', l2^.elem.cantTotalPresto);
	l2:=l2^.sig;
end;
end;


var
a1:arbol1;
a2:arbol2;
l2:lista2;
cantP2, n2, cantP1, n, isbnMin, isbnMax:integer;
begin
l2:=nil;
isbnMax:=-1;
isbnMin:=999;
cantP1:=0;
cargarA(a1, a2);
writeln('//////////////Ai//////////////');
impEstruc1(a1);
writeln('//////////////Aii/////////////');
impEstruc2(a2);
isbnMasGrande(a1, isbnMax);
writeln('///////////////B//////////////');
writeln('el ISBN mas grande cargado es: ', isbnMax);
isbnMasChico(a2, isbnMin);
writeln('///////////////C//////////////');
writeln('el ISBN mas chico cargado es: ', isbnMin);
writeln('///////////////D//////////////');
writeln('ingrese un numero de socio ');
readln(n);
cantPrestamos(a1, n, cantP1);
writeln('la cantidad de préstamos realizados a dicho socio es: ', cantP1);
writeln('///////////////E//////////////');
writeln('ingrese un numero de socio ');
readln(n2);
cantPrestamos2(a2, n2, cantP2);
writeln('la cantidad de préstamos realizados a dicho socio es: ', cantP2);
writeln('///////////////F//////////////');
cargarL2(a1, l2);
impL(l2);
writeln('///////////////G//////////////');

end. 
