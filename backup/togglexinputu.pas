unit togglexinputU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, StdCtrls,
  process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var s,line:AnsiString;
xinput:AnsiString;
i:integer;
    list:TStringList;

begin
         list:= TStringList.Create;
         xinput:='/usr/bin/xinput';
         if RunCommand(xinput,[],s) then
         begin
           list.Text:= s;
                    for i:=0 to list.count-1 do
                     begin
                       line:=list[i];
                             ListBox1.AddItem(line,nil);
                     end;


         end else
         begin
           showMessage('Oups Runcommand failed : '+xinput);
         end;
end;

end.

