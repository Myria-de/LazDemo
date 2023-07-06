# LazDemo
Beispiele für die Programmierung mit Lazaus/FreePascal

Lazarus/Free Pascal installieren: https://github.com/LongDirtyAnimAlf/fpcupdeluxe/releases

## Entwicklungsumgebung Lazarus einrichten
```
sudo apt install make binutils build-essential gdb subversion zip unzip libx11-dev libgtk2.0-dev libgdk-pixbuf2.0-dev libcairo2-dev libpango1.0-dev git freeglut3-dev
```
## Erste Schritte in Lazarus
```
procedure TForm1.btnStartClick(Sender: TObject);
begin
edtTest.Text:='Hallo Welt';
end;
```
## Das einfache Beispiel erweitern
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
```
var n: Integer;
```

```
If TryStrToInt(edtFaktor1.Text,n) AND TryStrToInt(edtFaktor2.Text,n) 
Then
edtTest.Text:=multiplizieren(edtFaktor1.Text, edtFaktor2.Text)
else
ShowMessage('Sie müssen zwei ganze Zahlen eingeben');
```
## Kommandozeilentools über Lazarus starten
Allgemein: Erfolg:=RunCommand([Kommandozeile],[Ausgabevariable]); 
```
Success:=RunCommand(edtExecutable.Text,RunParams,outp,[poUsePipes,poStderrToOutput]);
```
## Start externer Programme optimieren
Das Beispielprogramm Frontend-Demo-Threads zeigt die Verwendung. Der Programmcode besteht hauptsächlich aus den vier Zeilen
```
Proc := TExternalTool.Create(nil);
Proc.Executable:=edtExecutable.Text;
Proc.CmdLineParams:= edtParameters.Text;
Proc.ExecuteAndWait;
Das Unterprogramm „HandleInfo“ gibt die Meldungen des Programms fortlaufen aus, über die Schaltfläche „Stop“ kann man das externe Tool mit
```
Proc.Terminate;
```
beenden.




