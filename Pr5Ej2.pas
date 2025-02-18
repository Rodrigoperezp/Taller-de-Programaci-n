program ej2;
type
anosF = 2010..2018;

infoAuto=record
	patente:integer;
	aFabri:anosF;
	marcaYMode:string;
end;

infoA=record
	patente:integer;
	mYM:string;
end;

lista=^nodo2;
nodo2=record
	elem:infoA;
	sig:lista
end;

arbol=^nodo;
nodo=record
	elem:infoAuto;
	HI:arbol;
	HD:arbol;
end;

infoA2=record
	pat:integer;
	aF:anosF;
end;

lista2=^nodo4;
nodo4=record
	elem:infoA2;
	sig:lista2;
end;

regL2=record
	marca:string;
	lis:lista2;
end;

arbol2=^nodo3;
nodo3=record
	elem:regL2;
	HI:arbol2;
	HD:arbol2;
end;

vector = array [anosF] of lista;


procedure iniV (var v:vector);
var
i:integer;
begin
for i:=2010 to 2018 do 
	v[i]:=nil;
end;

procedure leer (var iA:infoAuto);
begin
readln(iA.patente);
readln(iA.aFabri);
readln(iA.marcaYMode);
end;

procedure agregarAuto (var a:arbol; iA:infoAuto);
begin
if a=nil then begin
	new(a);
	a^.elem:=iA;
	a^.HI:=nil;
	a^.HD:=nil;
end
else if a^.elem.patente>iA.patente then
	agregarAuto(a^.HI, iA)
else if a^.elem.patente<iA.patente then
	agregarAuto(a^.HD, iA);
end;

procedure agregarAdelanteV (var l:lista; iA:infoAuto);
var
nue:lista;
begin
new(nue);
nue^.elem.patente:=iA.patente;
nue^.elem.mYM:=iA.marcaYMode;
nue^.sig:=l;
l:=nue;
end;

procedure agregarAdelanteL2 (var l:lista2; iA:infoAuto);
var
nue:lista2;
begin
new(nue);
nue^.elem.pat:=iA.patente;
nue^.elem.aF:=iA.aFabri;
nue^.sig:=l;
l:=nue;
end;

procedure agregarAlArbol2 (var a2: arbol2; iA:infoAuto);
begin
if a2= nil then begin
	new(a2);
	a2^.elem.marca:=iA.marcaYMode;
	a2^.elem.lis:=nil;
	agregarAdelanteL2(a2^.elem.lis, iA);
	a2^.HI:=nil;
	a2^.HD:=nil;
end
else 
	if a2^.elem.marca=iA.marcaYMode then
		agregarAdelanteL2(a2^.elem.lis, iA)
	else if a2^.elem.marca>iA.marcaYMode then
		agregarAlArbol2(a2^.HI, iA)
	else
		agregarAlArbol2(a2^.HD, iA);
end;

procedure generarAP (var a: arbol; var a2: arbol2; var v:vector);
var
iA:infoAuto;
begin

repeat
leer(iA);
agregarAuto(a, iA);
agregarAlArbol2(a2, iA);
agregarAdelanteV(v[iA.aFabri], iA);

until (iA.marcaYMode='MMM');

end;

function cantAutosMarca(a:arbol; m:string):integer;
begin
if a=nil then 
	cantAutosMarca:=0
else begin
	if a^.elem.marcaYMode=m then
		cantAutosMarca:=1+cantAutosMarca(a^.HI, m)+cantAutosMarca(a^.HD, m)
	else
		cantAutosMarca:=cantAutosMarca(a^.HI, m)+cantAutosMarca(a^.HD, m);
end;
end;

procedure impL (l:lista);
begin
while l<>nil do begin
	writeln(l^.elem.patente);
	writeln(l^.elem.mYM);
	l:=l^.sig
end;
end;

procedure impV (v:vector);
var
i:integer;
begin
for i:=2010 to 2018 do
	impL(v[i]);
	
end;

procedure buscarPatente (a:arbol; p:integer; var mode:string; var ok:boolean);
begin
if a<>nil then begin
	if (a^.elem.patente=p) then begin
		mode:=a^.elem.marcaYMode;
		ok:=true;
	end
	else if (a^.elem.patente>p) then 
		buscarPatente(a^.HI, p, mode, ok)
	else
		buscarPatente(a^.HD, p, mode, ok);
end;
end;


function recorrerLista(l:lista2):integer;
var
cant:integer;
begin
cant:=0;
while l<>nil do begin
	cant:=cant+1;
	l:=l^.sig;
end;
recorrerLista:=cant;
end;



function cantAutosMarcaA2 (a2:arbol2; m:string):integer;
begin
if a2= nil then
	cantAutosMarcaA2:=0
else begin
	if a2^.elem.marca=m then
		cantAutosMarcaA2:=recorrerLista(a2^.elem.lis)
	else
		cantAutosMarcaA2:=cantAutosMarcaA2(a2^.HI, m)+cantAutosMarcaA2(a2^.HD, m);
end;
end;

procedure encontrarPatente (l:lista2; p:integer; var modelo:string; var ok:boolean);
begin
while ((l<>nil) and (ok=false)) do begin
	if l^.elem.pat=p then
		ok:=true
	else
		l:=l^.sig;
end;
end;


procedure buscarPatenteA2 (a2:arbol2; p:integer; var modelo:string; var ok: boolean);
begin
if ((a2<>nil) and (ok=false)) then begin
	encontrarPatente(a2^.elem.lis, p, modelo, ok);
	if ok=true then 
		modelo:=a2^.elem.marca
	else
		buscarPatenteA2(a2^.HI, p, modelo, ok);	
		buscarPatenteA2(a2^.HD, p, modelo, ok);
end;
end;

var
a:arbol;
a2:arbol2;
v:vector;
modelo, mode, m:string;
p:integer;
ok:boolean;
begin
iniV(v);
generarAP(a, a2, v);//Ai y Aii
{writeln('ingresar marca ');
readln(m);
writeln(cantAutosMarca(a, m));//B
writeln(cantAutosMarcaA2(a2, m));//C
impV(v);//D}
writeln('ingrese patente: ');
//ok:=false;
readln(p);
{buscarPatente(a, p, mode, ok);//E
if ok=true then
	writeln('el auto con la patente ', p, 'es del modelo: ', mode)
else
	writeln('con esa patente no se encontro ningun auto');}
ok:=false;
buscarPatenteA2(a2, p, modelo, ok);
if ok=true then
	writeln('el auto con la patente ', p, 'es del modelo: ', modelo)
else
	writeln('con esa patente no se encontro ningun auto');
end.
