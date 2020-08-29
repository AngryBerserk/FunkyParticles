object Form1: TForm1
  Left = 192
  Top = 114
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 486
  ClientWidth = 775
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnKeyDown = FormKeyDown
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 467
    Width = 775
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'Press `Esc` to toggle Full Screen'
        Width = 200
      end
      item
        Alignment = taCenter
        Text = #174'2006 Angry Berserk production.'
        Width = 50
      end>
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 32
    Top = 32
  end
  object MainMenu1: TMainMenu
    Top = 32
    object File1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = 'New'
        OnClick = New1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
      object Load1: TMenuItem
        Caption = 'Load'
        OnClick = Load1Click
      end
      object Quit1: TMenuItem
        Caption = 'Quit'
        OnClick = Quit1Click
      end
    end
    object Color1: TMenuItem
      Caption = 'Color...'
      OnClick = Color1Click
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.funk'
    Filter = 'Funky Particles files (*.funk)|*.funk|All files|*.*'
    Left = 64
    Top = 32
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.funk'
    FileName = 'Noname.funk'
    Filter = 'Funky Particles files (*.funk)|*.funk|All files|*.*'
    Options = [ofOverwritePrompt, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 96
    Top = 32
  end
  object ColorDialog1: TColorDialog
    Color = clRed
    Options = [cdFullOpen, cdAnyColor]
    Left = 128
    Top = 32
  end
end
