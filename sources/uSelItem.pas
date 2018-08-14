unit uSelItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TfSelItem = class(TForm)
    edItem: TComboBox;
    edAmount: TEdit;
    btOK: TBitBtn;
    btCancel: TBitBtn;
    Switch: TRadioGroup;
    UpDn: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    procedure btOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetItem(var ItemName: string; var Amount: Integer);
  end;

var
  fSelItem: TfSelItem;

implementation

uses uMain, uAddItem, uCommon, uUtils;

{$R *.dfm}
{ TfEditItem }

procedure TfSelItem.GetItem(var ItemName: string; var Amount: Integer);
begin
  ItemName := '';
  Amount := 1;
  if (Utils.ShowForm(Self) = mrCancel) then
    Exit;
  ItemName := Trim(edItem.Text);
  Amount := StrToIntDef(edAmount.Text, 1);
  fAddItem.AddItem(ItemName);
end;

procedure TfSelItem.btOKClick(Sender: TObject);
var
  S: string;
begin
  S := Trim(edItem.Text);
  if (S = '') then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  if Common.IsFirstCharDigit(S) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  Self.ModalResult := mrOk;
end;

procedure TfSelItem.FormShow(Sender: TObject);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtItem, '');
    edItem.Items.Assign(SL);
    edItem.SetFocus;
  finally
    FreeAndNil(SL);
  end;
end;

end.
