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
    TabSheet2: TTabSheet;
    HotKey1: THotKey;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    HotKey2: THotKey;
    HotKey3: THotKey;
    edInterPath: TEdit;
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
