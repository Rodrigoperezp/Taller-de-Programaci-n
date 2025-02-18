program finalSecu;

type
alumno=record
	nom:string;
	dni:integer;
	tiempo:integer;
end;


arbol=^nodo;
nodo=record
	elem:alumno;
	hi:arbol;
	hd:arbol;
end;

lista=^nodo2;
nodo2=record
	elem:alumno;
	sig:lista;
end;

procedure leer (var alu:alumno);
begin
readln(alu.nom);
readln(alu.dni);
readln(alu.tiempo);
end;

procedure agregarAlumno (var a:arbol; alu:alumno);
begin
if a=nil then begin
	new(a);
	a^.elem:=alu;
	a^.hi:=nil;
	a^.hd:=nil;
end
else begin
	if a^.elem.tiempo>alu.tiempo then
		agregarAlumno(a^.hi, alu)
	else if a^.elem.tiempo<alu.tiempo then
		agregarAlumno(a^.hd, alu);
end;
end;

procedure generarA (var a:arbol);
var
alu:alumno;
begin
leer(alu);
while alu.dni<>0 do begin
	agregarAlumno(a, alu);
	leer(alu);
end;
end;

procedure insertarOrdenado (var l:lista; alu: alumno);
var
nue, act, ant:lista;
begin
new(nue);
nue^.elem:=alu;
ant:=l;
act:=l;

while ((act<>nil)and(alu.tiempo>act^.elem.tiempo)) do begin
	ant:=act;
	act:=act^.sig;
end;
if (act=ant)then
	l:=nue
else
	ant^.sig:=nue;
nue^.sig:=act;
end;

procedure recorrerArbol (a:arbol; r1:integer; r2:integer; var l:lista);
begin
if a<>nil then begin
	if a^.elem.tiempo>r1 then begin
		if a^.elem.tiempo<r2 then begin
			insertarOrdenado(l, a^.elem);
			recorrerArbol(a^.hi,r1,r2,l);
			recorrerArbol(a^.hd,r1,r2,l);
		end
		else
			recorrerArbol(a^.hi, r1, r2, l);
	end
	else
		recorrerArbol(a^.hd,r1,r2,l);	
end;
end;

procedure alumnoMasRapido (a:arbol; var nom:string; var dni:integer; var t:integer);
begin
if a<>nil then begin
	if a^.elem.tiempo<t then begin
		t:=a^.elem.tiempo;
		nom:=a^.elem.nom;
		dni:=a^.elem.dni;
		alumnoMasRapido(a^.hi, nom, dni, t);
	end
	else
		alumnoMasRapido(a^.hi, nom, dni, t);
end;
end;


procedure impA (a:arbol);
begin
if a<>nil then begin
	impA(a^.hi);
	writeln(a^.elem.nom);
	writeln(a^.elem.dni);
	writeln(a^.elem.tiempo);
	impA(a^.hd);
end;
end;

procedure impL(l:lista);
begin
while l<>nil do begin
	writeln(l^.elem.nom);
	writeln(l^.elem.dni);
	writeln(l^.elem.tiempo);
	l:=l^.sig;
end;
end;

var
a:arbol;
l:lista;
nom:string;
dni:integer;
t, r1, r2:integer;
begin
t:=999;
l:=nil;
generarA(a);//A

impA(a);

writeln('ingrese el numero minimo del rango: ');
readln(r1);
writeln('ingrese el numero maximo del rango: ');
readln(r2);

recorrerArbol(a, r1, r2, l);//B
impL(l);

alumnoMasRapido(a, nom, dni, t);//C
writeln('el alumno: ', nom, ' con dni: ', dni, 'fue el mas rapido');
end.
