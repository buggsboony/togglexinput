unit togglexinputU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, StdCtrls,
  process, regExpr;

type

  { TForm1 }

  TForm1 = class(TForm)
    btn_float: TButton;
    btn_reattach: TButton;
    ed_master: TEdit;
    ed_id: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    procedure btn_floatClick(Sender: TObject);
    procedure btn_reattachClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
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

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin

   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;


function extractMaster(S:ansistring):Ansistring;
var
 smaster:ansistring;

begin
   {Beetween string }
     smaster:= Copy(S,Pos('(',S)+1,Pos(')',S)-Pos('(',S)-1);
   result:= (smaster);
end;


procedure xinputFloat(id:integer);
var s,xinput:ansistring;
begin
    xinput:='/usr/bin/xinput';
         if RunCommand(xinput,['float', IntToStr(id)],s) then
         begin
              //ShowMessage('Device disabled');
         end else
         begin
           showMessage('Oups Runcommand failed : '+xinput);
         end;
end;



procedure xinputAttach(id,master:integer; form1:Tform1);
var s,xinput,time, sid,smaster, newline:ansistring;
begin
    xinput:='/usr/bin/xinput';
    sid:=IntToStr(id);
    smaster:=IntToStr(master);

         if RunCommand(xinput,['reattach', sid , smaster],s) then
         begin
              //ShowMessage('Device reattached');
           DateTimeToString(time, 'c', now);
           newLine:=('reattach id='''+sid+''' to master='''+smaster+'''    '+time);
           form1.Memo1.Text :=newLine +#13#10+form1.Memo1.Text;
         end else
         begin
           showMessage('Oups Runcommand failed : '+xinput);
         end;
end;




procedure extractDevice(line:Ansistring; form1:TForm1);
var
parts, numberParts:Tstringlist;
i,id,master:integer;
str,strl,strr,sid,smaster, newline:ansistring;
pos:integer;
time :string;
begin
     try

       pos:=line.IndexOf('d=');  //id=
       strr:= copy(line,pos);
       parts:=TStringList.create();
       split(#9,strr, parts);
       sid:=copy(parts[0],3+1);
       smaster:=(parts[1]);
       smaster:= extractMaster(trim(smaster));

       except
       begin
           ShowMessage('Oups, fail parsing : '+line);
       end;

     end;

       //Convert and execute action
     try

       form1.ed_id.text:=sid;
       form1.ed_master.text:=smaster;

       DateTimeToString(time, 'c', now);
       newline:=('Float id='''+sid+''' master='''+smaster+'''    '+time);
       form1.Memo1.Text :=newLine +#13#10+form1.Memo1.Text;
       id:=StrToInt(sid);
         master:=StrToInt(smaster);
         xinputFloat(id);
       except on e:EConvertError do
       begin
         ShowMEssage('Could not convert id '''+sid+''' or master '''+smaster+''' ');
       end;
     end;



end;

procedure TForm1.btn_floatClick(Sender: TObject);
begin
   extractDevice(trim( ListBox1.GetSelectedText ) , form1);
end;

procedure TForm1.btn_reattachClick(Sender: TObject);
begin
  xinputAttach( strToInt(ed_id.Text), StrToInt(ed_master.Text), form1 );
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

end.

