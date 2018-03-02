PROGRAM tris;

TYPE
  tdyn = array of integer;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function Generer(n, min, max: integer): tdyn;
  var tab: tdyn;
      i: integer;
  begin
    setlength(tab, n);
    randomize;
    for i := 0 to n-1 do
      tab[i] := random(max-min+1)+min;
    Generer := tab;
  end;

//------------------------------------------------------------------------------

procedure Affichage(tab: tdyn);
  var i : integer;
  begin
    write('|');
    for i := 0 to high(tab) do
      write(tab[i],'|');
    writeln;
  end;

//------------------------------------------------------------------------------

procedure MinMax(var min, max: integer);
  var k: integer;
  begin
    if min > max then
    begin
      k := min;
      min := max;
      max := k;
    end;
  end;

//------------------------------------------------------------------------------

function GenTotal(): tdyn;
  var tab: tdyn;
      n, max, min: integer;
  begin
    write('Taille du tableau ? : ');
    readln(n);
    write('Minimum ? : ');
    readln(min);
    write('Maximum ? : ');
    readln(max);
    MinMax(min,max);
    tab := Generer(n,min,max);
    GenTotal := tab;
  end;

//------------------------------------------------------------------------------

function Permut(var tab: tdyn; a, b: integer): tdyn;
  var x: integer;
  begin
    x := tab[a];
    tab[a] := tab[b];
    tab[b] := x;
    Permut := tab;
  end;

//------------------------------------------------------------------------------

function Bulle(tab: tdyn): tdyn;
  var tri: boolean;
      i: integer;
  begin
    repeat
      tri := true;
      for i := 1 to high(tab) do
        if tab[i-1]>tab[i] then
        begin
          Permut(tab, i-1, i);
          tri := false;
        end;
    until (tri);
    Bulle := tab;
  end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

VAR tab: tdyn;

BEGIN
  tab := GenTotal;
  Affichage(tab);
  Affichage(Bulle(tab));
END.
