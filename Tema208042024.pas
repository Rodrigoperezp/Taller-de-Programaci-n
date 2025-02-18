program Tema2;
type
anios= 2000..2023;

regFecha=record
	dia:integer;
	mes:integer;
	ano:anios;
end;
poliza=record
	dni:integer;
	suma:integer;
	valor:integer;
	fecha:regFecha;
end;

arbol=^nodo;
nodo=record
	elem:poliza;
	hi:arbol;
	hd:arbol;
end;

regL=record
	dni:integer;
	suma:integer;
	valor:integer;
end;

lista=^nodo2;
nodo2=record
	elem:regL;
	sig:lista;
end;


vector = array [2000..2023] of lista;


procedure iniV (var v:vector);
var
i:integer;
begin
for i:=2000 to 2023 do
	v[i]:=nil;
end;

procedure leer (var p:poliza);
begin
readln(p.dni);
readln(p.suma);
readln(p.valor);
readln(p.fecha.dia);
readln(p.fecha.mes);
readln(p.fecha.ano);
end;

procedure agregarPoliza (var a:arbol; p:poliza);
begin
if a=nil then begin
	new(a);
	a^.elem:=p;
	a^.hi:=nil;
	a^.hd:=nil;
end
else begin
	if a^.elem.suma>p.suma then
		agregarPoliza(a^.hi, p)
	else 
		agregarPoliza(a^.hd, p);
end;
end;

procedure generarA (var a:arbol);
var
p:poliza;
begin
leer(p);
while p.dni<>-1 do begin
	agregarPoliza(a, p);
	leer(p);	
end;
end;

procedure insertarOrdenado (var l:lista; p:poliza);
var
nue, act, ant:lista;
begin
new(nue);
nue^.elem.dni:=p.dni;
nue^.elem.suma:=p.suma;
nue^.elem.valor:=p.valor;
ant:=l;
act:=l;
while ((act<>nil)and(act^.elem.dni<p.dni)) do begin
	ant:=act;
	act:=act^.sig;
end;
if (act=ant)then
	l:=nue
else
	ant^.sig:=nue;
nue^.sig:=act;
end;


procedure generarV (var v:vector; a:arbol; x:integer);
begin
if a<>nil then begin
	generarV(v, a^.hi, x);
	if a^.elem.suma<x then
		insertarOrdenado(v[a^.elem.fecha.ano], a^.elem);
	generarV(v, a^.hd, x);
end;
end;


procedure recorrerL (l:lista; dni:integer; var cant:integer);
begin
while l<>nil do begin
	if l^.elem.dni=dni then
		cant:=cant+1;
	l:=l^.sig;
end;
end;

function cantDePolizas (v:vector; dni:integer):integer;
var 
cant, i:integer;
begin
cant:=0;
for i:=2000 to 2023 do 
	recorrerL(v[i], dni, cant);
cantDePolizas:=cant;
end;

procedure impL (l:lista);
begin
while l<>nil do begin
	writeln(l^.elem.dni);
	writeln(l^.elem.suma);
	writeln(l^.elem.valor);
	l:=l^.sig;
end;
end;

procedure impV (v:vector);
var
i:integer;
begin
for i:=2000 to 2023 do begin
	impL(v[i]);
end;
end;
var
a:arbol;
v:vector;
dni, x:integer;
begin
iniV(v);
generarA(a);//A

writeln('ingresar una suma asegurada: ');
readln(x);

generarV(v, a, x);//B
impV(v);

writeln('ingrese un dni: ');
readln(dni);
writeln(cantDePolizas(v, dni));//C

end.

