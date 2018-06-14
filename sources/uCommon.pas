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
  ErChars: array [0 .. 1] of Char = ('|', '&');

var
  // Фильтр
  QCProjFilters: string = '';
  // Разделитель операторов в URQL
  OpDiv: string = '&';

type
  Common = class(TObject)
    class function MsgDlg(const Msg: string; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Integer = 0): Integer;
    class function ExplodeString(const Separator, Source: string): TStringList;
    class procedure SetTVImages(const TreeNode: TTreeNode;
      const ImgIndex, SelIndex: Integer);
    class procedure SetTV(const TV: TTreeView; Title: string;
      ImageIndex: Integer);
    class function AddTVItem(const TV: TTreeView; const Title: string;
      const ImageIndex, SelectedIndex: Integer): TTreeNode;
    class procedure GetResource(var SL: TStringList; const RT: TResType;
      Current: string = '');
    // procedure AddResource(const RT: TResType; AName: string); AddItem, AddVar, и массив, дин. добавл. TV
    class function GetRoomIndexByName(const AName: string): Integer;
    class function IfThen(AValue: Boolean; const ATrue: string;
      const AFalse: string): string; overload;
    class function IfThen(AValue: Boolean; const ATrue: Char;
      const AFalse: Char): Char; overload;
    class function IsErName(const S: string): Boolean;
    class function IsErChar(const S: string): Boolean;
    class function IsFirstCharDigit(const S: string): Boolean;
  end;

implementation

uses SysUtils, uMain, uUtils;

class function Common.MsgDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Integer = 0): Integer;
begin
  Result := Utils.ShowForm(CreateMessageDialog(Msg, DlgType, Buttons));
end;

class function Common.ExplodeString(const Separator, Source: string)
  : TStringList;
begin
  Result := TStringList.Create();
  Result.Text := StringReplace(Source, Separator, #13, [rfReplaceAll]);
end;

class procedure Common.SetTVImages(const TreeNode: TTreeNode;
  const ImgIndex, SelIndex: Integer);
begin
  TreeNode.ImageIndex := ImgIndex;
  TreeNode.SelectedIndex := SelIndex;
end;

class procedure Common.SetTV(const TV: TTreeView; Title: string;
  ImageIndex: Integer);
var
  F: TTreeNode;
begin
  TV.Items.Clear;
  F := TV.Items.AddFirst(nil, Title);
  SetTVImages(F, ImageIndex, ImageIndex);
end;

class function Common.AddTVItem(const TV: TTreeView; const Title: string;
  const ImageIndex, SelectedIndex: Integer): TTreeNode;
begin
  Result := TV.Items.AddChild(TV.Items.Item[0], Title);
  SetTVImages(Result, ImageIndex, SelectedIndex);
end;

class procedure Common.GetResource(var SL: TStringList; const RT: TResType;
  Current: string = '');
var
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
  SL.Clear;
  for I := 0 to TV.Items.Count - 1 do
  begin
    S := LowerCase(TV.Items[I].Text);
    if (S <> Name) and (S <> Current) then
      SL.Append(S);
  end;
end;

class function Common.GetRoomIndexByName(const AName: string): Integer;
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

class function Common.IfThen(AValue: Boolean; const ATrue: string;
  const AFalse: string): string;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

class function Common.IfThen(AValue: Boolean; const ATrue: Char;
  const AFalse: Char): Char;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

class function Common.IsErName(const S: string): Boolean;
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

class function Common.IsErChar(const S: string): Boolean;
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

class function Common.IsFirstCharDigit(const S: string): Boolean;
begin
  Result := (S[1] in ['0' .. '9']);
end;

end.
