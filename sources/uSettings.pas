unit uSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfSettings = class(TForm)
    btOK: TBitBtn;
    btCancel: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSettings: TfSettings;

implementation

{$R *.dfm}

end.
