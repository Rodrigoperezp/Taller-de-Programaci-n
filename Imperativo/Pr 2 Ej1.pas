program ej1;
type

vector = array [1..15] of integer;



procedure cargarVec(var v:vector; var diml:integer);
var
ale:integer;
begin
ale:= 10 +  random (146); // 155-10+1=146
if ((diml<15)and (ale<>20)) then begin
	diml:=diml+1;	
	v[diml]:=ale;
	cargarVec(v, diml);
end;
end;

procedure impVec (v:vector; diml:integer);
var
i:integer;
begin
for i:=1 to diml do 

	writeln(v[i]);	

end;

procedure impVecRe (v:vector; diml:integer; var i:integer);
begin
if i<diml then begin
	i:=i+1;
	writeln(v[i]);
	impVecRe(v, diml, i);
end;
end;

procedure sumaPares (v:vector; diml:integer; var total:integer; var j:integer);
begin
if (j<diml) then begin
	j:=j+1;
	if  v[j] mod 2=0 then 
		total:=total+v[j];
	sumaPares(v, diml, total, j);
end;
end;

procedure maximo (v:vector; diml:integer; var max:integer; var k:integer);
begin
if k<diml then begin
	k:=k+1;
	if v[k]>max then
		max:=v[k];
	maximo(v, diml, max, k);
end;
end;

procedure encuentra (v:vector; diml:integer; val:integer; var ok:boolean; var q:integer);
begin
if q<diml then  begin
	q:=q+1;
	if v[q]=val then
		ok:=true;
	encuentra(v, diml, val, ok, q);
end;
end;


procedure descomponer (v:vector; diml:integer; x:integer);
var
dig:integer;
begin
dig:=0;
	if  v[x]> 0 then begin
		dig:=v[x] mod 10;
		v[x]:= v[x] div 10;
		descomponer (v, diml, x);
		writeln (dig);
end;
end;



procedure g(v:vector; diml:integer; var x:integer);
begin
if  x<diml then begin
	x:=x+1;
	descomponer(v, diml, x);
	g(v, diml, x);
end;
end;

var
v:vector;
max, total, val, x, q, k, j, i, diml:integer;//preguntar como usar menos variables sin tener q innicializarla tantas veces en 0
ok:boolean;
begin
ok:=false;
diml:=0;
max:=-1;
total:=0;
x:=0;
i:=0;
k:=0;
j:=0;
q:=0;
randomize;
cargarVec(v, diml);
impVec(v, diml);
writeln('RECU ');
impVecRe(v, diml, i);
sumaPares(v, diml, total, j);
writeln('la suma total de los valores pares en el vector es ', total);
maximo(v, diml, max, k);
writeln('el máximo valor del vector es ', max);
readln(val);
encuentra(v, diml, val, ok,  q);
writeln (ok);
g(v, diml, x);
end.
