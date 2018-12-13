program URQConstruct;

uses
  Forms,
  uSettings in 'uSettings.pas' {fSettings},
  uMain in 'uMain.pas' {fMain},
  uRoom in 'uRoom.pas' {fRoom},
  uAddRoom in 'uAddRoom.pas' {fAddRoom},
  uSelRoom in 'uSelRoom.pas' {fSelRoom},
  uSelText in 'uSelText.pas' {fSelText},
  uSelVar in 'uSelVar.pas' {fSelVar},
  uSelItem in 'uSelItem.pas' {fSelItem},
  uAddVar in 'uAddVar.pas' {fAddVar},
  uAddItem in 'uAddItem.pas' {fAddItem},
  uCommon in 'uCommon.pas',
  uAbout in 'uAbout.pas' {fAbout},
  uEditText in 'uEditText.pas' {fEditText},
  uUtils in 'uUtils.pas',
  uLanguage in 'uLanguage.pas';

{$R *.RES}

begin
{$IFNDEF FPC}
{$IF COMPILERVERSION >= 18}
  ReportMemoryLeaksOnShutdown := True;
{$IFEND}
{$ENDIF}
  Randomize;
  Application.Initialize;
  Application.Title := 'URQConstruct';
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfAddRoom, fAddRoom);
  Application.CreateForm(TfSelRoom, fSelRoom);
  Application.CreateForm(TfSelText, fSelText);
  Application.CreateForm(TfSelVar, fSelVar);
  Application.CreateForm(TfSelItem, fSelItem);
  Application.CreateForm(TfAddVar, fAddVar);
  Application.CreateForm(TfAddItem, fAddItem);
  Application.CreateForm(TfAbout, fAbout);
  Application.CreateForm(TfSettings, fSettings);
  Application.CreateForm(TfEditText, fEditText);
  Application.Run;
end.
