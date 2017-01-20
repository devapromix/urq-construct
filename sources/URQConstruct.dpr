program URQConstruct;

uses
  Forms,
  uMain in 'uMain.pas' {fMain},
  uRoom in 'uRoom.pas' {fRoom},
  uAddRoom in 'uAddRoom.pas' {fAddRoom},
  uSelRoom in 'uSelRoom.pas' {fSelRoom},
  uSelText in 'uSelText.pas' {fSelText},
  uSelVar in 'uSelVar.pas' {fSelVar},
  uEditItem in 'uEditItem.pas' {fEditItem};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'URQConstruct';
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfAddRoom, fAddRoom);
  Application.CreateForm(TfSelRoom, fSelRoom);
  Application.CreateForm(TfSelText, fSelText);
  Application.CreateForm(TfSelVar, fSelVar);
  Application.CreateForm(TfEditItem, fEditItem);
  Application.Run;
end.
