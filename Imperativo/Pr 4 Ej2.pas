Program ImperativoClase3;

type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if (a <> nil) then begin 
		InformarDatosSociosOrdenCreciente (a^.HI);
		writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
		InformarDatosSociosOrdenCreciente (a^.HD);
	end;		
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;


procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure NumSocioMasGrande (a:arbol; var numMax:integer);
begin
if a<> nil then begin
	numMax:=a^.dato.numero;
	NumSocioMasGrande(a^.HD, numMax);
end
else
	writeln ('el numero de socio mas grande es: ', numMax);
end;

procedure DatosSocioMasChico (a:arbol; var nomMax:string; var edadMax:integer);
begin
if a<>nil then begin
	nomMax:=a^.dato.nombre;
	edadMax:=a^.dato.edad;
	DatosSocioMasChico(a^.HI, nomMax, edadMax);
end
else
	writeln('el nombre y la edad del socio con el numero mas chico son: ', nomMax, edadMax);
end;


function esta (a:arbol; n:integer):boolean;
begin
if a=nil then 
	esta:=false
else if (a^.dato.numero=n) then
	esta:=true
else if (n>a^.dato.numero) then
	esta:=esta(a^.HD, n)
else
	esta:=esta(a^.HI, n);
end;

procedure CantidadDeSociosEntre2Codigos(a:arbol; cod1, cod2:integer; var cantS:integer);
begin
if a<>nil then begin
	CantidadDeSociosEntre2Codigos(a^.HI, cod1, cod2, cantS);
	if ((cod1<a^.dato.numero) and (a^.dato.numero<cod2)) then
		cantS:=cantS+1;
	CantidadDeSociosEntre2Codigos(a^.HD,   cod1, cod2, cantS);
end;

end;

var 
a: arbol; 
cantS, cod1, cod2, n, edadMax, numMax:integer;
nomMax:string;
Begin
  numMax:=0;
  edadMax:=0;
  cantS:=0;
  randomize;
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
  {InformarSociosOrdenDecreciente (a); COMPLETAR}
  InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);
  { InformarExistenciaNombreSocio (a); COMPLETAR
    InformarCantidadSocios (a); COMPLETAR
    InformarPromedioDeEdad (a); COMPLETAR
  }   
  NumSocioMasGrande(a, numMax);//2i
  DatosSocioMasChico(a, nomMax, edadMax);//2ii
  writeln('ingrese el numero de socio que quiere buscar: ');  
  readln(n);
  writeln(esta(a, n));//2iii
  writeln('ingrese un numero de socio');
  readln(cod1);
  writeln('ingrese  el otro nnumero de socio, que tiene que ser mas grande  que  el anterior');
  readln(cod2);
  CantidadDeSociosEntre2Codigos(a, cod1, cod2, cantS);
  writeln('la cantidad de socios que hay entre esos  2 numeros es: ', cantS);
End.
