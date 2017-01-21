unit uAddVar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfAddVar = class(TForm)
    cbVarName: TComboBox;
    btOK: TBitBtn;
    btCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NewVar;
    procedure AddVar(VarName: string);
  end;

var
  fAddVar: TfAddVar;

implementation

uses uMain;

{$R *.dfm}

procedure TfAddVar.NewVar;
begin
  // Добавить новую переменную
  ShowModal;
end;

procedure TfAddVar.FormShow(Sender: TObject);
begin
  cbVarName.SetFocus;
end;

procedure TfAddVar.btOKClick(Sender: TObject);
var
  NewVarName: string;
  I: Integer;
  S: TStringList;
begin
  NewVarName := LowerCase(Trim(cbVarName.Text));
  S := TStringList.Create;
  S.Assign(fMain.GetVars(''));
  for I := 0 to S.Count - 1 do
    if (NewVarName = '') or (NewVarName = S.Strings[I]) then
    begin
      ShowMessage('!!!');
      Exit;
    end;
  AddVar(NewVarName);
  S.Free;                      
  Self.ModalResult := mrOk;
end;

procedure TfAddVar.AddVar(VarName: string);
var
  I: Integer;
  F: TTreeNode;
  S: TStringList;
begin
  S := TStringList.Create;
  S.Assign(fMain.GetVars(''));
  for I := 0 to S.Count - 1 do
    if (S[I] = VarName) then Exit;
  F := fMain.TVV.Items.Item[0];
  fMain.TVV.Items.AddChild(F, VarName);
end;

end.
