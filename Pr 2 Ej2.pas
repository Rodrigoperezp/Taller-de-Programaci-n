program  ej2;
type


lista=^nodo;
nodo=record
elem:integer;
sig:lista
end;

procedure agregarAdelante (var l:lista; ale:integer);
var
nue:lista;
begin
new(nue);
nue^.elem:=ale;
nue^.sig:=l;
l:=nue;
end;

procedure  cargarL (var l:lista);
var
ale:integer;
begin
ale:=100 + random(101);//200-100+1=101
if ale<>100 then begin
	agregarAdelante(l, ale);
	cargarL(l);
end;
end;


procedure impL (l:lista);//B)
begin
if l<>nil  then begin
	writeln(l^.elem);
	impL(l^.sig);
end;
end;

procedure impLInver (l:lista);//C)
begin
if l<>nil then begin
	impLInver(l^.sig);
	writeln(l^.elem);
end;
end;

procedure minimo (l:lista; var min:integer);//D)
begin
if   l<>nil then begin
	if min>l^.elem then 
		min:=l^.elem;	
	minimo(l^.sig, min);
	end;
end;

procedure encuentra (l:lista; n:integer; var ok:boolean);
begin
if l<>nil then begin
	if l^.elem=n then
		ok:=true
		
	else 
		encuentra(l^.sig, n, ok);
end;
end;

var
l:lista;
n, min:integer;
ok:boolean;
begin
l:=nil;
ok:=false;
min:=999;
randomize;
cargarL(l);
writeln('lista ordenada ');
impL(l);
writeln('lista inversa ');
//impLInver(l);
minimo(l,  min);
writeln ('el  valor minimo de la lista es ', min);
readln(n);
encuentra(l, n, ok);
writeln('se encontro el valor? ', ok);
end.
