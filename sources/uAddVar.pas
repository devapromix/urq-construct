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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    SL: TStringList;
  public
    { Public declarations }
    procedure NewVar;
    procedure AddVar(VarName: string);
  end;

var
  fAddVar: TfAddVar;

implementation

uses uMain, uCommon;

{$R *.dfm}

procedure TfAddVar.FormCreate(Sender: TObject);
begin
  SL := TStringList.Create;
end;

procedure TfAddVar.NewVar;
begin
  // Добавить новую переменную
  cbVarName.Items.Assign(GetResource(rtVar, ''));
  FormShowModal(Self);
end;

procedure TfAddVar.FormShow(Sender: TObject);
begin
  cbVarName.SetFocus;
end;

procedure TfAddVar.btOKClick(Sender: TObject);
var
  S: string;
  I: Integer;
begin
  // OK
  SL.Assign(GetResource(rtVar, ''));
  S := LowerCase(Trim(cbVarName.Text));
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
  AddVar(S);
  Self.ModalResult := mrOk;
end;

procedure TfAddVar.AddVar(VarName: string);
var
  I: Integer;
begin
  // Добавить переменную
  SL.Assign(GetResource(rtVar, ''));
  for I := 0 to SL.Count - 1 do
    if (SL[I] = VarName) then Exit;
  AddTVItem(fMain.TVV, VarName, 2, 2);
  fMain.Modified := True;
end;

procedure TfAddVar.FormDestroy(Sender: TObject);
begin
  SL.Free;
end;

end.
