# LazDemo
Beispiele für die Programmierung mit Lazaus/FreePascal

**Infos:**
Lazarus: www.lazarus-ide.org

Free Pascal (FPC): www.freepascal.org

Lazarus/Free Pascal installieren: https://github.com/LongDirtyAnimAlf/fpcupdeluxe/releases

**Bitte beachten Sie:** Während der Entwicklung ist in Lazarus der Debugger aktiv. Es lassen sich Haltepunkte setzen und Variablen prüfen. Ist die Entwicklung abgeschlossen, gehen Sie auf "Projekt -> Projekteinstellungen" und dann unter "Compilereinstellungen" auf "Debugger". Entfernen Sie das Häkchen vor "Generate info for the debugger". Erstellen Sie das Programm über "Start -> Neu kompilieren" neu. Die Größe der ausführbaren Datei wird dadurch deutlich reduziert.

## Entwicklungsumgebung Lazarus einrichten
Nötige Pakete für die Entwicklungsumgebung installieren:
```
sudo apt install make binutils build-essential gdb subversion zip unzip libx11-dev libgtk2.0-dev libgdk-pixbuf2.0-dev libcairo2-dev libpango1.0-dev git freeglut3-dev
```
Dann Lazarus/Free Pascal mit fpcupdeluxe installieren.
## Erste Schritte in Lazarus
Siehe Projekt im Ordner "HelloWorld"
```
procedure TForm1.btnStartClick(Sender: TObject);
begin
edtTest.Text:='Hallo Welt';
end;
```
## Das einfache Beispiel erweitern
Siehe Projekt im Ordner "HelloWorld"
```
edtTest.Text:=multiplizieren(edtFaktor1.Text, edtFaktor2.Text);
```

```
function multiplizieren (A,B:String):String;
begin
Result:= IntToStr(StrToInt(A) * StrToInt(B));
end;
```
**Benutzerfehler vermeiden:**
Siehe Projekt im Ordner "HelloWorld"
```
procedure TForm1.btnBerechnenClick(Sender: TObject);
// Variablen deklarieren
var n: Integer;
begin      
var n: Integer;
[...]
```
Eingaben prüfen:
```
If TryStrToInt(edtFaktor1.Text,n) AND TryStrToInt(edtFaktor2.Text,n) 
Then
edtTest.Text:=multiplizieren(edtFaktor1.Text, edtFaktor2.Text)
else
ShowMessage('Sie müssen zwei ganze Zahlen eingeben');
```
## Kommandozeilentools über Lazarus starten
Siehe Projekt im Ordner "Frontend-Demo"

Allgemein: Erfolg:=RunCommand([Kommandozeile],[Ausgabevariable]); 
```
Success:=RunCommand(edtExecutable.Text,RunParams,outp,[poUsePipes,poStderrToOutput]);
```
## Start externer Programme optimieren
Siehe Projekt im Ordner "Frontend-Demo-Thread"

Das Beispielprogramm Frontend-Demo-Threads zeigt die Verwendung. Der Programmcode besteht hauptsächlich aus den vier Zeilen
```
Proc := TExternalTool.Create(nil);
Proc.Executable:=edtExecutable.Text;
Proc.CmdLineParams:= edtParameters.Text;
Proc.ExecuteAndWait;
```
Das Unterprogramm „HandleInfo“ gibt die Meldungen des Programms fortlaufen aus, über die Schaltfläche „Stop“ kann man das externe Tool mit
```
Proc.Terminate;
```
beenden.
