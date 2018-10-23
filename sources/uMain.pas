unit uMain;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, IniFiles, Math, uCommon, System.Actions,
  System.ImageList, SynEdit, SynEditHighlighter, SynHighlighterURQL;

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
    acSaveQST: TAction;
    ToolButton17: TToolButton;
    acRun: TAction;
    acRun1: TMenuItem;
    SynEdit1: TSynEdit;
    SynURQLSyn1: TSynURQLSyn;
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
    procedure acRunExecute(Sender: TObject);
    procedure acRunUpdate(Sender: TObject);
  private
    { Private declarations }
    SL: TStringList;
    FFileName: string;
    FModified: Boolean;
    FExported: Boolean;
    procedure NewProject;
    procedure SetModified(const Value: Boolean);
    procedure LoadProject(const FileName: string);
    procedure UpdateProject();
    procedure UpdateTab(TabName: string; TabResType: TResType; TabComp: TTabSheet);
    procedure SetDefaultProjectSettings;
  public
    { Public declarations }
    QCProjFileList: TStringList;
    procedure SetDefaultProjectValues;
    procedure CreateRoom(const AName: string);
    function CheckModified: Boolean;
    property Modified: Boolean read FModified write SetModified;

  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses uRoom, uAddRoom, uSelItem, uSelVar, uAddVar, uAddItem,
  uAbout, uSettings, uUtils, uLanguage, ShellAPI;

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
    Result := Format('%s: %s [%d]', [RoomDefaultCaption, AName, GetCurrent(AName)]);
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
  Room.Width := 500;
  Room.Current := GetCurrent(AName);
  Room.Caption := GetCaption(AName);
  Room.LoadCLB(Room.Current);
end;

procedure TfMain.UpdateProject;
var
  S, Modif: string;
begin
  // Caption
  S := Common.IfThen((FFileName <> ''), Format(' - %s', [ExtractFileName(FFileName)]), '');
  Modif := Common.IfThen(Modified, '*', '');
  // if (FFileName <> '') then S := Format(' - %s', [ExtractFileName(FFileName)]) else S := '';
  // if Modified then Modif := '*' else Modif := '';
  Caption := Format('%s %s'.Trim, [Application.Title, S]) + Modif;
  // Tabs
  UpdateTab(RoomsName, rtRoom, tsRooms);
  UpdateTab(ItemsName, rtItem, tsItems);
  UpdateTab(VarsName, rtVar, tsVars);
end;

procedure TfMain.UpdateTab(TabName: string; TabResType: TResType; TabComp: TTabSheet);
var
  SL: TStringList;
const
  F = '%s (%d)';
begin
  SL := TStringList.Create;
  try
    Common.GetResource(SL, TabResType, '');
    TabComp.Caption := Format(F, [TabName, Math.EnsureRange(SL.Count - 1, 0, High(Word))]);
  finally
    SL.Free;
  end;
end;

procedure TfMain.TVRDblClick(Sender: TObject);
var
  S: string;
begin
  mmExport.Visible := False;
  S := TVR.Selected.Text.Trim;
  if (S = '') or (S = RoomsName) then
    Exit;
  CreateRoom(S);
end;

procedure TfMain.NewProject;
var
  I: Integer;
begin
  SL.Clear;
  QCProjFileList.Clear;
  Common.SetTV(TVR, RoomsName, 0);
  Common.SetTV(TVI, ItemsName, 1);
  Common.SetTV(TVV, VarsName, 2);
  for I := MDIChildCount - 1 downto 0 do
    with MDIChildren[I] do
      Close;
  PC.ActivePageIndex := 0;
  mmExport.Visible := False;
  FFileName := '';
  FExported := False;
  Modified := False;
end;

procedure TfMain.FormCreate(Sender: TObject);
var
  I, N: Integer;
  F: string;
