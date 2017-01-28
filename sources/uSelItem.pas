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

uses uMain, uAddItem, uCommon;

{$R *.dfm}

{ TfEditItem }

procedure TfSelItem.GetItem(var ItemName: string; var Amount: Integer);
begin
  ItemName := '';
  Amount := 1;
  if (FormShowModal(Self) = mrCancel) then Exit;
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
  if (S[1] in ['0'..'9']) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  Self.ModalResult := mrOk;
end;

procedure TfSelItem.FormShow(Sender: TObject);
begin
  edItem.Items.Assign(GetResource(rtItem, ''));
  edItem.SetFocus;
end;

end.
