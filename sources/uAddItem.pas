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

uses uMain, uCommon, uUtils;

{$R *.dfm}

procedure TfAddItem.AddItem(ItemName: string);
var
  I: Integer;
  SL: TStringList;
begin
  // Добавить предмет
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtItem, '');
    for I := 0 to SL.Count - 1 do
      if (SL[I] = ItemName) then
        Exit;
    Common.AddTVItem(fMain.TVI, ItemName, 1, 1);
    fMain.Modified := True;
  finally
    FreeAndNil(SL);
  end;
end;

procedure TfAddItem.FormShow(Sender: TObject);
begin
  cbItemName.SetFocus;
end;

procedure TfAddItem.NewItem;
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtItem, '');
    cbItemName.Items.Assign(SL);
    Utils.ShowForm(Self);
  finally
    FreeAndNil(SL);
  end;
end;

procedure TfAddItem.btOKClick(Sender: TObject);
var
  S: string;
  I: Integer;
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtItem, '');
    S := cbItemName.Text.ToLower.Trim;
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
  finally
    FreeAndNil(SL);
  end;
end;

end.
