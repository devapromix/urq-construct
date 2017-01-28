unit uSelText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfSelText = class(TForm)
    btOK: TBitBtn;
    btCancel: TBitBtn;
    edText: TEdit;
    btClear: TBitBtn;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetText(S: string = ''): string;
  end;

var
  fSelText: TfSelText;

implementation

uses uCommon;

{$R *.dfm}

{ TfSelText }

function TfSelText.GetText(S: string = ''): string;
begin
  Result := '';
  S := Trim(S);
  if (S <> '') then Self.edText.Text := S;
  if (FormShowModal(Self) = mrCancel) then Exit;
  Result := Self.edText.Text;
end;

procedure TfSelText.FormShow(Sender: TObject);
begin
  Self.edText.SelectAll;
  Self.edText.SetFocus;
end;

procedure TfSelText.btClearClick(Sender: TObject);
begin
  Self.edText.Text := '';
  Self.edText.SetFocus;
end;

end.
