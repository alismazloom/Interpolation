 Program Interpolation;
 var
   x ,Result ,Max ,Min : Real;
   i,j,n : integer;
   T : Array [-1..100,0..100] of Real;
 procedure Lagrange;
 function L(m:Byte):Real;
 var
   p:Real;
 Begin
   p:=1;
   for j:=0 to n do
     if(j <> m) then
       p:=p * (x - T[-1,j]) / (T[-1,m] - T[-1,j]);
   L:=p;
 end;
 begin
   Result:=0;
   for i:=0 to n do
     Result:=Result + L(i) * T[0,i];
 end;
 procedure Newton;
 function C(m:Byte):Real;
 var
   p:Real;
 Begin
   p:=1;
   for j:=0 to (m-1) do
     p:=p * (x - T[-1,j]);
   C:=p;
 end;
 Begin
   for i:=1 to n do
     for j:= 0 to (n-i) do
       T[i,j]:=(T[i-1,j+1] - T[i-1,j]) / (T[-1,j+i] - T[-1,j]);
   Result:= T[0,0];
   for i:=1 to n do
     Result:= Result + C(i) * T[i,0];
 end;
 procedure Forward;
 var
   r:Real;
 function C(m:Byte):Real;
 var
   p:Real;
 Begin
   p:=1;
   for j:=0 to (m-1) do
     p:=p * (r-j) / (j+1);
   C:=p;
 end;
 Begin
   r:=(x - T[-1,0]) / (T[-1,1] - T[-1,0]);
   for i:=1 to n do
     for j:=0 to (n-i) do
       T[i,j]:=(T[i-1,j+1] - T[i-1,j]);
   Result:=T[0,0];
   for i:=1 to n do
     Result:=Result + C(i) * T[i,0];
 end;
 procedure Backward;
 var
   r:Real;
 function C(m:Byte):Real;
 var
   p:Real;
 Begin
   p:=1;
   for j:=0 to (m-1) do
     p:=p * (r+j) / (j+1);
   C:=p;
 end;
 Begin
   r:=(x - T[-1,0]) / (T[-1,0] - T[-1,1]);
   for i:=1 to n do
     for j:=0 to (n-i) do
       T[i,j]:=(T[i-1,j] - T[i-1,j+1]);
   Result:=T[0,0];
   for i:=1 to n do
     Result:=Result + C(i) * T[i,0];
 end;
 procedure Decision;
 var
   Count:Byte;
   Input:Char;
 Begin
   Count:=1;
   for i:=0 to (n-2) do
     if (abs(2*T[-1,i+1] - T[-1,i] - T[-1,i+2]) < 0.000000001) then
       Count:=Count + 1;
   if (Count = n) and (n>1) then
   Begin
     if ((T[-1,1] - T[-1,0]) > 0) then
       Forward
     else
       Backward
   end
   else
   Begin
     Writeln;
     Writeln('Input <L> for "Lagrange Method" ');
     Writeln('   or <N> for "Newton Method" and then press Enter:');
     Repeat
       Read(Input);
     until(Upcase(Input)='L') or (Upcase(Input)='N');
     if (Input = 'L') then
       Lagrange
     else
       Newton;
   end;
 end;
 Begin
   Write('Enter N:');
   Readln(n);
   n:=n-1;
   Writeln('Enter the X values:');
   for j:= 0 to n do
   begin
     Readln(T[-1,j]);
     if j=0 then
     begin
       Max:=T[-1,j];
       Min:=T[-1,j];
     end;
     if (T[-1,j] > Max) then
       Max:=T[-1,j];
     if (T[-1,j] < Min) then
       Min:=T[-1,j];
   end;
   Writeln('Enter the f(x) values:');
   for j:= 0 to n do
      Readln(T[0,j]);
   Repeat
      Write('Enter A Valid X:');
      Readln(x);
   Until (x>=Min) and (x<=Max);
   Decision;
   writeln;
   writeln('Result = ',Result:10:9);
 end.