begin
  Language := TLanguage.Create(True);
  QCProjFilters := Format(stProjFilters, [Application.Title, QCProjExt]);
  QCProjFileList := TStringList.Create;
  SL := TStringList.Create;
  SL.Duplicates := dupIgnore;
  NewProject;
  F := '';
  if ParamCount > 0 then
  begin
    N := 1;
    // Debug mode -d
    if (Trim(ParamStr(1)) = '-d') then
    begin
      N := 2;
      // FIsDebug := True;
    end;
    if ParamCount > 0 then
    begin
      for I := N to ParamCount do
        F := Trim(F + ' ' + ParamStr(I));
      LoadProject(F);
      Exit;
    end;
  end;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  SL.Free;
  QCProjFileList.Free;
  Language.SaveDefault;
  FreeAndNil(Language);
end;

function TfMain.CheckModified: Boolean;
begin
  Result := False;
  if Modified and (Common.MsgDlg(stCheckModified, mtConfirmation, mbOKCancel) <> mrOk) then
    Result := True;
end;

procedure TfMain.SetDefaultProjectValues;
begin
  // Дефолтная информация об игре
  // Информация о версии
  if (fSettings.SettingsValueListEditor.Cells[1, Ord(veVersion)] = '') then
    fSettings.SettingsValueListEditor.Cells[1, Ord(veVersion)] := '1.0.0';
end;

procedure TfMain.SetDefaultProjectSettings;
begin
  // Записываем посл. изменение проекта
  fSettings.SettingsValueListEditor.Cells[1, Ord(veDateTime)] := DateToStr(Date) + ' ' + TimeToStr(Time);
  // Информация о версии
  SetDefaultProjectValues;
  fSettings.SaveConfig;
end;

procedure TfMain.acSaveProjectExecute(Sender: TObject);
label
  save_label;
var
  I: Integer;
  Ini: TIniFile;
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
    if FileExists(SD.FileName) and (Common.MsgDlg(Format(stProjectExists, [ExtractFileName(SD.FileName)]), mtConfirmation, [mbOk, mbCancel])
      = mrCancel) then
      Exit;
    DeleteFile(SD.FileName);
    FFileName := SD.FileName;
  save_label:
    Ini := TIniFile.Create(SD.FileName);
    try
      // Настройки
      SL.Clear;
      for I := 1 to fSettings.SettingsValueListEditor.RowCount - 1 do
        SL.Append(fSettings.SettingsValueListEditor.Cells[1, I]);
      Ini.WriteString('settings', 'value', string.Join(TkDiv, SL.ToStringArray));
      // Комнаты
      Common.GetResource(SL, rtRoom, '');
      for I := 0 to SL.Count - 1 do
        Ini.WriteString(SL[I], 'value', QCProjFileList[I]);
      // Предметы
      Common.GetResource(SL, rtItem, '');
      Ini.WriteString('items', 'value', string.Join(TkDiv, SL.ToStringArray));
      // Переменные
      Common.GetResource(SL, rtVar, '');
      Ini.WriteString('variables', 'value', string.Join(TkDiv, SL.ToStringArray));
    finally
      Ini.Free;
    end;
    Modified := False;
  end;
  SetDefaultProjectSettings;
end;

procedure TfMain.acNewProjectExecute(Sender: TObject);
begin
  // Новый проект
  if CheckModified then
    Exit;
  NewProject;
  SetDefaultProjectSettings;
end;

procedure TfMain.LoadProject(const FileName: string);
var
  S, N: string;
  I: Integer;
  Ini: TIniFile;
  V: TArray<string>;
begin
  FFileName := Trim(FileName);
  Ini := TIniFile.Create(FFileName);
  try
    // Настройки

    // Комнаты
    QCProjFileList.Clear;
    SL.Clear;
    Ini.ReadSections(SL);
    for I := 0 to SL.Count - 1 do
    begin
      if Common.IsErName(SL[I]) or Common.IsErChar(SL[I]) then
        Continue;
      Common.AddTVItem(TVR, SL[I], 3, 4);
      QCProjFileList.Append(Ini.ReadString(SL[I], 'value', ''));
    end;
    // Предметы
    S := Ini.ReadString('items', 'value', '');
    V := S.Split([TkDiv]);
    for I := 0 to High(V) do
    begin
      N := V[I].Trim;
      if (N <> '') then
        Common.AddTVItem(TVI, N, 1, 1);
    end;
    // Переменные
    S := Ini.ReadString('variables', 'value', '');
    V := S.Split([TkDiv]);
    for I := 0 to High(V) do
    begin
      N := Trim(V[I]);
      if (N <> '') then
        Common.AddTVItem(TVV, N, 2, 2);
    end;
  finally
    Ini.Free;
  end;
  Modified := False;
