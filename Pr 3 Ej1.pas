program ej1;
type

socios=record
num:integer;
nom:string;
edad:integer;
end;

arbol = ^nodo;
nodo = record 
elem:socios;
HI:arbol;
HD:arbol;
end;

procedure  agregar (var a:arbol; ns:integer; nom:string; ed:integer);
begin
if (a=nil) then begin
	new(a);
	a^.elem.num:=ns;
	a^.elem.nom:=nom;
	a^.elem.edad:=ed;
	a^.HI:=nil;
	a^.HD:=nil;
end
else if (ns<=a^.elem.num) then
	agregar(a^.HI,  ns,  nom, ed)
else
	agregar (a^.HD, ns, nom, ed);
end;

procedure impA (a:arbol);//B1) ordenado de forma ascendente
begin
if (a<>nil) then begin
	impA(a^.HI);
	write (a^.elem.num);
	write (a^.elem.nom);
	writeln (a^.elem.edad);
	impA(a^.HD);
end;
end;

procedure impD (a:arbol);//B2) ordenado de forma descendente
begin
if (a<>nil) then begin
	impD(a^.HD);
	write (a^.elem.num);
	write (a^.elem.nom);
	writeln (a^.elem.edad);
	impD(a^.HI);
end;
end;

procedure impIzq (a:arbol);//primero escribe la raiz y   despues se va yendo xra la  izquierda e imprimiendo,  una vez q termina de  ir a la izq va para la derecha
begin
if (a<>nil) then begin
	write (a^.elem.num);
	write (a^.elem.nom);
	writeln (a^.elem.edad);
	impIzq(a^.HI);
	impIzq(a^.HD);
end;
end;

procedure impDeAbajoParaArriba (a:arbol);//primero va lo mas a abajo y a la izq posible y ahi arranca a imprimir de abajo para arriba. Una vez q terminnna de imprimir el lado izq hace lo  mismo  con el derecho y x ultimo imprime la raiz  
begin
if (a<>nil) then begin
	impDeAbajoParaArriba(a^.HI);
	impDeAbajoParaArriba(a^.HD);
	write (a^.elem.num);
	write (a^.elem.nom);
	writeln (a^.elem.edad);

end;
end;

procedure recorrerA (a:arbol; var nm:integer; var em:integer);//B3)
begin
if (a<>nil) then begin
	recorrerA(a^.HI, nm, em);
	if em<a^.elem.edad then  begin
		em:=a^.elem.edad;
		nm:=a^.elem.num;			
	end;

	recorrerA(a^.HD, nm, em);
end;
end;

procedure impares (a:arbol; var canti:integer);//B4)
begin
if (a<>nil) then begin
	impares(a^.HI, canti);
	if a^.elem.edad mod 2<>0 then  begin
		a^.elem.edad:=a^.elem.edad+1;
		canti:=canti+1;
	end;	
	impares(a^.HD, canti);
end;
end;

{function buscarNom (a:arbol; n:string):boolean;

begin
   if ( a <> nil ) then begin
    if a^.elem.nom= n then
		buscarNom:=true
	
	else begin		
		buscarNom (a^.HI, n);
    buscarNom (a^.HD, n);
    end;
	end;
writeln(a^.elem.nom);
if a^.elem.nom<>n then
buscarNom:=false;
end;}

Function buscar(A:arbol; nombre:String): boolean; 
var
ok:boolean;
Begin
  If (A=Nil) Then
    buscar := false
  Else
    Begin
      If (A^.elem.nom = nombre) Then
        buscar := true
      Else
        Begin
         ok:= buscar(A^.HI,nombre) ;
          if ok= false then
          ok :=buscar(A^.HD,nombre);
				 buscar:=ok;
        End;
       
    End;
End;


procedure cantSocios  (a:arbol;  var cs:integer);
begin
if a<>nil then begin

	cantSocios(a^.HI, cs);
	cs:=cs+1;
	cantSocios(a^.HD, cs);
end;
end;

procedure promedio (a:arbol; var te:integer);
begin
if a<>nil then  begin
	promedio(a^.HI, te);
	te:=te+a^.elem.edad;
	promedio(a^.HD, te);
end;
end;


var
abb:arbol;
prom, totale,  cants, canti, nmax, emax, ns, ed:integer;
n, nomb:string;
ok:boolean;
begin
abb:=nil;
prom:=0;
totale:=0;
cants:=0;
canti:=0;
nmax:=0;
emax:=0;
randomize;
ns:=random(11);
//readln(ns);
readln(nomb);
ed:=random(101);
while (ns<>0) do begin
	agregar(abb, ns, nomb, ed);
	ns:=random(11);
	//readln(ns);	
	readln(nomb);
	ed:=random(101);
end;
impA(abb);
//impIzq(abb);
//impDeAbajoParaArriba(abb);
//impD(abb);
recorrerA(abb, nmax,  emax);
writeln('el numero de socio con mayor edad es: ',  nmax);
impares(abb, canti);
writeln('aumenta en 1 la edad de los de los socios con edad impar');
impA(abb);
writeln('la cantidad de socios con edad impar era: ', canti);
writeln('ingrese un nombre para ver si esta cargado');
readln(n);
ok:=buscar(abb, n);
writeln(ok);
cantSocios(abb, cants);
writeln('la cantidad total de socios es:  ', cants);
promedio(abb, totale);
prom:=totale div cants;
writeln('el   promedio de edad de los socios es: ', prom);
end.
