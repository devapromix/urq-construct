unit uMain;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, IniFiles, Math, uCommon, System.Actions,
  System.ImageList;

type
  TfMain = class(TForm)
    MM: TMainMenu;
    N33: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    OD: TOpenDialog;
    WindowMinimizeItem: TMenuItem;
    AL: TActionList;
    ToolBar2: TToolBar;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    MenuImages: TImageList;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton1: TToolButton;
    PC: TPageControl;
    tsRooms: TTabSheet;
    TVR: TTreeView;
    tsItems: TTabSheet;
    tsVars: TTabSheet;
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
    acSaveProject: TAction;
    ToolButton7: TToolButton;
    acNewProject: TAction;
    acOpenProject: TAction;
    SB: TStatusBar;
    N2: TMenuItem;
    acAddRoom: TAction;
    acAddItem: TAction;
    acAddVar: TAction;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N22: TMenuItem;
    acExitProgram: TAction;
    N1: TMenuItem;
    acExportToQST: TAction;
    ToolButton2: TToolButton;
    N13: TMenuItem;
    N14: TMenuItem;
    ToolButton9: TToolButton;
    ToolButton14: TToolButton;
    acCloseAll: TAction;
    N15: TMenuItem;
    N16: TMenuItem;
    acMinimizeAll: TAction;
    acCascade: TAction;
    acTile: TAction;
    acClose: TAction;
    N17: TMenuItem;
    N12: TMenuItem;
    acAbout: TAction;
    About1: TMenuItem;
    acSettings: TAction;
    N18: TMenuItem;
    ToolButton11: TToolButton;
    ToolButton15: TToolButton;
    N19: TMenuItem;
    mmExport: TPanel;
    ToolBar5: TToolBar;
    ToolButton16: TToolButton;
    mmExportMemo: TMemo;
    acSaveQST: TAction;
    procedure TVRDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acSaveProjectExecute(Sender: TObject);
    procedure acNewProjectExecute(Sender: TObject);
    procedure acOpenProjectExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acSaveProjectUpdate(Sender: TObject);
    procedure acAddRoomExecute(Sender: TObject);
    procedure acAddItemExecute(Sender: TObject);
    procedure acAddVarExecute(Sender: TObject);
    procedure acExitProgramExecute(Sender: TObject);
    procedure acNewProjectUpdate(Sender: TObject);
    procedure acExportToQSTExecute(Sender: TObject);
    procedure acExportToQSTUpdate(Sender: TObject);
    procedure acMinimizeAllExecute(Sender: TObject);
    procedure acCascadeExecute(Sender: TObject);
    procedure acTileExecute(Sender: TObject);
    procedure acCloseExecute(Sender: TObject);
    procedure acCloseAllExecute(Sender: TObject);
    procedure acCloseUpdate(Sender: TObject);
    procedure acCloseAllUpdate(Sender: TObject);
    procedure acMinimizeAllUpdate(Sender: TObject);
    procedure acCascadeUpdate(Sender: TObject);
    procedure acTileUpdate(Sender: TObject);
    procedure acAboutExecute(Sender: TObject);
    procedure acSettingsExecute(Sender: TObject);
    procedure acSaveQSTExecute(Sender: TObject);
    procedure acSaveQSTUpdate(Sender: TObject);
  private
    { Private declarations }
    SL: TStringList;
    FFileName: string;
    FModified: Boolean;
    procedure NewProject;
    procedure SetModified(const Value: Boolean);
  public
    { Public declarations }
    QL: TStringList;
    procedure CreateRoom(const AName: string);
    function CheckModified: Boolean;
    procedure UpdateProject();
    property Modified: Boolean read FModified write SetModified;

  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses uRoom, uAddRoom, uSelItem, uSelVar, uAddVar, uAddItem,
  uAbout, uSettings, uUtils, uLanguage;

procedure TfMain.CreateRoom(const AName: string);
var
  I: Integer;
  Room: TfRoom;

  function GetCurrent(const AName: string): Integer;
  begin
    Result := Common.GetRoomIndexByName(AName) - 1;
  end;

  function GetCaption(const AName: string): string;
  begin
    Result := Format('%s: %s [%d]', [RoomDefaultCaption, AName,
      GetCurrent(AName)]);
  end;

