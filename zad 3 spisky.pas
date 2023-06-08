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

function MaxFind(Head: point): point;
var pp: point; max:integer;
begin
pp := Head;
while (pp<>nil) do
begin
if max<pp^.count then
max:=pp^.count;
pp := pp^.next;
end;
pp := Head;
while (pp <> nil) and (max <> pp^.count) do
pp := pp^.next;
MaxFind := pp;
end;

function MinFind(Head: point): point;
var pp: point; min:integer;
begin
pp := Head;
min:=pp^.count;
while (pp<>nil) do
begin
if min>pp^.count then
min:=pp^.count;
pp := pp^.next;
end;
pp := Head;
while (pp <> nil) and (min <> pp^.count) do
pp := pp^.next;
MinFind := pp;
end;

begin
  // Заполняем список случайными числами
end;
for var i:=1 to random(1,25) do
begin
addHead(phead);
end;

// Выводим список на экран
qhead:=phead;
while (qhead<>nil) do
begin
write(qhead^.count,' ');
qhead:=qhead^.next;
end;

// Находим максимальное и минимальное число и выводим их адреса и значения
writeln;
qhead:=phead;
MaxFind(qhead);
Writeln('Адрес максимального числа: ',MaxFind(qhead),' Само число: ',MaxFind(qhead)^.count);
Writeln('Адрес минимального числа: ',MinFind(qhead),' Само число: ',MinFind(qhead)^.count);
end.