end;

procedure TfMain.acOpenProjectExecute(Sender: TObject);
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
    LoadProject(OD.FileName);
  end;
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
  RoomName, Line, D, M, U: string;
  I, P, V: Integer;
  F, H: Boolean;

  procedure Add(S: string);
  begin
    V := SynEdit1.Lines.Add(S);
  end;

  procedure AddCom();
  begin
    Add(';Игра создана на конструкторе URQConstruct');
    Add(';https://github.com/');
    Add(';' + DateToStr(Date) + '-' + TimeToStr(Time));
    Add('');
  end;

begin
  // Экспорт
  with SynEdit1 do
  begin
    if mmExport.Visible then
    begin
      mmExport.Visible := False;
      Exit;
    end;
    Clear;
    Modified := True;
    AddCom();
    for I := 0 to TVR.Items.Count - 1 do
    begin
      RoomName := TVR.Items[I].Text.ToLower;
      if (I > 0) and (RoomName <> RoomsName) then
      begin
        Add(':' + RoomName);
        //
        H := False;
        M := '';
        Line := Trim(Self.QCProjFileList[I - 1]);

        // Разбор строки Line
        while (Line <> '') do
        begin
          F := Line[1] = '1';
          Delete(Line, 1, 1);
          P := Pos(TkDiv, Line);
          D := '';
          if (P <= 0) then
          begin
            if F then
              D := Trim(Copy(Line, 1, Length(Line)));
            Line := '';
          end
          else
          begin
            if F then
              D := Trim(Copy(Line, 1, P - 1));
            Delete(Line, 1, P);
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
  FExported := True;
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
  Utils.ShowForm(fSettings);
end;

procedure TfMain.acSaveQSTExecute(Sender: TObject);
begin
  if (Trim(FFileName) = '') then
    Exit;
  SynEdit1.Lines.SaveToFile(Utils.GetPath('quests') + ChangeFileExt(ExtractFileName(FFileName), '.qst'));
  Common.MsgDlg('Квест сохранен в папке "Quests"!', mtInformation, [mbOk]);
  SynEdit1.Modified := False;
end;

procedure TfMain.acSaveQSTUpdate(Sender: TObject);
begin
  acSaveQST.Enabled := (FFileName <> '') and SynEdit1.Modified;
end;

procedure TfMain.acRunExecute(Sender: TObject);
var
  FileName, IntURQPath: string;
begin
  // Run
  if (Trim(FFileName) = '') then
    Exit;
  if not FExported then
    acExportToQSTExecute(Sender);
  FileName := Utils.GetPath('quests') + ChangeFileExt(ExtractFileName(FFileName), '.qst');
  SynEdit1.Lines.SaveToFile(FileName);
  IntURQPath := Trim(fSettings.edSelURQ.Text);
  if (IntURQPath = '') or not FileExists(IntURQPath) then
    Exit;
  // S := 'C:\Windows\Notepad.exe';
  // ShowMessage(F + ' ' + S);
  ShellExecute(Application.Handle, 'open', PWideChar(IntURQPath), PWideChar(FileName), nil, SW_SHOWNORMAL);
end;

procedure TfMain.acRunUpdate(Sender: TObject);
var
  IntURQPath: string;
begin
  IntURQPath := Trim(fSettings.edSelURQ.Text);
  acRun.Enabled := (FFileName <> '') and FExported and not FModified and (IntURQPath <> '') and FileExists(IntURQPath)
end;

end.
