unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Menus;

type
  TParticle=^TPArt;
  TPart    =record
              x,y:Word;
              ttl:Byte;
              next:TParticle;
              Color:TColor
            End;
  TForm1 = class(TForm)
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Save1: TMenuItem;
    Load1: TMenuItem;
    Quit1: TMenuItem;
    Color1: TMenuItem;
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ColorDialog1: TColorDialog;
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Quit1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Save1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Color1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
  private
    First_Trace_Particle:Pointer;
    Trace_Particles:TParticle;
    PaintColor:TColor;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
 Var Part:TPArticle;R,G,B:Byte;
begin
 If First_Trace_Particle<>nil Then Begin
  Part:=First_Trace_Particle;
  Repeat
   If GetRValue(PArt.Color)<=Part.ttl Then R:=GetRValue(PArt.Color) Else R:=Part.ttl;
   If GetGValue(PArt.Color)<=Part.ttl Then G:=GetGValue(PArt.Color) Else G:=Part.ttl;
   If GetBValue(PArt.Color)<=Part.ttl Then B:=GetBValue(PArt.Color) Else B:=Part.ttl;
   Canvas.Pixels[Part.x,Part.y]:=RGB(R,G,B);
   Part.ttl:=Part.ttl-1;
   If Part.next<>nil then Part:=Part.next
  Until Part.next=nil
 End
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
 Var Part:TParticle;
begin
 If ssLeft in Shift Then
  Begin
   If First_Trace_Particle = nil Then
    Begin
     New(Part);
     Part.x:=X;
     Part.y:=Y;
     Part.ttl:=255;
     Part.Color:=PaintColor;
     Part.next:=nil;
     Trace_Particles:=Part;
     First_Trace_Particle:=Trace_Particles
    End Else
      Begin
       New(Part);
       Part.x:=X;
       Part.y:=Y;
       Part.ttl:=255;
       Part.Color:=PaintColor;
       Part.next:=nil;
       Trace_Particles.next:=Part;
       Trace_Particles:=Trace_Particles.next
      End;
  End
end;

procedure TForm1.Quit1Click(Sender: TObject);
begin
Form1.Close
end;

procedure TForm1.New1Click(Sender: TObject);
begin
First_Trace_Particle:=nil;
Canvas.FillRect(rect(0,0,CLientWidth,ClientHeight));
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If key=VK_ESCAPE Then Begin
  File1.Visible:=not(File1.Visible);
  Color1.Visible:=not(Color1.Visible);
  StatusBar1.Visible:=not(StatusBar1.Visible)
End
end;

procedure TForm1.Save1Click(Sender: TObject);
 Var F:File of TPart;Part:TParticle;PArt2:TPart;
begin
If SaveDialog1.Execute Then
  If First_Trace_Particle<>nil Then Begin
    AssignFile(F,SaveDialog1.FileName);
    Rewrite(F);
    Part:=First_Trace_Particle;
    While Part.next<>nil Do
    Begin
      Part2.x:=Part.x;
      Part2.y:=Part.y;
      Part2.ttl:=Part.ttl;
      Part2.Color:=Part.Color;
      Part2.next:=Part.next;
      Write(F,Part2);
      Part:=Part.next
    End;
    CloseFile(F);
  End
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 PaintColor:=ClRed
end;

procedure TForm1.Color1Click(Sender: TObject);
begin
 If ColorDialog1.Execute Then PaintColor:=ColorDialog1.Color
end;

procedure TForm1.Load1Click(Sender: TObject);
 Var F:File of TPart;Part:TParticle;Part2:TPart;
begin
If OpenDialog1.Execute Then
  Begin

    New(Part);
    AssignFile(F,OpenDialog1.FileName);
    Reset(F);
    Read(F,Part2);

    Part.x:=Part2.x;
    Part.y:=Part2.y;
    Part.ttl:=Part2.ttl;
    Part.Color:=Part2.Color;
    Part.next:=Part2.next;

    Trace_Particles:=Part;
    First_Trace_Particle:=Trace_Particles;
    Repeat
     Read(F,Part2);
     New(Part);
     Part.x:=Part2.x;
     If Part.x>ClientWidth Then Part.x:=Part.x mod ClientWidth;
     Part.y:=Part2.y;
     If Part.x>ClientHeight Then Part.y:=Part.y mod ClientHeight;
     Part.ttl:=Part2.ttl;
     Part.Color:=Part2.Color;
     Part.next:=Part2.next;


     Trace_Particles.next:=Part;
     Trace_Particles:=Trace_Particles.next
    Until(Eof(F));
    CloseFile(F);
    Canvas.FillRect(rect(0,0,CLientWidth,ClientHeight))
  End
end;

end.
