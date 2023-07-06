unit Unit1;

{$mode objfpc}{$H+}

interface
// Verwendete Units
// Processutils enthält den Code für den Start externer Programm in einem Thread
// Die Anwendung wird während der Ausführung nicht blockiert, das externe Tool
// lässt sich per Klick beenden.
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LMessages, SynEdit, Processutils;

const
  WM_THREADINFO = LM_USER + 2010;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    edtExecutable: TEdit;
    edtParameters: TEdit;
    lblOutput: TLabel;
    CommandOutputScreen: TSynEdit;
    lblOutput1: TLabel;
    lblOutput2: TLabel;
    Proc: TExternalTool;
    procedure btnStopClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
     procedure HandleInfo(var Msg: TLMessage); message WM_THREADINFO;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
// Die Meldungen des externen Tools fortlaufend ausgeben
// Die Meldungen sind in der Variablen "Msg" gespeichert
procedure TForm1.HandleInfo(var Msg: TLMessage);
// Variablen deklarieren
var
  MsgStr: PChar;
  MsgPasStr: string;
begin
  //String formatieren
  MsgStr := {%H-}PChar(Msg.lParam);
  MsgPasStr := StrPas(MsgStr);
  try
    {$if defined(FPC_FULLVERSION) and (FPC_FULLVERSION > 30000)}
    // Text anfügen
    CommandOutputScreen.Append(MsgPasStr);
    {$else}
    CommandOutputScreen.Lines.Append(MsgPasStr);
    {$endif}
    //Ans Ende des Textes gehen
    CommandOutputScreen.CaretX:=0;
    CommandOutputScreen.CaretY:=CommandOutputScreen.Lines.Count;
  finally
    // Aufräumen/Speicher freigeben
    StrDispose(MsgStr);
  end;
end;
// Externes Programm starten
procedure TForm1.btnStartClick(Sender: TObject);
begin
  // Textinhalt von CommandOutputScreen löschen
  CommandOutputScreen.Clear;
  try
   // Komponente TExternalTool aus Processutils initialisieren
   Proc := TExternalTool.Create(nil);
   // Das ausführbare Programm
   Proc.Executable:=edtExecutable.Text;
   // Die Parameter
   Proc.CmdLineParams:=  edtParameters.Text;
   // Starten und warten
   Proc.ExecuteAndWait;
   // Fehler ausgeben
   If proc.ErrorMessage <> '' Then
    CommandOutputScreen.Lines.Append('Fehler: '+  proc.ErrorMessage)
   Else
    // Kein Fehler aufgetreten
    CommandOutputScreen.Lines.Append('*** Fertig ***');
   finally
     // Aufräumen/Speicher freigeben
     Proc.Free;
   end;
end;
// Ausführung abbrechen
procedure TForm1.btnStopClick(Sender: TObject);
begin
  If Assigned(Proc) Then
  Proc.Terminate;
end;

end.

