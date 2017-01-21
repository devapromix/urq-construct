unit uSelVar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfSelVar = class(TForm)
    edVar: TComboBox;
    edValue: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    VarType: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure VarTypeClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetVar(var VarName, Value: string);
  end;

const
  VarsCategoryName = 'Все переменные';

var
  fSelVar: TfSelVar;

implementation

uses uMain, uAddVar;

{$R *.dfm}

{ TfSelVar }

procedure TfSelVar.GetVar(var VarName, Value: string);
begin
  VarName := '';
  Value := '';
  if (Self.ShowModal = mrCancel) then Exit;
  VarName := Trim(edVar.Text);
  Value := Trim(edValue.Text);
  fAddVar.AddVar(VarName);
end;

procedure TfSelVar.FormShow(Sender: TObject);
begin
  edVar.Items.Assign(fMain.GetVars(''));
  edVar.SetFocus;
end;

procedure TfSelVar.VarTypeClick(Sender: TObject);
begin
  if (VarType.ItemIndex = 0) then edValue.Text := '0' else edValue.Text := '';
end;

procedure TfSelVar.BitBtn1Click(Sender: TObject);
var
  S: string;
begin
  S := Trim(edVar.Text);
  if (S = '') or (S[1] in ['0'..'9']) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  Self.ModalResult := mrOk;
end;

end.
