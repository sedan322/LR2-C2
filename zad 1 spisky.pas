type
  Node_ptr = ^Node; // объявление нового типа, содержащего указатель на запись Node
  Node = record // определение записи Node
    data: string; // поле данных - строка (слово)
    count: integer; // поле данных - число (количество упоминаний слова)
    Node_next: Node_ptr; // указатель на следующий узел списка
  end;

var
  Node_adr, Node_adr1, counter, Node_new, Node_place1, p: Node_ptr;

var
  F: text;

function TakeWord(F: Text): string; // функция чтения слова из файла
var
  c: char;
begin
  Result := ''; { пустая строка }
  c := ' '; { пробел – чтобы войти в цикл }
  { пропускаем спецсимволы и пробелы }
  while not eof(f) and (c <= ' ') do
    read(F, c);
  { читаем слово }
  while not eof(f) and (c > ' ') do
  begin
    Result := Result + c;
    read(F, c);
  end;
  if eof(f) then Result := Result + c;
end;

function CreateNode(NewWord: string): Node_ptr; // функция создания нового узла списка
var
  NewNode: Node_ptr;
begin
  New(NewNode); // динамическое выделение памяти для нового узла
  NewNode^.data := NewWord; // присваивание полю данных нового узла значения NewWord
  NewNode^.count := 1; // инициализация поля count значением 1
  NewNode^.Node_next := nil; // инициализация указателя на следующий узел списка значением nil
  Result := NewNode;
end;

function Find(Head: Node_ptr; NewWord: string): Node_ptr; // функция поиска узла со словом NewWord в списке, начинающемся с узла Head
var
  pp: Node_ptr;
begin
  pp := Head;
  // пока не конец списка и слово в просматриваемом узле не равно искомому
  while (pp <> nil) and (NewWord <> pp^.data) do // пока не достигнут конец списка или найдено искомое слово
    pp := pp^.Node_next;
  Result := pp;
end;

procedure AddFirst(var Head: Node_ptr; NewNode: Node_ptr); // процедура добавления нового узла в начало списка
begin
  NewNode^.Node_next := Head; // установка указателя на следующий узел нового узла на текущий первый узел списка
  Head := NewNode; // установка указателя на первый узел списка на новый узел
end;

procedure AddAfter(var Head: Node_ptr; NewNode: Node_ptr); // процедура добавления нового узла после текущего узла списка Head
begin
  NewNode^.Node_next := Head^.Node_next; // установка указателя на следующий узел нового узла на следующий узел Head
  Head^.Node_next := NewNode; // установка указателя на следующий узел Head на новый узел
end;

procedure AddBefore(var Head: Node_ptr; p, NewNode: Node_ptr); // процедура добавления нового узла перед указанным узлом p в списке Head
var
  pp: Node_ptr;
begin
  pp := Head; // инициализация указателя pp значени
  if p = Head then
    AddFirst( Head, NewNode) // добавление в начало списка
  else begin
    while (pp <> nil) and (pp^.Node_next <> p) do // поиск узла, за которым следует узел p
      pp := pp^.Node_next;
    if pp <> nil then AddAfter( pp, NewNode); // добавляем после узла pp
  end;
end;

function FindPlace(Head: Node_ptr; NewWord: string): Node_ptr; // функция поиска места для вставки нового узла со словом NewWord в алфавитном порядке
var
  pp: Node_ptr;
begin
  pp := Head;
  while (pp <> nil) and (NewWord > pp^.data) do // пока не достигнут конец списка или найдено место для вставки нового узла
    pp := pp^.Node_next;
  Result := pp;
  // слово NewWord в алфавитном порядке находится перед pp^.word
end;

begin
  Node_place1 := nil; // инициализация указателя на первый узел списка nil
  assign(F, 'text.txt'); // открытие файла для чтения
  var word_1: string;
  reset(F); // открытие файла для чтения
  while not eof(F) do // пока не достигнут конец файла
  begin
    word_1 := TakeWord(F); // чтение очередного слова из файла
    if Find(Node_place1, word_1) <> nil then Find(Node_place1, word_1)^.count := Find(Node_place1, word_1)^.count + 1 // если в списке уже есть узел со словом word_1, то увеличиваем счетчик этого узла на 1
    else begin
      Node_new := CreateNode(word_1); // создание нового узла для слова word_1
      Node_adr := FindPlace(Node_place1, word_1); // поиск места для вставки нового узла в алфавитном порядке
      AddBefore(Node_place1, Node_adr, Node_new); // добавление нового узла перед узлом, найденным функцией FindPlace
      
    end;
    
  end;
  close(F);
  Node_adr1 := Node_place1; // инициализация указателя на первый узел списка значением Node_place1
  while Node_adr1 <> nil do // пока не достигнут конец списка
  begin
    writeln(Node_adr1^.data, Node_adr1^.count); // вывод на экран слова и количество его упоминаний
    Node_adr1 := Node_adr1^.Node_next; // переход к следующему узлу списка
  end;
  writeln;
end.
