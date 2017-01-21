unit uMain;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList;

type
  TfMain = class(TForm)
    MM: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    Window1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    OD: TOpenDialog;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    StatusBar: TStatusBar;
    AL: TActionList;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ToolBar2: TToolBar;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    MenuImages: TImageList;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    mmExport: TMemo;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    PC: TPageControl;
    TabSheet1: TTabSheet;
    TVR: TTreeView;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TVI: TTreeView;
    TVV: TTreeView;
    Splitter1: TSplitter;
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    ToolBar3: TToolBar;
    ToolButton4: TToolButton;
    ToolBar4: TToolBar;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    SD: TSaveDialog;
    TabsImages: TImageList;
    procedure FileExit1Execute(Sender: TObject);
    procedure TVRDblClick(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
  private
    { Private declarations }
    SL: TStringList;
    procedure CreateRoom(const AName: string);
  public
    { Public declarations }
    QL: TStringList;
    function GetRooms(const CurrentRoom: string): TStringList;
    function GetVars(const CurrentVar: string): TStringList;
    function GetItems(const CurrentItem: string): TStringList;
    function GetIndexByName(const AName: string): Integer;
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}  

uses uRoom, uAddRoom, uSelItem, uSelVar, uAddVar, uAddItem;

function TfMain.GetRooms(const CurrentRoom: string): TStringList;
var
  S: string;
  I: Integer;
begin
  SL.Clear;
  for I := 0 to TVR.Items.Count - 1 do
  begin
    S := LowerCase(TVR.Items[I].Text);
    if (S <> RoomsCategoryName) and (S <> CurrentRoom) then
        SL.Append(S);
  end;
  Result := SL;
end;

function TfMain.GetVars(const CurrentVar: string): TStringList;
var
  S: string;
  I: Integer;
begin
  SL.Clear;
  for I := 0 to TVV.Items.Count - 1 do
  begin
    S := LowerCase(TVV.Items[I].Text);
    if (S <> VarsCategoryName) and (S <> CurrentVar) then
        SL.Append(S);
  end;
  Result := SL;
end;

function TfMain.GetItems(const CurrentItem: string): TStringList;
var
  S: string;
  I: Integer;
begin
  SL.Clear;
  for I := 0 to TVI.Items.Count - 1 do
  begin
    S := LowerCase(TVI.Items[I].Text);
    if (S <> ItemsCategoryName) and (S <> CurrentItem) then
        SL.Append(S);
  end;
  Result := SL;
end;

procedure TfMain.CreateRoom(const AName: string);
var
  Room: TfRoom;
  I: Integer;  

  function GetTag: Integer;
  begin
    Result := fMain.GetIndexByName(AName) - 1;
  end;

begin
  for I := 0 to MDIChildCount - 1 do
  with MDIChildren[I] do
  begin
    if (AName = Caption) then
    begin
      Tag := GetTag;
      Show;
      Exit;
    end;
  end;
  Room := TfRoom.Create(Application);
  Room.Tag := GetTag;
  Room.Caption := Format('%s: %s', [uRoom.RoomDefaultCaption, AName]);
end;

procedure TfMain.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TfMain.TVRDblClick(Sender: TObject);
var
  F: TTreeNode;
  S: string;
//  I: Integer;
begin
  F := TVR.Selected;
  S := Trim(F.Text);
  if (S = '') or (S = RoomsCategoryName) then Exit;
  CreateRoom(S);
end;

procedure TfMain.ToolButton14Click(Sender: TObject);
var
  S, Q, D: string;
  I, P: Integer;
  F: Boolean;
begin
  // Export
  with mmExport do
  begin
    Clear;
    for I := 0 to TVR.Items.Count - 1 do
    begin
      S := LowerCase(TVR.Items[I].Text);
      if (S <> RoomsCategoryName) then
      begin
        Lines.Append(':' + S);

        //
        Q := Trim(Self.QL[I - 1]);
        while (Q <> '') do
        begin
          F := Q[1] = '1';
          Delete(Q, 1, 1);
          P := Pos('|', Q);
          D := '';
          if (P <= 0) then
          begin
            if F then D := Copy(Q, 1, Length(Q));
            Q := '';
          end
          else
          begin
            if F then D := Copy(Q, 1, P - 1);
            Delete(Q, 1, P);
          end;
          if (D <> '') then Lines.Append(D);
        end;

        Lines.Append('end');
        if (I < TVR.Items.Count - 1) then
          Lines.Append('');
      end;
    end;
    Visible := True;
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  QL := TStringList.Create;
  SL := TStringList.Create;
  SL.Sorted := True;
  SL.Duplicates := dupIgnore;
  TVR.Items.Clear;
  TVR.Items.AddFirst(nil, RoomsCategoryName);
  TVI.Items.Clear;
  TVI.Items.AddFirst(nil, ItemsCategoryName);
  TVV.Items.Clear;
  TVV.Items.AddFirst(nil, VarsCategoryName);
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  SL.Free;
  QL.Free;
end;

function TfMain.GetIndexByName(const AName: string): Integer;
var
  S: string;
  I: Integer;
begin
  Result := -1;
  for I := 0 to TVR.Items.Count - 1 do
  begin
    S := LowerCase(TVR.Items[I].Text);
    if (S <> RoomsCategoryName) then
      if (S = AName) then
      begin
        Result := I;
        Exit;
      end;
  end;
end;

procedure TfMain.ToolButton2Click(Sender: TObject);
begin
  Self.QL.SaveToFile('test.urq');
  ShowMessage('Проект сохранен!');
end;

procedure TfMain.ToolButton5Click(Sender: TObject);
begin
  fAddRoom.NewRoom; // Добавить новую комнату
end;

procedure TfMain.ToolButton3Click(Sender: TObject);
begin
  fAddVar.NewVar; // Добавить новую переменную
end;

procedure TfMain.ToolButton4Click(Sender: TObject);
begin
  fAddItem.NewItem; // Добавить новый предмет
end;

end.
