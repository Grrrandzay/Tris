PROGRAM tris;

USES crt;

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
//a et b indices de cases.
  var x: integer;
  begin
    x := tab[a];
    tab[a] := tab[b];
    tab[b] := x;
    Permut := tab;
  end;

//------------------------------------------------------------------------------

function Partition(var tab: tdyn; g, d: integer): integer;
  var i, p, x: integer;
  begin
    //writeln(d);
    x := g;
    p := tab[d];
    for i := g to d do
    begin
      if tab[i]<=p then
      begin
        permut(tab,x,i);
        x := x+1;
        //writeln(x);
      end;
    end;
    //writeln(x);
    Partition := x-1;
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

//------------------------------------------------------------------------------

function Selection(tab: tdyn): tdyn;
  var i, j, t: integer;
  begin
    for i := 0 to high(tab) do
    begin
      t := i;
      for j := i to high(tab) do
        if tab[j]<tab[t]
          then t := j;
      Permut(tab,i,t);
    end;
    Selection := tab;
  end;

//------------------------------------------------------------------------------

function Insertion(tab: tdyn): tdyn;
  var i, j, t: integer;
  begin
    for i := 1 to high(tab) do
    begin
      t := tab[i];
      j := i;
      while t<tab[j-1] do
      begin
        tab[j] := tab[j-1];
        j := j-1;
      end;
      tab[j] := t;
    end;
    Insertion := tab;
  end;

//------------------------------------------------------------------------------

function Rapide(tab: tdyn; g, d: integer): tdyn;
  var i: integer;
  begin
    delay(500);
    Affichage(tab);
    //writeln(g,' : ',d);
    if g >= d
      then Rapide := tab
      else
      begin
        i := Partition(tab, g, d);
        //Affichage(tab);
        //writeln(i);
        //writeln('1');
        tab := Rapide(tab,g,i-1);
        //writeln('2');
        Rapide := Rapide(tab,i+1,d);
      end;
  end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

VAR tab: tdyn;

BEGIN
  tab := GenTotal;
  Affichage(tab);
  writeln('--------------------');
  //Affichage(Bulle(tab));
  //Affichage(Selection(tab));
  //Affichage(Insertion(tab));
  Affichage(Rapide(tab,0,high(tab)));
  writeln('[Bulle / Selection / Insertion / Rapide]');
END.
