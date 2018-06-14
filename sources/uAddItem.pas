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
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    SL: TStringList;
  public
    { Public declarations }
    procedure NewItem;
    procedure AddItem(ItemName: string);
  end;

var
  fAddItem: TfAddItem;

implementation

uses uMain, uCommon, uUtils;

{$R *.dfm}

procedure TfAddItem.FormCreate(Sender: TObject);
begin
  SL := TStringList.Create;
end;

procedure TfAddItem.AddItem(ItemName: string);
var
  I: Integer;
begin
  // Добавить предмет
  SL.Assign(Common.GetResource(rtItem, ''));
  for I := 0 to SL.Count - 1 do
    if (SL[I] = ItemName) then
      Exit;
  Common.AddTVItem(fMain.TVI, ItemName, 1, 1);
  fMain.Modified := True;
end;

procedure TfAddItem.FormShow(Sender: TObject);
begin
  cbItemName.SetFocus;
end;

procedure TfAddItem.NewItem;
begin
  cbItemName.Items.Assign(Common.GetResource(rtItem, ''));
  Utils.ShowForm(Self);
end;

procedure TfAddItem.btOKClick(Sender: TObject);
var
  S: string;
  I: Integer;
begin
  SL.Assign(Common.GetResource(rtItem, ''));
  S := LowerCase(Trim(cbItemName.Text));
  if (S = '') then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  for I := 0 to SL.Count - 1 do
    if (S = SL.Strings[I]) then
    begin
      ShowMessage('!!!');
      Exit;
    end;
  if Common.IsErName(S) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  if Common.IsErChar(S) then
  begin
    ShowMessage('!!!');
    Exit;
  end;
  AddItem(S);
  Self.ModalResult := mrOk;
end;

procedure TfAddItem.FormDestroy(Sender: TObject);
begin
  SL.Free;
end;

end.