begin
  for I := 0 to MDIChildCount - 1 do
    with MDIChildren[I] do
    begin
      if (GetCaption(AName) = Caption) then
      begin
        Show();
        Exit;
      end;
    end;
  if (Common.GetRoomIndexByName(AName) < 0) then
    Exit;
  Room := TfRoom.Create(Application);
  Room.Current := GetCurrent(AName);
  Room.Caption := GetCaption(AName);
  Room.LoadCLB(Room.Current);
end;

procedure TfMain.UpdateProject;
var
  S, Modif: string;
  SL: TStringList;
const
  F = '%s (%d)';
begin
  // Caption
  S := Common.IfThen((FFileName <> ''),
    Format(' - %s', [ExtractFileName(FFileName)]), '');
  Modif := Common.IfThen(Modified, '*', '');
  // if (FFileName <> '') then S := Format(' - %s', [ExtractFileName(FFileName)]) else S := '';
  // if Modified then Modif := '*' else Modif := '';
  Caption := Format(Trim('%s %s'), [Application.Title, S]) + Modif;
  // Tabs
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtRoom, '');
    tsRooms.Caption := Format(F, [RoomsName, SL.Count]);
    Common.GetResource(SL, rtItem, '');
    tsItems.Caption := Format(F, [ItemsName, SL.Count]);
    Common.GetResource(SL, rtVar, '');
    tsVars.Caption := Format(F, [VarsName, SL.Count]);
  finally
    SL.Free;
  end;
end;

procedure TfMain.TVRDblClick(Sender: TObject);
var
  S: string;
begin
  mmExport.Visible := False;
  S := Trim(TVR.Selected.Text);
  if (S = '') or (S = RoomsName) then
    Exit;
  CreateRoom(S);
end;

procedure TfMain.NewProject;
var
  I: Integer;
begin
  SL.Clear;
  QL.Clear;
  Common.SetTV(TVR, RoomsName, 0);
  Common.SetTV(TVI, ItemsName, 1);
  Common.SetTV(TVV, VarsName, 2);
  for I := MDIChildCount - 1 downto 0 do
    with MDIChildren[I] do
      Close;
  PC.ActivePageIndex := 0;
  mmExport.Visible := False;
  FFileName := '';
  Modified := False;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  Language := TLanguage.Create(True);
  QCProjFilters := Format(stProjFilters, [Application.Title, QCProjExt]);
  QL := TStringList.Create;
  SL := TStringList.Create;
  SL.Duplicates := dupIgnore;
  NewProject;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  SL.Free;
  QL.Free;
  Language.SaveDefault;
  FreeAndNil(Language);
end;

function TfMain.CheckModified: Boolean;
begin
  Result := False;
  if Modified and (Common.MsgDlg(stCheckModified, mtConfirmation, mbOKCancel) <>
    mrOk) then
    Result := True;
end;

procedure TfMain.acSaveProjectExecute(Sender: TObject);
label
  save_label;
var
  I: Integer;
  Ini: TIniFile;

  function AddItems(): string;
  var
    I: Integer;
    D: string;
  begin
    Result := '';
    for I := 0 to SL.Count - 1 do
    begin
      D := Common.IfThen(I <> SL.Count - 1, '|', '');
      // if (I <> SL.Count - 1) then D := '|' else D := '';
      Result := Result + SL[I] + D;
    end;
  end;

begin
  // Сохранить проект
  SD.InitialDir := Utils.GetPath('projects');
  SD.DefaultExt := QCProjExt;
  SD.Filter := QCProjFilters;
  SD.FilterIndex := 0;
  if (FFileName <> '') then
  begin
    SD.FileName := FFileName;
    goto save_label;
  end;
  if SD.Execute then
  begin
    if FileExists(SD.FileName) and
      (Common.MsgDlg(Format(stProjectExists, [ExtractFileName(SD.FileName)]),
      mtConfirmation, [mbOk, mbCancel]) = mrCancel) then
      Exit;
    DeleteFile(SD.FileName);
    FFileName := SD.FileName;
  save_label:
    Ini := TIniFile.Create(SD.FileName);
    try
      // Настройки
      Ini.WriteString('settings', 'value', '');
      // Комнаты
      Common.GetResource(SL, rtRoom, '');
      for I := 0 to SL.Count - 1 do
        Ini.WriteString(SL[I], 'value', QL[I]);
      // Предметы
      Common.GetResource(SL, rtItem, '');
      Ini.WriteString('items', 'value', AddItems());
      // Переменные
      Common.GetResource(SL, rtVar, '');
      Ini.WriteString('variables', 'value', AddItems());
    finally
      Ini.Free;
    end;
    Modified := False;
  end;
