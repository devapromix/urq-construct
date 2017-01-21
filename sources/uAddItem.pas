unit uAddItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfAddItem = class(TForm)
    cbItemName: TComboBox;
    btOK: TBitBtn;
    btCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NewItem;
    procedure AddItem(ItemName: string);
  end;

var
  fAddItem: TfAddItem;

implementation

uses uMain;

{$R *.dfm}

procedure TfAddItem.AddItem(ItemName: string);
var
  I: Integer;
  F: TTreeNode;
  S: TStringList;
begin
  S := TStringList.Create;
  S.Assign(fMain.GetItems(''));
  for I := 0 to S.Count - 1 do
    if (S[I] = ItemName) then Exit;
  F := fMain.TVI.Items.Item[0];
  fMain.TVI.Items.AddChild(F, ItemName);
end;

procedure TfAddItem.FormShow(Sender: TObject);
begin
  cbItemName.SetFocus;
end;

procedure TfAddItem.NewItem;
begin
  ShowModal;
end;

procedure TfAddItem.btOKClick(Sender: TObject);
var
  NewItemName: string;
  I: Integer;
  S: TStringList;
begin
  NewItemName := LowerCase(Trim(cbItemName.Text));
  S := TStringList.Create;
  S.Assign(fMain.GetItems(''));
  for I := 0 to S.Count - 1 do
    if (NewItemName = '') or (NewItemName = S.Strings[I]) then
    begin
      ShowMessage('!!!');
      Exit;
    end;
  AddItem(NewItemName);
  S.Free;
  Self.ModalResult := mrOk;
end;

end.
