unit uSelText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfSelText = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edText: TEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetText(): string;
  end;

var
  fSelText: TfSelText;

implementation

{$R *.dfm}

{ TfSelText }

function TfSelText.GetText: string;
begin
  Result := '';
  if (Self.ShowModal = mrCancel) then Exit;
  Result := Self.edText.Text;
end;

procedure TfSelText.FormShow(Sender: TObject);
begin
  Self.edText.SetFocus;
end;

end.
