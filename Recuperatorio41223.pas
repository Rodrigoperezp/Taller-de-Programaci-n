program recu;
type
provincias = 1..24;
meses = 1..12;

partida=record
	mes:meses;
	ano:integer;
	codP:provincias;
	montoE:integer;
end;

regL=record
	mes:meses;
	codP:provincias;
	montoE:integer;
end;

lista=^nodo2;
nodo2=record
	elem:regL;
	sig:lista;
end;


regArbol=record
	ano:integer;
	l:lista;
end;


arbol=^nodo;
nodo=record
	elem:regArbol;
	hi:arbol;
	hd:arbol;
end;

regVec=record
	totParti:integer;
	montoTotal:integer;
end;

vectorP = array [1..24] of regVec;


procedure iniVP (var v:vectorP);
var
i:integer;
begin
for i:=1 to 24 do begin
	v[i].totParti:=0;
	v[i].montoTotal:=0;
end;
end;

procedure leer (var p:partida);
begin
readln(p.mes);
readln(p.ano);
readln(p.codP);
readln(p.montoE);
end;

procedure insertarOrdenado (var l:lista; p:partida);
var
act, ant, nue:lista;
begin
new(nue);
nue^.elem.mes:=p.mes;
nue^.elem.codP:=p.codP;
nue^.elem.montoE:=p.montoE;
ant:=l;
act:=l;

while ((act<>nil)and(p.mes>act^.elem.mes)) do begin
	ant:=act;
	act:=act^.sig;
end;
if (act=ant) then
	l:=nue
else
	ant^.sig:=nue;
nue^.sig:=act;
end;

procedure agregarPartida (var a:arbol; p:partida);
begin
if a=nil then begin
	new(a);
	a^.elem.ano:=p.ano;
	a^.elem.l:=nil;
	insertarOrdenado(a^.elem.l, p);
	a^.hi:=nil;
	a^.hd:=nil;
end
else begin
	if a^.elem.ano>p.ano then
		agregarPartida(a^.hi, p)
	else if a^.elem.ano<p.ano then
		agregarPartida(a^.hd, p)
	else if a^.elem.ano=p.ano then
		insertarOrdenado(a^.elem.l, p);
end;
end;

procedure generarA (var a:arbol);
var
p:partida;
begin
leer(p);
while ((p.codP<>24)and(p.mes<>12)and(p.ano<>2022)) do begin
	agregarPartida(a, p);
	leer(p);
end;
end;

procedure recorrerLista (l:lista; var v:vectorP);
begin
while l<>nil do begin
	v[l^.elem.codP].totParti:=v[l^.elem.codP].totParti+1;
	v[l^.elem.codP].montoTotal:=v[l^.elem.codP].montoTotal+l^.elem.montoE;
	l:=l^.sig;
end;
end;


procedure cargarV (a:arbol; var v:vectorP);
begin
if a<>nil then begin
	cargarV(a^.hi, v);
	recorrerLista(a^.elem.l, v);
	cargarV(a^.hd, v);
end;
end;

procedure impV (v:vectorP);
var
i:integer;
begin
for i:=1to 24 do begin
	writeln('LA PROVINCIA: ', i);
	writeln('TOTAL DE PARTIDAS: ', v[i].totParti);
	writeln('MONTO TOTAL: ', v[i].montoTotal);
end;
end;

function masPartidas (v:vectorP):integer;
var
i, maxP, maxC:integer;
begin
maxP:=0;
maxC:=0;
for i:=1 to 24 do begin
	if v[i].totParti>maxP then begin
		maxP:=v[i].totParti;
		maxC:=i;
	end;		
end;
masPartidas:=maxC;
end;

function buscarParti (l:lista; m:integer; var totP:integer):integer;
begin
if l=nil then 
	buscarParti:=totP
else begin	
	if l^.elem.mes=m then
		totP:=totP+1;
	end;
	buscarParti(l^.sig, m, totP);
end;




function cantidadTotalParti (a:arbol; a1, a2, m:integer):integer;
var 
totP:integer;
begin
if a=nil then 
	cantidadTotalParti:=0
else begin
	if a^.elem.ano>a1 then begin
		if a^.elem.ano<a2 then begin
			totp:=0;
			cantidadTotalParti:=buscarParti(a^.elem.l, m, totP)+cantidadTotalParti(a^.hi, a1, a2, m)+cantidadTotalParti(a^.hd, a1, a2, m);
		end
		else 
			cantidadTotalParti(a^.hi, a1, a2, m);
	end
	else 
		cantidadTotalParti(a^.hd, a1, a2, m);
end;
end;



var
a:arbol;
v:vectorP;
totParti, a1, a2, m:integer;
begin
totParti:=0;
generarA(a);//1
iniVP(v);

cargarV(a, v);//2
impV(v);

writeln('la provincia con mayor cantidad de partidas', masPartidas(v));//3

writeln('ingrese un año: ');
readln(a1);
writeln('ingrese un año mayor al anterior: ');
readln(a2);
writeln('ingrese un mes: ');
readln(m);


writeln('el total de partidas que hubo entre el año ', a1, ' y el ', a2, 'fue: ', cantidadTotalParti(a, a1, a2, m));

end.
