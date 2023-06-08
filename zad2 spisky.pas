type
point = ^Node;
Node=record
count: integer;
next: point;
end;

var phead, qhead: point;

procedure addHead(var t:point);
var y:point; i:integer;
begin
new(y);
i :=random(0, 100);
y^.count := i;
y^.next := t;
t:=y;
end;

begin
for var i:=1 to 10 do
begin
addHead(phead);
end;
qhead:=phead;
while (qhead<>nil) do
begin
write(qhead^.count,' ');
qhead:=qhead^.next;
end;

// Выводим список на экран
qhead:=phead;
writeln;
while (qhead<>nil) do
begin
if qhead^.count mod 2 = 0 then
write(qhead^.count,' ');
qhead:=qhead^.next;
end;
// Выводим только четные элементы списка
  {qhead:=phead;
  writeln;
  while (qhead<>nil) do
  begin
    if qhead^.count mod 2 = 0 then
      write(qhead^.count,' ');
    qhead:=qhead^.next;
  end;}
end.