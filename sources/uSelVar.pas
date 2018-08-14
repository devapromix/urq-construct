unit uSelVar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfSelVar = class(TForm)
    edVar: TComboBox;
    edValue: TEdit;
    btOK: TBitBtn;
    btCancel: TBitBtn;
    VarType: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetVar(var VarName, Value: string);
  end;

var
  fSelVar: TfSelVar;

implementation

uses uMain, uAddVar, uCommon, uUtils;

{$R *.dfm}
{ TfSelVar }

procedure TfSelVar.GetVar(var VarName, Value: string);
begin
  VarName := '';
  Value := '';
  if (Utils.ShowForm(Self) = mrCancel) then
    Exit;
  VarName := Trim(edVar.Text);
  Value := Trim(edValue.Text);
  fAddVar.AddVar(VarName);
end;

procedure TfSelVar.FormShow(Sender: TObject);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtVar, '');
    edVar.Items.Assign(SL);
    edVar.SetFocus;
  finally
    FreeAndNil(SL);
  end;
end;

procedure TfSelVar.btOKClick(Sender: TObject);
var
  S: string;
begin
  S := Trim(edVar.Text);
  if Common.IsFirstCharDigit(S) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  Self.ModalResult := mrOk;
end;

end.
