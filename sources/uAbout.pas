unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Vcl.ExtCtrls;

type
  TfAbout = class(TForm)
    btOK: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAbout: TfAbout;

const
  URLGithub = 'https://github.com/devapromix-ifiction/urq-construct';

implementation

uses uCommon;

{$R *.dfm}

procedure TfAbout.FormShow(Sender: TObject);
begin
  Label1.Caption := Application.Title;
  Label2.Caption := 'Конструктор текстовых квестов';
  Label3.Caption := URLGithub;
  Label4.Caption := Format('v. %s (C) 2017-2018 by Apromix <bees@meta.ua>', [Version]);
end;

procedure TfAbout.Label3Click(Sender: TObject);
begin
  // Открыть страницу проекта на github'е
end;

end.