end;

procedure TfMain.acNewProjectExecute(Sender: TObject);
begin
  // Новый проект
  if CheckModified then
    Exit;
  NewProject;
end;

{ procedure LoadLayer(L: TLayerEnum);
  var
  X, Y: Integer;
  SL: TStringList;
  V: TArray<string>;
  begin
  SetLength(FMap[L], FWidth, FHeight);
  Node := XMLDoc.DocumentElement.ChildNodes[I].ChildNodes['data'];
  SL := TStringList.Create;
  SL.Text := Trim(Node.Text);
  for Y := 0 to FHeight - 1 do
  begin
  V := SL[Y].Split([',']);
  for X := 0 to FWidth - 1 do
  FMap[L][X][Y] := StrToIntDef(V[X], 0) - 1;
  end;
  FreeAndNil(SL);
  end; }

procedure TfMain.acOpenProjectExecute(Sender: TObject);
var
  S, N: string;
  I: Integer;
  Ini: TIniFile;
  V: TArray<string>;
begin
  // Загрузить проект
  if CheckModified then
    Exit;
  OD.InitialDir := Utils.GetPath('projects');
  OD.DefaultExt := QCProjExt;
  OD.Filter := QCProjFilters;
  OD.FilterIndex := 0;
  if OD.Execute then
  begin
    NewProject;
    FFileName := OD.FileName;
    Ini := TIniFile.Create(OD.FileName);
    try
      // Настройки

      // Комнаты
      QL.Clear;
      SL.Clear;
      Ini.ReadSections(SL);
      for I := 0 to SL.Count - 1 do
      begin
        if Common.IsErName(SL[I]) or Common.IsErChar(SL[I]) then
          Continue;
        Common.AddTVItem(TVR, SL[I], 3, 4);
        QL.Append(Ini.ReadString(SL[I], 'value', ''));
      end;
      // Предметы
      S := Ini.ReadString('items', 'value', '');
      V := S.Split(['|']);
      for I := 0 to High(V) do
      begin
        N := Trim(V[I]);
        if (N <> '') then
          Common.AddTVItem(TVI, N, 1, 1);
      end;
      // Переменные
      S := Ini.ReadString('variables', 'value', '');
      V := S.Split(['|']);
      for I := 0 to High(V) do
      begin
        N := Trim(V[I]);
        if (N <> '') then
          Common.AddTVItem(TVV, N, 2, 2);
      end;
    finally
      Ini.Free;
    end;
  end;
  Modified := False;
end;

procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not CheckModified;
end;

procedure TfMain.SetModified(const Value: Boolean);
begin
  FModified := Value;
  UpdateProject;
end;

procedure TfMain.acSaveProjectUpdate(Sender: TObject);
begin
  acSaveProject.Enabled := Modified;
end;

procedure TfMain.acAddRoomExecute(Sender: TObject);
begin
  fAddRoom.NewRoom; // Добавить новую комнату
end;

procedure TfMain.acAddItemExecute(Sender: TObject);
begin
  fAddItem.NewItem; // Добавить новый предмет
end;

procedure TfMain.acAddVarExecute(Sender: TObject);
begin
  fAddVar.NewVar; // Добавить новую переменную
end;

procedure TfMain.acExitProgramExecute(Sender: TObject);
begin
  Close; // Завершить работу
end;

procedure TfMain.acNewProjectUpdate(Sender: TObject);
begin
  acNewProject.Enabled := (FFileName <> '') or Modified;
end;

