unit dbdec1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, ComCtrls, Windows, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FileNameEdit1Change(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  fn,s,s1,fnclear,bits: string;
  filekeys: TextFile;
const
C_FNAME = '.\keys.txt';


implementation

{$R *.lfm}

{ TForm1 }

procedure ExecuteAndWait(const aCommando: string);
var
  tmpStartupInfo: TStartupInfo;
  tmpProcessInformation: TProcessInformation;
  tmpProgram: String;
begin
  tmpProgram := trim(aCommando);
  FillChar(tmpStartupInfo, SizeOf(tmpStartupInfo), 0);
  with tmpStartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    wShowWindow := SW_HIDE;
  end;

  if CreateProcess(nil, pchar(tmpProgram), nil, nil, true, CREATE_NO_WINDOW,
    nil, nil, tmpStartupInfo, tmpProcessInformation) then
  begin
    // loop every 10 ms
    while WaitForSingleObject(tmpProcessInformation.hProcess, 10) > 0 do
    begin
      Application.ProcessMessages;
    end;
    CloseHandle(tmpProcessInformation.hProcess);
    CloseHandle(tmpProcessInformation.hThread);
  end
  else
  begin
    RaiseLastOSError;
  end;
end;

procedure TForm1.FileNameEdit1Change(Sender: TObject);
begin
   fn:=FileNameEdit1.Filename;
end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  //writeln(s);
end;


procedure TForm1.ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin

end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Progressbar1.Visible:=True;
    ExecuteAndWait('cmd /c .\bin\dbx-key-win-live.py '+fn+'>keys.txt');
     AssignFile(filekeys, C_FNAME);
        Reset(filekeys);
   while not eof(filekeys) do
    begin
      readln(filekeys, s);
     Memo1.Append(s);
    end;
s1:= stringreplace(s, '[KS1]  DBX key:', '',[rfReplaceAll, rfIgnoreCase]);
fnclear:=stringreplace(ExtractFileName (fn), '.dbx', '.db',[rfReplaceAll, rfIgnoreCase]);

//Memo1.Append(s1+' '+fnclear);
if RadioButton1.Checked then bits:='64';
if RadioButton2.Checked then bits:='32';
ExecuteAndWait('cmd /c .\bin\sqlite-dbx-win'+bits+'.exe -key '+s1+' '+fn+' ".backup '+fnclear+'"');
Memo1.Append('sqlite-dbx-win'+bits+'.exe -key '+s1+' '+fn+' ".backup '+fnclear+'"');
Progressbar1.Visible:=False;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 ExecuteAndWait('cmd /c .\sqlitebrowser\sqlitebrowser.exe .\'+fnclear)
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   Application.terminate;
end;




end.

