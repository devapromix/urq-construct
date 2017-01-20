unit uEditItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TfEditItem = class(TForm)
    edItem: TComboBox;
    edAmount: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Switch: TRadioGroup;
    UpDown1: TUpDown;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetItem(var ItemName: string; var Amount: Integer);
  end;

const
  ItemsCategoryName = 'Все предметы';

var
  fEditItem: TfEditItem;

implementation

uses uMain;

{$R *.dfm}

{ TfEditItem }

procedure TfEditItem.GetItem(var ItemName: string; var Amount: Integer);
begin
  ItemName := '';
  Amount := 1;
  if (Self.ShowModal = mrCancel) then Exit;
  ItemName := Trim(edItem.Text);
  Amount := StrToIntDef(edAmount.Text, 1);
  fMain.IL.Append(ItemName);
end;

procedure TfEditItem.BitBtn1Click(Sender: TObject);
var
  S: string;
begin
  S := Trim(edItem.Text);
  if (S = '') or (S[1] in ['0'..'9']) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  Self.ModalResult := mrOk;
end;

procedure TfEditItem.FormShow(Sender: TObject);
begin
  edItem.Items.Assign(fMain.IL);
  edItem.SetFocus;
end;

end.