procedure TfMain.acExportToQSTUpdate(Sender: TObject);
begin
  acExportToQST.Enabled := (FFileName <> '') or Modified;
end;

procedure TfMain.acExportToQSTExecute(Sender: TObject);
var
  S, Q, D, M, U: string;
  I, P, V: Integer;
  F, H: Boolean;

  procedure Add(S: string);
  begin
    V := mmExportMemo.Lines.Add(S);
  end;

begin
  // Экспорт
  with mmExportMemo do
  begin
    if mmExport.Visible then
    begin
      mmExport.Visible := False;
      Exit;
    end;
    Clear;
    for I := 0 to TVR.Items.Count - 1 do
    begin
      S := LowerCase(TVR.Items[I].Text);
      if (S <> RoomsName) then
      begin
        Add(':' + S);
        //
        Q := Trim(Self.QL[I - 1]);
        H := False;
        M := '';
        while (Q <> '') do
        begin
          F := Q[1] = '1';
          Delete(Q, 1, 1);
          P := Pos('|', Q);
          D := '';
          if (P <= 0) then
          begin
            if F then
              D := Trim(Copy(Q, 1, Length(Q)));
            Q := '';
          end
          else
          begin
            if F then
              D := Trim(Copy(Q, 1, P - 1));
            Delete(Q, 1, P);
          end;
          if (D = 'finishblock') then
          begin
            D := '';
            M := '';
            H := False;
          end;
          if (D = 'startblock') then
          begin
            D := ' then ';
            M := '';
            H := True;
          end;
          if H then
          begin
            if (Copy(D, 1, 3) = 'if ') then
              M := '';
            Lines[V] := Lines[V] + D + M;
            M := OpDiv;
          end
          else
          begin
            U := Lines[V];
            if (V > 0) and (U[Length(U)] = OpDiv) then
              Delete(U, Length(U), 1);
            Lines[V] := U;
            if (D <> '') then
              Add(D);
          end;
        end;

        Add('end');
        if (I < TVR.Items.Count - 1) then
          Add('');
      end;
    end;
    mmExport.Visible := True;
  end;
end;

procedure TfMain.acMinimizeAllExecute(Sender: TObject);
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

procedure TfMain.acCascadeExecute(Sender: TObject);
begin
  Cascade;
end;

procedure TfMain.acTileExecute(Sender: TObject);
begin
  Tile;
end;

procedure TfMain.acCloseExecute(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) then
    ActiveMDIChild.Close;
end;

procedure TfMain.acCloseAllExecute(Sender: TObject);
var
  I: Integer;
begin
  for I := MDIChildCount - 1 downto 0 do
    if (MDIChildren[I] <> nil) then
      MDIChildren[I].Close;
end;

procedure TfMain.acCloseUpdate(Sender: TObject);
begin
  acClose.Enabled := Self.MDIChildCount > 0;
end;

procedure TfMain.acCloseAllUpdate(Sender: TObject);
begin
  acCloseAll.Enabled := Self.MDIChildCount > 0;
end;

procedure TfMain.acMinimizeAllUpdate(Sender: TObject);
begin
  acMinimizeAll.Enabled := Self.MDIChildCount > 0;
end;

procedure TfMain.acCascadeUpdate(Sender: TObject);
begin
  acCascade.Enabled := Self.MDIChildCount > 0;
end;

procedure TfMain.acTileUpdate(Sender: TObject);
begin
  acTile.Enabled := Self.MDIChildCount > 0;
end;

procedure TfMain.acAboutExecute(Sender: TObject);
begin
  Utils.ShowForm(fAbout)
end;

procedure TfMain.acSettingsExecute(Sender: TObject);
begin
  Utils.ShowForm(fSettings)
end;

procedure TfMain.acSaveQSTExecute(Sender: TObject);
begin
  Self.mmExportMemo.Lines.SaveToFile(Utils.GetPath('quests') +
    ChangeFileExt(ExtractFileName(FFileName), '.qst'));
  Common.MsgDlg('Квест сохранен в папке "Quests"!', mtInformation, [mbOk]);
end;

procedure TfMain.acSaveQSTUpdate(Sender: TObject);
begin
  acSaveQST.Enabled := FFileName <> ''
end;

end.
