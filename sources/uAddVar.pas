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
    Label1: TLabel;
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

uses uMain, uCommon, uUtils;

{$R *.dfm}

procedure TfAddVar.NewVar;
var
  SL: TStringList;
begin
  // Добавить новую переменную
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtVar, '');
    cbVarName.Items.Assign(SL);
    Utils.ShowForm(Self);
  finally
    FreeAndNil(SL);
  end;
end;

procedure TfAddVar.FormShow(Sender: TObject);
begin
  cbVarName.SetFocus;
end;

procedure TfAddVar.btOKClick(Sender: TObject);
var
  S: string;
  I: Integer;
  SL: TStringList;
begin
  // OK
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtVar, '');
    S := cbVarName.Text.ToLower.Trim;
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
    AddVar(S);
    Self.ModalResult := mrOk;
  finally
    FreeAndNil(SL);
  end;
end;

procedure TfAddVar.AddVar(VarName: string);
var
  I: Integer;
  SL: TStringList;
begin
  // Добавить переменную
  SL := TStringList.Create;
  try
    Common.GetResource(SL, rtVar, '');
    for I := 0 to SL.Count - 1 do
      if (SL[I] = VarName) then
        Exit;
    Common.AddTVItem(fMain.TVV, VarName, 2, 2);
    fMain.Modified := True;
  finally
    FreeAndNil(SL);
  end;
end;

end.
