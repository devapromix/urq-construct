unit uSelItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TfSelItem = class(TForm)
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
  fSelItem: TfSelItem;

implementation

uses uMain, uAddItem;

{$R *.dfm}

{ TfEditItem }

procedure TfSelItem.GetItem(var ItemName: string; var Amount: Integer);
begin
  ItemName := '';
  Amount := 1;
  if (Self.ShowModal = mrCancel) then Exit;
  ItemName := Trim(edItem.Text);
  Amount := StrToIntDef(edAmount.Text, 1);
  fAddItem.AddItem(ItemName);
end;

procedure TfSelItem.BitBtn1Click(Sender: TObject);
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

procedure TfSelItem.FormShow(Sender: TObject);
begin
  edItem.Items.Assign(fMain.GetItems(''));
  edItem.SetFocus;
end;

end.
