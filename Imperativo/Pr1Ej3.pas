program ej3;
type

peli= record
codPeli:integer;
genero:integer;
punt: integer;
end;

lista=^nodo;
nodo=record
elem:peli;
sig:lista;
end;

vecGen = array [1..8] of peli;


procedure iniVecG (var vG: peli)
var
i:integer;
begin
for i:=1 to 8 do 
	vG[i]:=nil;
end

var
l: lista;
vG: vecGen;


begin
iniVecG(vG);
cargarVecG();



end.
