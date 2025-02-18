program TurnoG;
type
prestamos=record
	num:integer;
	isbn:integer;
	codS:integer;
end;

arbol=^nodo;
nodo=record
	elem:prestamos;
	hi:arbol;
	hd:arbol;
end;
regL=record	
	codS:integer;
	cantP:integer;
end;

lista=^nodo2;
nodo2=record
	elem:regL;
	sig:lista;
end;


procedure leer (var p:prestamos);
begin
readln(p.num);
readln(p.isbn);
readln(p.codS);
end;

procedure generarA (var a:arbol; p:prestamos);
begin
if a=nil then begin
	new(a);
	a^.elem:=p;
	a^.hi:=nil;
	a^.hd:=nil;
end
else begin
	if a^.elem.isbn>p.isbn then
		agregarPrestamo(a^.hi, p)
	else 
		agregarPrestamo(a^.hd, p);
end;
end;



procedure buscarCod (l:lista; cod:integer; var ok: boolean);
begin
while ((l<>nil)and(cod>=l^.elem.codS)and(ok=false)) do begin
	if l^.elem.codS=cod then begin
		l^.elem.cantP:=l^.elem.cantP+1;
		ok:=true;
	end;
	if ok=false then
		l:=l^.sig;
end;
end;

procedure insertarOrdenado (var l:lista; p:prestamos);
var
nue, act, ant:lista;
begin
new(nue);
nue^.elem.codS:=p.codS;
nue^.elem.cantP:=1;
ant:=l;
act:=l;
while ((act<>nil)and(act^.elem.codS<p.codS)) do begin
	ant:=act;
	act:=act^.sig;
end;
if (act=ant)then
	l:=nue
else
	ant^.sig:=nue;
nue^.sig:=act;
end;


procedure generarL (var l:lista; p:prestamos);
var
ok:boolean;
begin
	ok:=false;
	buscarCod(l, p.codS, ok);
	if ok=false then
		insertarOrdenado(l, p);
end;


function cantPres (a:arbol; isbn:integer):integer;
begin
if a=nil then
	cantPres:=0
else begin
	if a^.elem.isbn=isbn then
		cantPres:=1+cantPres(a^.hd, isbn)
	else if a^.elem.isbn>isbn then
		cantPres:=cantPres(a^.hi, isbn)
	else if a^.elem.isbn<isbn then
		cantPres:=cantPres(a^.hd, isbn);
end;
end;

function cantSocios (l:lista; x:integer):integer;
begin
if (l<> nil) then begin	
	if l^.elem.cantP<=x then				
		cantSocios:=cantSocios(l^.sig, x)
	else
		cantSocios:=1+ cantSocios(l^.sig, x);
end
else
	cantSocios:=0;
end;

procedure impL (l:lista);
begin
while l<>nil  do begin
	writeln(l^.elem.codS);
	writeln(l^.elem.cantP);
	l:=l^.sig;
end;
end;

var
a:arbol;
l:lista;
p:prestamos;
x, isbn:integer;
begin
l:=nil;
leer(p);
while p.codS<>0 do begin
	//generarA(a, p);//Ai
	generarL(l, p);//Aii
	leer(p);
end;
{
writeln('ingresar un isbn');
readln(isbn);
writeln('la cantidad de prestamos que se hicieron con ese ISBN fueron: ', cantPres(a, isbn));//B
}
impL(l);

writeln('ingresar un valor');
readln(x);
writeln(cantSocios(l, x), 'es la cantidad de socios con mas prestamos que el valor anteriormente ingresado');//C



end.
