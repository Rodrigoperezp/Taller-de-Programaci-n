program ej4;

procedure converBina (n:integer);
begin
if (n<2) then
	write(n)
else begin
	converBina(n div 2);
    write(n mod 2);
end;
end;


var
n:integer;
begin
writeln('ingrese un numero decimal  ');
readln(n);
if (n<>0) then
	writeln('El numero ',n,' convertido a binario es :');
    converBina(n);

end.
