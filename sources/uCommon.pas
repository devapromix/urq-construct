unit uCommon;

interface

uses Forms, Dialogs, Classes, ComCtrls;

const
  // Версия конструктора
  Version = '0.1.0';

const
  // Расширение ini-файла проекта (QCPROJ = QuestConstructPROJect)
  QCProjExt = 'qcproj';

var
  stProjectExists: string = 'Проект %s существует! Перезаписать?';
  stCheckModified: string = 'Проект изменен! Отбросить изменения и продолжить?';
  stProjFilters: string = 'Проект %s|*.%s|Все файлы (*.*)|*.*';

const
  RoomsName = 'Комнаты';
  ItemsName = 'Предметы';
  VarsName = 'Переменные';
  RoomDefaultName = 'room';
  RoomDefaultCaption = 'Комната';

type
  // Типы ресурсов
  TResType = (rtRoom, rtItem, rtVar);

const
  // Запрещенные имена для комнат, предметов и переменных
  ErNames: array [0 .. 2] of string = ('settings', 'items', 'variables');
  // Запрещенные символы для комнат, предметов и переменных
  ErChars: array [0 .. 1] of Char = ('|','&');

var
  // Путь
  Path: string = '';
  // Фильтр
  QCProjFilters: string = '';
  // Разделитель операторов в URQL
  OpDiv: string = '&';

function MsgDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Integer = 0): Integer;
function ExplodeString(const Separator, Source: string): TStringList;
procedure SetTVImages(const TreeNode: TTreeNode;
  const ImgIndex, SelIndex: Integer);
procedure SetTV(const TV: TTreeView; Title: string; ImageIndex: Integer);
function AddTVItem(const TV: TTreeView; const Title: string;
  const ImageIndex, SelectedIndex: Integer): TTreeNode;
function GetResource(const RT: TResType; Current: string = ''): TStringList;
// procedure AddResource(const RT: TResType; AName: string); AddItem, AddVar, и массив, дин. добавл. TV
function GetRoomIndexByName(const AName: string): Integer;
function IfThen(AValue: Boolean; const ATrue: string; const AFalse: string)
  : string; overload;
function IfThen(AValue: Boolean; const ATrue: Char; const AFalse: Char)
  : Char; overload;
function IsErName(const S: string): Boolean;
function IsErChar(const S: string): Boolean;

implementation

uses SysUtils, uMain, uUtils;

function MsgDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Integer = 0): Integer;
begin
  Result := Utils.ShowForm(CreateMessageDialog(Msg, DlgType, Buttons));
end;

function ExplodeString(const Separator, Source: string): TStringList;
begin
  Result := TStringList.Create();
  Result.Text := StringReplace(Source, Separator, #13, [rfReplaceAll]);
end;

procedure SetTVImages(const TreeNode: TTreeNode;
  const ImgIndex, SelIndex: Integer);
begin
  TreeNode.ImageIndex := ImgIndex;
  TreeNode.SelectedIndex := SelIndex;
end;

procedure SetTV(const TV: TTreeView; Title: string; ImageIndex: Integer);
var
  F: TTreeNode;
begin
  TV.Items.Clear;
  F := TV.Items.AddFirst(nil, Title);
  SetTVImages(F, ImageIndex, ImageIndex);
end;

function AddTVItem(const TV: TTreeView; const Title: string;
  const ImageIndex, SelectedIndex: Integer): TTreeNode;
begin
  Result := TV.Items.AddChild(TV.Items.Item[0], Title);
  SetTVImages(Result, ImageIndex, SelectedIndex);
end;

function GetResource(const RT: TResType; Current: string = ''): TStringList;
var
  L: TStringList;
  TV: TTreeView;
  Name, S: string;
  I: Integer;
begin
  TV := nil;
  case RT of
    // Комната
    rtRoom:
      begin
        TV := fMain.TVR;
        Name := RoomsName;
      end;
    // Предмет
    rtItem:
      begin
        TV := fMain.TVI;
        Name := ItemsName;
      end;
    // Переменная
    rtVar:
      begin
        TV := fMain.TVV;
        Name := VarsName;
      end;
  end;
  L := TStringList.Create;
  for I := 0 to TV.Items.Count - 1 do
  begin
    S := LowerCase(TV.Items[I].Text);
    if (S <> Name) and (S <> Current) then
      L.Append(S);
  end;
  Result := L;
end;

function GetRoomIndexByName(const AName: string): Integer;
var
  S: string;
  I: Integer;
begin
  Result := -1;
  for I := 0 to fMain.TVR.Items.Count - 1 do
  begin
    S := LowerCase(fMain.TVR.Items[I].Text);
    if (S <> RoomsName) then
      if (S = AName) then
      begin
        Result := I;
        Exit;
      end;
  end;
end;

function IfThen(AValue: Boolean; const ATrue: string;
  const AFalse: string): string;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Char; const AFalse: Char): Char;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IsErName(const S: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to High(ErNames) do
    if (S = ErNames[I]) then
    begin
      Result := True;
      Exit;
    end;
end;

function IsErChar(const S: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to High(ErChars) do
    if (S.CountChar(ErChars[I]) > 0) then
    begin
      Result := True;
      Exit;
    end;
end;

end.
