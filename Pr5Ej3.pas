program ej3;
type

productos=record
	cod:integer;
	rubro:integer;
	stock:integer;
	precio:integer;
end;


produ=record
	cod:integer;
	stock:integer;
	preUni:integer;
end;

arbol=^nodo;
nodo=record
	elem:produ;
	hi:arbol;
	hd:arbol;
end;
 
vectorR= array [1..3] of arbol;
 
 
 procedure iniv(var v:vectorR);
 var
 i:integer;
 begin
 for i:=1 to 3 do 
	v[i]:=nil;
 end;
 
 
 procedure leer (var p:productos);
 begin
 readln(p.cod);
 readln(p.rubro);
 readln(p.stock);
 readln(p.precio);
 end;
 
 
 procedure agregarAlArbol (var a:arbol; cod:integer; stock:integer; pre:integer);
 begin
if a=nil then begin
	new(a); 
	a^.elem.cod:=cod;
	a^.elem.stock:=stock;
	a^.elem.preUni:=pre;
	a^.hi:=nil;
	a^.hd:=nil; 
end
else
	if a^.elem.cod>cod then
		agregarAlArbol(a^.hi, cod, stock, pre)
	else if a^.elem.cod<cod then
		agregarAlArbol(a^.hd, cod, stock, pre); 
end;
 
procedure generarV (var v:vectorR);
var
p:productos;
begin
 
leer(p);
while p.cod <>0 do begin
	agregarAlArbol(v[p.rubro], p.cod, p.stock, p.precio);
	leer(p);
end;
end;


function existe (a:arbol; c:integer):boolean; 
var 
ok:boolean;
begin
if a=nil then//si el arbol esta vacio
	existe:=false
else
	if a^.elem.cod=c then
		existe:=true
	else begin
		ok:=existe(a^.hi, c);
		if ok=false then
			existe:=existe(a^.hd, c);
 end;
 end;
 
 procedure recorrerArbol (a:arbol; var codMax:integer; var stockMax:integer);
 begin
 if a<>nil then begin
	codMax:=a^.elem.cod;
	stockMax:=a^.elem.stock;
	recorrerArbol(a^.hd, codMax, stockMax); 
 end;
 end;
 
 
 procedure mayorCodigo (v:vectorR);
 var
 codMax, stockMax, i:integer;
 begin
 for i:=1 to 3 do begin
	recorrerArbol(v[i], codMax, stockMax);
	writeln('del rubro: ', i, ' el codigo maximo es: ', codMax, ' y su stock es: ', stockMax);
 end;
 end;
 
 

 
function cantidadProdu(a:arbol; c1:integer; c2:integer):integer;
 begin
if a=nil then 
	cantidadProdu:=0
else begin
	if a^.elem.cod>c1 then begin
		if a^.elem.cod<c2 then 
			cantidadProdu:=1+cantidadProdu(a^.hi, c1, c2)+cantidadProdu(a^.hd, c1, c2)
		else
			cantidadProdu(a^.hi, c1, c2);				
	end
	else 
		cantidadProdu(a^.hd, c1, c2);
 end;
 end;
 
procedure produEntreValores (v:vectorR; c1:integer; c2:integer);
 var
 i:integer;
 begin
 for i:=1 to 3 do 
	writeln('la cantidad de producto que hay entre el ', c1, ' y ', c2, ' es: ', cantidadProdu(v[i], c1, c2));
  end;
 
var
v:vectorR;
r, c, c1, c2:integer;
begin
iniV(v);
generarV(v);//A
{writeln('ingresar un rubro: ');
readln(r);
writeln('ingresar un codigo: ');
readln(c);
writeln('este codigo se encuentra en este rubro? ', existe(v[r], c));//B
mayorCodigo(v);//C}
writeln('ingresar el codigo 1: ');
readln(c1);
writeln('ingresar el codigo 2: ');
readln(c2);
produEntreValores(v, c1, c2);//D
end.
