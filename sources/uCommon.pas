unit uCommon;

interface

uses Forms, Dialogs, Classes, ComCtrls;

const
  // ������ ������������
  Version = '0.1.0';
  // ���������� ini-����� ������� (QCPROJ = QuestConstructPROJect)
  QCProjExt = 'qcproj';
  
var
  stProjectExists: string = '������ %s ����������! ������������?';
  stCheckModified: string = '������ �������! ��������� ��������� � ����������?';
  stProjFilters: string = '������ %s|*.%s|��� ����� (*.*)|*.*';

const
  RoomsName = '�������';
  ItemsName = '��������';
  VarsName = '����������';
  RoomDefaultName = 'room';
  RoomDefaultCaption = '�������';

type
  // ���� ��������
  TResType = (rtRoom, rtItem, rtVar);

var
  // ����
  Path: string = '';
  // ������
  QCProjFilters: string = '';
  // ����������� ���������� � URQL
  OpDiv: string = '&';

function MsgDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Integer = 0): Integer;
function ExplodeString(const Separator, Source: string): TStringList;
procedure SetTVImages(const TreeNode: TTreeNode; const ImgIndex, SelIndex: Integer);
procedure SetTV(const TV: TTreeView; Title: string; ImageIndex: Integer);
function AddTVItem(const TV: TTreeView; const Title: string; const ImageIndex, SelectedIndex: Integer): TTreeNode;
function GetResource(const RT: TResType; Current: string = ''): TStringList;
//procedure AddResource(const RT: TResType; AName: string); AddItem, AddVar, � ������, ���. ������. TV
function FormShowModal(Form: TForm): Integer;
function GetRoomIndexByName(const AName: string): Integer;
function IfThen(AValue: Boolean; const ATrue: string; const AFalse: string): string; overload;
function IfThen(AValue: Boolean; const ATrue: Char; const AFalse: Char): Char; overload;

implementation

uses SysUtils, uMain;

function MsgDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Integer = 0): Integer;
begin
  Result := FormShowModal(CreateMessageDialog(Msg, DlgType, Buttons));
end;

function ExplodeString(const Separator, Source: string): TStringList;
begin
  Result := TStringList.Create();
  Result.Text := StringReplace(Source, Separator, #13, [rfReplaceAll]);
end;

procedure SetTVImages(const TreeNode: TTreeNode; const ImgIndex, SelIndex: Integer);
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

function AddTVItem(const TV: TTreeView; const Title: string; const ImageIndex, SelectedIndex: Integer): TTreeNode;
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
    // �������
    rtRoom:
    begin
      TV := fMain.TVR;
      Name := RoomsName;
    end;
    // �������
    rtItem:
    begin
      TV := fMain.TVI;
      Name := ItemsName;
    end;
    // ����������
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

function FormShowModal(Form: TForm): Integer;
begin
  with Form do
  begin
    Position := poOwnerFormCenter;
    Result := ShowModal;
  end;
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

function IfThen(AValue: Boolean; const ATrue: string; const AFalse: string): string;
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

end.