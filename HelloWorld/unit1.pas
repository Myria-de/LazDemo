unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnStart: TButton;
    btnBerechnen: TButton;
    edtFaktor1: TEdit;
    edtFaktor2: TEdit;
    edtTest: TEdit;
    Label1: TLabel;
    procedure btnBerechnenClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
// Zwei Zahlen multiplizieren
function multiplizieren(A,B:String):String;
begin
try
  Result:= IntToStr(StrToInt(A) * StrToInt(B));
// Alternative/zusätzliche Fehlerbehandlung
// EConvertError tritt auf, wenn kein Integer übergeben wurde
except
  on E: EConvertError do
  ShowMessage('Sie müssen zwei Zahlen eingeben');
end;
end;
// Die "Text"-Eigenschaft von edtTest mit einem String belegen
procedure TForm1.btnStartClick(Sender: TObject);
begin
edtTest.Text:='Hallo Welt';
end;
//Zahlen multiplizieren
procedure TForm1.btnBerechnenClick(Sender: TObject);
// Variablen deklarieren
var n: Integer;
begin
// Eingabe prüfen. Enthält der Text eine Zahl?
If TryStrToInt(edtFaktor1.Text,n) AND TryStrToInt(edtFaktor2.Text,n)
Then
// Ergebnis in die "Text"-Eigenschaft der Komponenten edtTest übertragen
edtTest.Text:=multiplizieren(edtFaktor1.Text, edtFaktor2.Text)
Else
  // Fehlermeldung ausgeben
  ShowMessage('Sie müssen zwei Zahlen eingeben');
end;
end.

