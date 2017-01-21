unit uRoom;

interface

uses Windows, Classes, Dialogs, Graphics, Forms, Controls, StdCtrls, CheckLst,
  ComCtrls, ToolWin, ImgList;

type
  TfRoom = class(TForm)
    Memo1: TMemo;
    CLB: TCheckListBox;
    ToolBar1: TToolBar;
    btAddGoTo: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    btClose: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton1: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ButsImages: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAddGoToClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
  private
    { Private declarations }
    procedure AddSimpleOperator(const AOperator: string);
    procedure AddLocationOperator(const AOperator: string);
    procedure AddLinkOperator(const AOperator: string);
    procedure AddTextOperator(const AOperator: string);
    procedure AddVar;
    procedure AddItem;
  public
    { Public declarations }
    procedure Load(const Index: Integer);
    procedure Save(const Index: Integer);
  end;

const
  RoomDefaultCaption = 'Редактор локации';

implementation

uses SysUtils, uMain, uSelRoom, uSelText, uSelVar, uSelItem;

{$R *.dfm}

procedure TfRoom.FormShow(Sender: TObject);
begin
  Load(Tag);
end;

procedure TfRoom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Save(Tag);
end;

procedure TfRoom.Load(const Index: Integer);
begin
  CLB.Clear;
  
end;

procedure TfRoom.Save(const Index: Integer);
var
  S, D: string;
  I: Integer;
  C: Char;
begin
  S := '';
  for I := 0 to CLB.Count - 1 do
  begin
    D := '|'; if (I = CLB.Count - 1) then D := '';
    C := '0'; if CLB.Checked[I] then C := '1';
    S := S + C + CLB.Items.Strings[I] + D;
  end;
  fMain.QL[Index] := S;
end;

procedure TfRoom.AddSimpleOperator(const AOperator: string);
var
  I: Integer;
begin
  // Операторы без параметров
  I := CLB.Items.Add(AOperator);
  CLB.Checked[I] := True;
end;

procedure TfRoom.AddLocationOperator(const AOperator: string);
var
  S: string;
  I: Integer;
begin
  // Операторы, у которых параметр - метка комнаты
  S := fSelRoom.GetRoom(Self.Caption);
  if (S = '') then Exit;
  I := CLB.Items.Add(Format('%s %s', [AOperator, S]));
  CLB.Checked[I] := True;
end;

procedure TfRoom.AddLinkOperator(const AOperator: string);
var
  S, T: string;
  I: Integer;
begin
  // Операторы, осуществляющие переход в комнаты по кнопкам
  S := fSelRoom.GetRoom(Self.Caption);
  if (S = '') then Exit;
  T := fSelText.GetText();
  if (T = '') then Exit;
  I := CLB.Items.Add(Format('%s %s, %s', [AOperator, S, T]));
  CLB.Checked[I] := True;
end;

procedure TfRoom.AddTextOperator(const AOperator: string);
var
  S: string;
  I: Integer;
begin
  // Операторы вывода текста
  S := fSelText.GetText();
  if (S = '') then Exit;
  I := CLB.Items.Add(Format('%s %s', [AOperator, S]));
  CLB.Checked[I] := True;
end;

procedure TfRoom.AddVar;
var
  VarName, Value: string;
  I: Integer;
begin
  // Добавить переменную
  fSelVar.GetVar(VarName, Value);
  if (VarName = '') then Exit;
  if (fSelVar.VarType.ItemIndex = 0) then
    I := CLB.Items.Add(Format('%s = %s', [VarName, Value]))
      else I := CLB.Items.Add(Format('%s = "%s"', [VarName, Value]));
  CLB.Checked[I] := True;
end;

procedure TfRoom.AddItem;
var
  ItemName, SAmount: string;
  I, Amount: Integer;
begin
  // Добавить или забрать предмет
  SAmount := '';
  fSelItem.GetItem(ItemName, Amount);
  if (ItemName = '') then Exit;
  if (Amount <= 0) then Amount := 1;
  if (Amount > 1) then SAmount := Format('%d, ', [Amount]);
  if (fSelItem.Switch.ItemIndex = 0) then
    I := CLB.Items.Add(Format('inv+ %s%s', [SAmount, ItemName]))
      else I := CLB.Items.Add(Format('inv- %s%s', [SAmount, ItemName]));
  CLB.Checked[I] := True;
end;

procedure TfRoom.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfRoom.btAddGoToClick(Sender: TObject);
begin
  AddLocationOperator('goto');
end;

procedure TfRoom.ToolButton2Click(Sender: TObject);
begin
  AddLocationOperator('proc');
end;

procedure TfRoom.ToolButton3Click(Sender: TObject);
begin
  AddSimpleOperator('cls');
end;

procedure TfRoom.ToolButton5Click(Sender: TObject);
begin
  AddSimpleOperator('clsb');
end;

procedure TfRoom.ToolButton7Click(Sender: TObject);
begin
  AddTextOperator('p');
end;

procedure TfRoom.ToolButton8Click(Sender: TObject);
begin
  AddTextOperator('pln');
end;

procedure TfRoom.ToolButton10Click(Sender: TObject);
begin
  AddLinkOperator('btn');
end;

procedure TfRoom.ToolButton12Click(Sender: TObject);
begin
  AddVar;
end;

procedure TfRoom.ToolButton14Click(Sender: TObject);
begin
  AddItem;
end;

end.
