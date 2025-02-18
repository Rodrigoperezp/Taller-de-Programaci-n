program ej4;
type
reclamo=record
	cod:integer;
	dni:integer;
	ano:integer;
	tipo:string;
end;

regLista=record
	cod:integer;
	ano:integer;
	tipo:string;
end;

lista=^nodo2;
nodo2=record
	elem:regLista;
	sig:lista;
end;

reclamos=record
	dni:integer;
	cantTotalR:integer;
	l:lista;
end;


arbol=^nodo;
nodo=record
	elem:reclamos;
	hi:arbol;
	hd:arbol;
end;

procedure leer (var r:reclamo);
begin
readln(r.cod);
readln(r.dni);
readln(r.ano);
readln(r.tipo);
end;


procedure agregarAdelante (var l:lista; cod:integer; ano:integer; tipo:string);
var
nue:lista;
begin
new(nue);	
nue^.elem.cod:=cod;
nue^.elem.ano:=ano;
nue^.elem.tipo:=tipo;
nue^.sig:=l;
l:=nue;
end;

procedure agregarReclamo (var a:arbol; r:reclamo);
begin
if a=nil then begin
	new(a);
	a^.elem.dni:=r.dni;
	a^.elem.cantTotalR:=1;
	a^.elem.l:=nil;
	agregarAdelante(a^.elem.l, r.cod, r.ano, r.tipo);
	a^.hi:=nil;
	a^.hd:=nil;
end
else
	if a^.elem.dni>r.dni then
		agregarReclamo(a^.hi, r)
	else if a^.elem.dni<r.dni then
		agregarReclamo(a^.hd, r)
	else if a^.elem.dni=r.dni then begin
		a^.elem.cantTotalR:=a^.elem.cantTotalR+1;
		agregarAdelante(a^.elem.l, r.cod, r.ano, r.tipo);
	end;
end;

procedure generarA (var a:arbol);
var
r:reclamo;
begin
leer(r);
while r.cod<>0 do begin
	agregarReclamo(a, r);
	leer(r);
end;
end;



function cantR (a:arbol; dni:integer):integer;
begin
if a= nil then
	cantR:=0
else
	if a^.elem.dni>dni then
		cantR(a^.hi, dni)
	else if a^.elem.dni<dni then
		cantR(a^.hd, dni)
	else if a^.elem.dni=dni then
		cantR:=a^.elem.cantTotalR;
end;

function reclamosEntreDosDNI (a:arbol; d1:integer; d2:integer):integer;
begin
if a=nil then
	reclamosEntreDosDNI:=0
else begin
	if a^.elem.dni>d1 then begin
		if a^.elem.dni<d2 then
			reclamosEntreDosDNI:=a^.elem.cantTotalR+reclamosEntreDosDNI(a^.hi,d1, d2)+reclamosEntreDosDNI(a^.hd, d1, d2)
		else 
			reclamosEntreDosDNI(a^.hi, d1, d2);	
	end
	else
		reclamosEntreDosDNI(a^.hd, d1, d2);

end;
end;

procedure recorrerLista (l:lista; ano:integer);
begin
while l<>nil do begin
	if l^.elem.ano=ano then
		writeln(l^.elem.cod);
	l:=l^.sig;
end;
end;

procedure reclamosXAno (a:arbol; ano:integer);
begin
if a<>nil then begin
	reclamosXAno(a^.hi, ano);
	recorrerLista(a^.elem.l, ano);
	reclamosXAno(a^.hd, ano);
end;
end;

var
a:arbol;
ano, d1, d2, dni:integer;
begin
generarA(a);//A
writeln('ingresar un DNI ');
readln(dni);
writeln(cantR(a, dni));//B
writeln('ingresar el primer dni: ');
readln(d1);
writeln('ingresar el segundo dni: ');
readln(d2);
writeln(reclamosEntreDosDNI(a, d1, d2));//C  
writeln('ingresar ano: ');
readln(ano);
reclamosXAno(a, ano);//D

end.
