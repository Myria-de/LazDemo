unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, ValEdit, ComCtrls, SynEdit, Strutils, Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnStart: TButton;
    btnStartDemo2: TButton;
    edtExecutable: TEdit;
    edtParameters: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mnuSelectAll: TMenuItem;
    mnuCopy: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    SynEdit1: TSynEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ValueListEditor1: TValueListEditor;
    procedure btnStartClick(Sender: TObject);
    procedure btnStartDemo2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuCopyClick(Sender: TObject);
    procedure mnuSelectAllClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
// Demo1 mit einfachem Eingabefeld
procedure TForm1.btnStartClick(Sender: TObject);
var
  outp  : string;
  RunParams: Array of String;
  Success:Boolean;
begin
  SynEdit1.Clear; // Inhalt der Editor-Komponente löschen
  // Den String edtParameters.Text in ein Array umwandeln
  RunParams:=SplitString(edtParameters.Text, ' ');
  // Externes Programm starten
  Success:=RunCommand(edtExecutable.Text,RunParams,outp,[poUsePipes,poStderrToOutput]);
  // Die Ausgabe von RunCommand in die Editor-Komponente einfügen
  SynEdit1.Text:=outp;
  // Zum Ende der Ausgabe gehen
  SynEdit1.CaretY:=  SynEdit1.Lines.Count;
  // Meldung bei Fehler ausgeben
  If Not Success then SynEdit1.Lines.Add('Es ist ein Fehler aufgetreten.');
  end;
// Demo2 mit einer Liste von Programmen/Parametern
procedure TForm1.btnStartDemo2Click(Sender: TObject);
var
 Key, Value:String;
 RunParams: Array of String;
 Success:Boolean;
 outp:String;
begin
 SynEdit1.Clear; // Inhalt der Editor-Komponente löschen
 //Aktive/markierte Zeile einlesen (das zu startende Programm)
 Key := ValueListEditor1.Keys[ValueListEditor1.Row];
 //Wert zum Key einlesen (Parameter)
 Value := ValueListEditor1.Values[Key];
 // Sting in ein Array einlesen
 RunParams:=SplitString(Value, ' ');
 // Externes Programm starten
 Success:=RunCommand(Key,RunParams,outp,[poUsePipes,poStderrToOutput]);
 // Die Ausgabe von RunCommand in die Editor-Komponente einfügen
 SynEdit1.Text:=outp;
 // Zum Ende der Ausgabe gehen
 SynEdit1.CaretY:=  SynEdit1.Lines.Count;
 // Meldung bei Fehler ausgeben
 If Not Success then SynEdit1.Lines.Add('Es ist ein Fehler aufgetreten.');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //ValueListEditor1 mit Werten füllen
  edtParameters.Text:='-h ' + GetEnvironmentVariable('HOME');
  edtExecutable.Text:='/bin/du';
  ValueListEditor1.clear;
  ValueListEditor1.Strings.Add('/bin/du=-h '+ GetEnvironmentVariable('HOME'));
  ValueListEditor1.Strings.Add('/usr/bin/ls=-l '+ GetEnvironmentVariable('HOME'));
  ValueListEditor1.Strings.Add('/usr/bin/find='+ GetEnvironmentVariable('HOME') + ' -name Downloads');
  ValueListEditor1.Strings.Add('/usr/bin/apt=search samba');
end;

procedure TForm1.mnuCopyClick(Sender: TObject);
begin
 //Kontextmenü "Kopieren"
 SynEdit1.CopyToClipboard;
end;

procedure TForm1.mnuSelectAllClick(Sender: TObject);
begin
  //Kontextmenü "Alles auswählen"
 SynEdit1.SelectAll;
end;
end.

