program turnoC;
type
envio=record
	codCli:integer;
	dia:integer;
	codPostal:integer;
	peso:integer;
end;


regLista=record
	codCli:integer;
	dia:integer;
	peso:integer;
end;

lista=^nodo;
nodo=record
	elem:regLista;
	sig:lista;
end;

regArbol=record
	codPostal:integer;
	l:lista;
end;

arbol=^nodo2;
nodo2=record
	elem:regArbol;
	hi:arbol;
	hd:arbol;
end;


procedure leer (var e:envio);
begin
readln(e.codCli);
readln(e.dia);
readln(e.codPostal);
readln(e.peso);
end;

procedure agregarAdelante (var l:lista; c:integer; d:integer; p:integer);
var
nue:lista;
begin
new(nue);
nue^.elem.codCli:=c;
nue^.elem.dia:=d;
nue^.elem.peso:=p;
nue^.sig:=l;
l:=nue;
end;


procedure agregarCliente (var a:arbol; e:envio);
begin
if a=nil then begin
	new(a);
	a^.elem.codPostal:=e.codPostal;
	a^.elem.l:=nil;
	agregarAdelante(a^.elem.l, e.codCli, e.dia, e.peso);
	a^.hi:=nil;
	a^.hd:=nil;
end
else begin
	if a^.elem.codPostal>e.codPostal then
		agregarCliente(a^.hi, e)
	else if a^.elem.codPostal<e.codPostal then
		agregarCliente(a^.hd, e)
	else if a^.elem.codPostal=e.codPostal then
		agregarAdelante(a^.elem.l, e.codCli, e.dia, e.peso);
end;
end;


procedure generarA (var a:arbol);
var
e:envio;
begin
leer(e);

while e.codCli<>0 do begin
	agregarCliente(a, e);
	leer(e);
end;
end;

procedure recorrerLista (l:lista; var l2:lista);
begin
while l<>nil do begin
	agregarAdelante(l2, l^.elem.codCli, l^.elem.dia, l^.elem.peso);
	l:=l^.sig;
end;

end;



procedure recorrerArbol (a:arbol; var l2:lista; cP:integer);
begin
if a=nil then
	writeln('el arbol esa vacio ')
else begin
	if a^.elem.codPostal=cP then
		recorrerLista(a^.elem.l, l2)
	else if a^.elem.codPostal>cP then
		recorrerArbol(a^.hi, l2, cP)
	else if a^.elem.codPostal<cP then
		recorrerArbol(a^.hd, l2, cP);
end;
end;



procedure mayorYMenorPeso (l2:lista; var pMax:integer; var pMin:integer; var cMax:integer; var cMin:integer);
begin
while l2<>nil do begin
	if l2^.elem.peso>pMax then begin
		pMax:=l2^.elem.peso;
		cMax:=l2^.elem.codCli;
	end;
	if l2^.elem.peso<pMin then begin
		pMin:=l2^.elem.peso;
		cMin:=l2^.elem.codCli;
	end;
	l2:=l2^.sig;
end;
end;


var
a:arbol;
l2:lista;
cMax, pMax, cMin, pMin, cP:integer;

begin
pMax:=-1;
pMin:=9999;
l2:=nil;
generarA(a);//A

writeln('ingresar un codigo postal: ');
readln(cP);
recorrerArbol(a, l2, cP);//B

mayorYMenorPeso(l2, pMax, pMin, cMax, cMin);//C
writeln('el codigo del cliente con el envio mas pesado es: ', cMax);
writeln('el codigo del cliente con el envio mas liviano es: ', cMin);


end.
