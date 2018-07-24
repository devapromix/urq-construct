unit uSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfSettings = class(TForm)
    btOK: TBitBtn;
    btCancel: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label4: TLabel;
    btSelURQ: TSpeedButton;
    edSelURQ: TEdit;
    OpenDialog: TOpenDialog;
    procedure btSelURQClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSettings: TfSettings;

implementation

{$R *.dfm}

uses uCommon;

procedure TfSettings.btSelURQClick(Sender: TObject);
begin
  // Выбор интерпретатора для запуска квестов
  OpenDialog.Filter := stURQIntFilters;
  if OpenDialog.Execute then
    edSelURQ.Text := Trim(OpenDialog.FileName);
end;

end.
