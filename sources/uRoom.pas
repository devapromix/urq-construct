unit uRoom;

interface

uses Windows, Classes, Dialogs, Graphics, Forms, Controls, StdCtrls, CheckLst,
  ComCtrls, ToolWin, ImgList, Menus, ActnList, System.Actions, System.ImageList;

type
  TfRoom = class(TForm)
    Memo1: TMemo;
    CLB: TCheckListBox;
    ToolBar1: TToolBar;
    btGoto: TToolButton;
    btProc: TToolButton;
    btCLS: TToolButton;
    btClose: TToolButton;
    ToolButton4: TToolButton;
    btCLSB: TToolButton;
    ToolButton6: TToolButton;
    btPrint: TToolButton;
    btPrintLine: TToolButton;
    ToolButton9: TToolButton;
    btButton: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton14: TToolButton;
    ButsImages: TImageList;
    PM: TPopupMenu;
    ActionList1: TActionList;
    acDelete: TAction;
    N1: TMenuItem;
    btInvKill: TToolButton;
    btPerKill: TToolButton;
    acGoto: TAction;
    acProc: TAction;
    acCLS: TAction;
    acCLSB: TAction;
    acInvKill: TAction;
    acPerKill: TAction;
    acBtn: TAction;
    acText: TAction;
    acTextLine: TAction;
    acClear: TAction;
    N2: TMenuItem;
    N3: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    acExpression: TAction;
    acStartBlock: TAction;
    acFinishBlock: TAction;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    acEditVar: TAction;
    N4: TMenuItem;
    N5: TMenuItem;
    acPrintLn1: TMenuItem;
    acPrint1: TMenuItem;
    acEditItem: TAction;
    acClose: TAction;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    acExpression1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    acEnd: TAction;
    ToolButton1: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    acMoveUp: TAction;
    acMoveDown: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acDeleteUpdate(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure CLBDblClick(Sender: TObject);
    procedure acOpGrAExecute(Sender: TObject);
    procedure acOpGrBExecute(Sender: TObject);
    procedure acOpGrCExecute(Sender: TObject);
    procedure acOpGrDExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CLBClickCheck(Sender: TObject);
    procedure acClearExecute(Sender: TObject);
    procedure acClearUpdate(Sender: TObject);
    procedure acOpGrEExecute(Sender: TObject);
    procedure acEditVarExecute(Sender: TObject);
    procedure acEditItemExecute(Sender: TObject);
    procedure acCloseExecute(Sender: TObject);
    procedure acMoveDownUpdate(Sender: TObject);
    procedure acMoveUpUpdate(Sender: TObject);
    procedure acMoveUpExecute(Sender: TObject);
    procedure acMoveDownExecute(Sender: TObject);
  private
    { Private declarations }
    FCurrent: Integer;
    V: (T1, T2, T3);
    FAutoInsertStartBlock: Boolean;
    procedure AddOpGrA(const N: Integer);
    procedure AddOpGrB(const N: Integer; I: Integer = -1; P: string = '');
    procedure AddOpGrC(const N: Integer; I: Integer = -1; P: string = '';
      E: string = '');
    procedure AddOpGrD(const N: Integer; I: Integer = -1; P: string = '');
    procedure AddOpGrE(const N: Integer; I: Integer = -1; P: string = '');
    procedure AddVar(I: Integer = -1);
    procedure AddItem(I: Integer = -1);
  public
    { Public declarations }
    procedure LoadCLB(const Index: Integer);
    procedure SaveCLB(const Index: Integer);
    property Current: Integer read FCurrent write FCurrent;
  end;

const
  // Операторы по группам
  OpGrA: array [0 .. 6] of string = ('cls', 'clsb', 'invkill', 'perkill',
    'startblock', 'finishblock', 'end');
  OpGrB: array [0 .. 1] of string = ('goto', 'proc');
  OpGrC: array [0 .. 0] of string = ('btn');
  OpGrD: array [0 .. 1] of string = ('pln', 'p');
  OpGrE: array [0 .. 0] of string = ('if');

implementation

uses SysUtils, Math, uMain, uSelRoom, uSelText, uSelVar, uSelItem, uCommon;

{$R *.dfm}

procedure TfRoom.LoadCLB(const Index: Integer);
var
  I: Integer;
  S: string;
  B: Char;
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL := Common.ExplodeString('|', fMain.QL[Index]);
    CLB.Clear;
    for I := 0 to SL.Count - 1 do
    begin
      S := Trim(SL[I]);
      B := S[1];
      Delete(S, 1, 1);
      CLB.Items.Append(S);
      CLB.Checked[I] := (B = '1');
    end;
    if CLB.Items.Count > 0 then
      CLB.ItemIndex := 0;
  finally
    FreeAndNil(SL);
  end;
end;

procedure TfRoom.SaveCLB(const Index: Integer);
var
  S, D: string;
  I: Integer;
  C: Char;
begin
  S := '';
  for I := 0 to CLB.Count - 1 do
  begin
    D := Common.IfThen((I <> CLB.Count - 1), '|', '');
    C := Common.IfThen(CLB.Checked[I], '1', '0');
    S := S + C + CLB.Items.Strings[I] + D;
  end;
  with fMain do
  begin
    QL[Index] := S;
    Modified := True;
  end;
end;

procedure TfRoom.AddOpGrA(const N: Integer);
begin
  // Операторы без параметров
  CLB.Checked[CLB.Items.Add(OpGrA[N])] := True;
  SaveCLB(Current);
end;

procedure TfRoom.AddOpGrB(const N: Integer; I: Integer = -1; P: string = '');
var
  S, Op: string;
begin
  // Операторы, у которых параметр - метка комнаты
  Op := OpGrB[N];
  S := fSelRoom.GetRoom(Self.Caption, P);
  if (S = '') then
    Exit;
  S := Format('%s %s', [Op, S]);
  if (I >= 0) then
    CLB.Items[I] := S
  else
    I := CLB.Items.Add(S);
  CLB.Checked[I] := True;
  SaveCLB(Current);
end;

procedure TfRoom.AddOpGrC(const N: Integer; I: Integer = -1; P: string = '';
  E: string = '');
var
  S, T, Op: string;
begin
  // Операторы, осуществляющие переход в комнаты по кнопкам
  Op := OpGrC[N];
  S := fSelRoom.GetRoom(Self.Caption, P);
  if (S = '') then
    Exit;
  T := fSelText.GetText(E);
  if (T = '') then
    Exit;
  S := Format('%s %s, %s', [Op, S, T]);
  if (I >= 0) then
    CLB.Items[I] := S
  else
    I := CLB.Items.Add(S);
  CLB.Checked[I] := True;
  SaveCLB(Current);
end;

procedure TfRoom.AddOpGrD(const N: Integer; I: Integer = -1; P: string = '');
var
  S, Op: string;
begin
  // Операторы вывода текста
  Op := OpGrD[N];
  S := fSelText.GetText(P);
  if (S = '') then
    Exit;
  S := Format('%s %s', [Op, S]);
  if (I >= 0) then
    CLB.Items[I] := S
  else
    I := CLB.Items.Add(S);
  CLB.Checked[I] := True;
  SaveCLB(Current);
end;

procedure TfRoom.AddOpGrE(const N: Integer; I: Integer; P: string);
var
  S, Op: string;
begin
  // Оператор if
  Op := OpGrE[N];
  S := fSelText.GetText(P);
  if (S = '') then
    Exit;
  S := Format('%s %s', [Op, S]);
  if (I >= 0) then
    CLB.Items[I] := S
  else
    I := CLB.Items.Add(S);
  CLB.Checked[I] := True;
  SaveCLB(Current);
  // Автомат. вставить начало блока
  if (Op = 'if') and FAutoInsertStartBlock then
    AddOpGrA(4);
end;

procedure TfRoom.AddVar(I: Integer = -1);
var
  VarName, Value, S: string;
begin
  // Добавить переменную
  fSelVar.GetVar(VarName, Value);
  if (VarName = '') then
    Exit;
  if (fSelVar.VarType.ItemIndex = 0) then
    S := Format('%s = %s', [VarName, Value])
  else
    S := Format('%s = "%s"', [VarName, Value]);
  if (I >= 0) then
    CLB.Items[I] := S
  else
    I := CLB.Items.Add(S);
  CLB.Checked[I] := True;
  SaveCLB(Current);
end;

procedure TfRoom.AddItem(I: Integer = -1);
var
  ItemName, SAmount, S: string;
  Amount: Integer;
begin
  // Добавить или забрать предмет
  SAmount := '';
  fSelItem.GetItem(ItemName, Amount);
  if (ItemName = '') then
    Exit;
  if (Amount <= 0) then
    Amount := 1;
  if (Amount > 1) then
    SAmount := Format('%d, ', [Amount]);
  if (fSelItem.Switch.ItemIndex = 0) then
    S := Format('inv+ %s%s', [SAmount, ItemName])
  else
    S := Format('inv- %s%s', [SAmount, ItemName]);
  if (I >= 0) then
    CLB.Items[I] := S
  else
    I := CLB.Items.Add(S);
  CLB.Checked[I] := True;
  SaveCLB(Current);
end;

procedure TfRoom.acDeleteExecute(Sender: TObject);
begin
  // Попытка удалить команду из списка
  if (CLB.ItemIndex >= 0) and (Common.MsgDlg('Удалить?', mtConfirmation,
    [mbOk, mbCancel]) = mrOk) then
  begin
    CLB.Items.Delete(CLB.ItemIndex);
    SaveCLB(Current);
  end;
end;

procedure TfRoom.acClearExecute(Sender: TObject);
begin
  // Очистить
  if (Common.MsgDlg('Удалить все?', mtConfirmation, [mbOk, mbCancel]) = mrOk)
  then
  begin
    CLB.Clear;
    SaveCLB(Current);
  end;
end;

procedure TfRoom.CLBClickCheck(Sender: TObject);
begin
  Self.SaveCLB(Current);
end;

procedure TfRoom.CLBDblClick(Sender: TObject);
var
  I, J, K, Index: Integer;
  S, T: string;
  SL: TStringList;
begin
  //
  Index := CLB.ItemIndex;
  if (Index < 0) then
    Exit;
  S := Trim(CLB.Items[Index]);
  // Группа B
  for I := 0 to High(OpGrB) do
    if (Copy(S, 1, Length(OpGrB[I])) = OpGrB[I]) then
    begin
      J := Length(OpGrB[I]) + 1;
      AddOpGrB(I, Index, Trim(Copy(S, J, Length(S))));
      Exit;
    end;
  // Группа C
  for I := 0 to High(OpGrC) do
    if (Copy(S, 1, Length(OpGrC[I])) = OpGrC[I]) then
    begin
      J := Length(OpGrC[I]) + 1;
      K := Pos(',', S);
      AddOpGrC(I, Index, Trim(Copy(S, J, K - J)),
        Trim(Copy(S, K + 1, Length(S))));
      Exit;
    end;
  // Группа D
  for I := 0 to High(OpGrD) do
    if (Copy(S, 1, Length(OpGrD[I])) = OpGrD[I]) then
    begin
      J := Length(OpGrD[I]) + 1;
      AddOpGrD(I, Index, Trim(Copy(S, J, Length(S))));
      Exit;
    end;
  // Группа E
  for I := 0 to High(OpGrE) do
    if (Copy(S, 1, Length(OpGrE[I])) = OpGrE[I]) then
    begin
      FAutoInsertStartBlock := False;
      J := Length(OpGrE[I]) + 1;
      AddOpGrE(I, Index, Trim(Copy(S, J, Length(S))));
      Exit;
    end;
  SL := TStringList.Create;
  try
    // Предмет
    T := Copy(S, 1, 4);
    if (T = 'inv+') or (T = 'inv-') then
    begin
      case T[4] of
        '+':
          fSelItem.Switch.ItemIndex := 0;
        '-':
          fSelItem.Switch.ItemIndex := 1;
      end;
      K := 1;
      if (Pos(',', S) > 0) then
      begin
        SL.Clear;
        SL := Common.ExplodeString(',', Trim(Copy(S, 5, Length(S))));
        T := Trim(SL[1]);
        K := StrToIntDef(SL[0], 1);
      end
      else
        T := Trim(Copy(S, 5, Length(S)));
      //
      fSelItem.edItem.Text := T;
      fSelItem.UpDn.Position := K;
      AddItem(Index);
      Exit;
    end;
    // Переменная
    begin
      SL.Clear;
      SL := Common.ExplodeString('=', S);
      fSelVar.VarType.ItemIndex := IfThen((Pos('"', S) > 0), 1, 0);
      S := '';
      if (SL.Count > 1) then
        S := StringReplace(Trim(SL[1]), '"', '', [rfReplaceAll]);
      fSelVar.edVar.Text := Trim(SL[0]);
      fSelVar.edValue.Text := S;
      AddVar(Index);
      Exit;
    end;
  finally
    FreeAndNil(SL);
  end;
end;

procedure TfRoom.FormCreate(Sender: TObject);
begin
  Current := 0;
end;

procedure TfRoom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfRoom.acDeleteUpdate(Sender: TObject);
begin
  acDelete.Enabled := (CLB.Count > 0) and (CLB.ItemIndex >= 0);
end;

procedure TfRoom.acOpGrAExecute(Sender: TObject);
begin
  //
  AddOpGrA((Sender as TAction).Tag);
end;

procedure TfRoom.acOpGrBExecute(Sender: TObject);
begin
  //
  AddOpGrB((Sender as TAction).Tag);
end;

procedure TfRoom.acOpGrCExecute(Sender: TObject);
begin
  //
  AddOpGrC((Sender as TAction).Tag);
end;

procedure TfRoom.acOpGrDExecute(Sender: TObject);
begin
  //
  AddOpGrD((Sender as TAction).Tag);
end;

procedure TfRoom.acOpGrEExecute(Sender: TObject);
begin
  // If
  FAutoInsertStartBlock := True;
  AddOpGrE((Sender as TAction).Tag);
end;

procedure TfRoom.acClearUpdate(Sender: TObject);
begin
  acClear.Enabled := (CLB.Count > 0);
end;

procedure TfRoom.acEditVarExecute(Sender: TObject);
begin
  AddVar();
end;

procedure TfRoom.acMoveDownExecute(Sender: TObject);
var
  Tmp: string;
begin
  // Вниз
  if (CLB.ItemIndex >= 0) then
  begin
    Tmp := CLB.Items[CLB.ItemIndex + 1];
    CLB.Items[CLB.ItemIndex + 1] := CLB.Items[CLB.ItemIndex];
    CLB.Items[CLB.ItemIndex] := Tmp;
    CLB.ItemIndex := CLB.ItemIndex + 1;
    SaveCLB(Current);
  end;
end;

procedure TfRoom.acMoveDownUpdate(Sender: TObject);
begin
  // Вниз
  acMoveDown.Enabled := (CLB.Count > 1) and
    (CLB.ItemIndex < CLB.Items.Count - 1);
end;

procedure TfRoom.acMoveUpExecute(Sender: TObject);
var
  Tmp: string;
begin
  // Вверх
  if (CLB.ItemIndex >= 0) then
  begin
    Tmp := CLB.Items[CLB.ItemIndex - 1];
    CLB.Items[CLB.ItemIndex - 1] := CLB.Items[CLB.ItemIndex];
    CLB.Items[CLB.ItemIndex] := Tmp;
    CLB.ItemIndex := CLB.ItemIndex - 1;
    SaveCLB(Current);
  end;
end;

procedure TfRoom.acMoveUpUpdate(Sender: TObject);
begin
  // Вверх
  acMoveUp.Enabled := (CLB.Count > 1) and (CLB.ItemIndex > 0);
end;

procedure TfRoom.acEditItemExecute(Sender: TObject);
begin
  AddItem();
end;

procedure TfRoom.acCloseExecute(Sender: TObject);
begin
  Close;
end;

end.
