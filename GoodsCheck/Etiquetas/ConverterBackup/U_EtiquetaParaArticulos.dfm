object FormEtiPEs: TFormEtiPEs
  Left = 0
  Top = 0
  Caption = #36135#21697#30340#26631#31614#25171#21360
  ClientHeight = 661
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 41
    Align = alTop
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 1008
    Height = 428
    Align = alClient
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 848
      Height = 426
      Align = alLeft
      DataSource = UniDataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawDataCell = DBGrid1DrawDataCell
      Columns = <
        item
          Expanded = False
          FieldName = 'ENA'
          Title.Caption = #26465#30721'(ENA)'
          Width = 128
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GOODS_NAME'
          Title.Caption = #21830#21697#21517#31216'(Concepcion)'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BRAND_NAME'
          Title.Caption = #21697#29260'(Marca)'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Scalar'
          Title.Caption = #26631#37327'(Medida,Pesos)'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UNIT'
          Title.Caption = #21333#20301'(QUANTIFIER)'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FECHA_FABRICA'
          Title.Caption = #29983#20135#26085#26399'(Fecha Fb.)'
          Width = 128
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PVP'
          Title.Caption = #38144#21806#20215#26684'(PVP)'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CANTIDAD'
          Title.Caption = #20221#25968
          Width = 30
          Visible = True
        end>
    end
    object Button4: TButton
      Left = 872
      Top = 168
      Width = 75
      Height = 25
      Caption = #21024#38500#21333#26465
      TabOrder = 1
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 872
      Top = 208
      Width = 75
      Height = 25
      Caption = #28165#31354#25968#25454
      TabOrder = 2
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 872
      Top = 248
      Width = 75
      Height = 25
      Caption = #21047#26032#25968#25454
      TabOrder = 3
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 872
      Top = 304
      Width = 75
      Height = 73
      Caption = #25171#21360
      TabOrder = 4
      OnClick = Button7Click
    end
    object Button3: TButton
      Left = 872
      Top = 80
      Width = 75
      Height = 73
      Caption = #20445#23384#20462#25913
      TabOrder = 5
      OnClick = Button3Click
    end
    object DBNavigator1: TDBNavigator
      Left = 831
      Top = 17
      Width = 200
      Height = 25
      DataSource = UniDataSource1
      TabOrder = 6
      Visible = False
    end
    object Button8: TButton
      Left = 872
      Top = 49
      Width = 75
      Height = 25
      Caption = #37325#26032#35835#21462
      TabOrder = 7
      OnClick = Button8Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 469
    Width = 1008
    Height = 192
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 280
      Top = 16
      Width = 52
      Height = 13
      Caption = #26465#30721'(ENA)'
    end
    object Label2: TLabel
      Left = 504
      Top = 16
      Width = 111
      Height = 13
      Caption = #21830#21697#21517#31216'(Concepcion)'
    end
    object Label3: TLabel
      Left = 280
      Top = 62
      Width = 117
      Height = 13
      Caption = #21697#29260'(Marca de Ariticulo)'
    end
    object Label4: TLabel
      Left = 448
      Top = 64
      Width = 98
      Height = 13
      Caption = #26631#37327'(Medida,Pesos)'
    end
    object Label5: TLabel
      Left = 600
      Top = 64
      Width = 94
      Height = 13
      Caption = #21333#20301'(cuantificador)'
    end
    object Label6: TLabel
      Left = 280
      Top = 107
      Width = 138
      Height = 13
      Caption = #29983#20135#26085#26399'(Fecha de Fabrica)'
    end
    object Label7: TLabel
      Left = 448
      Top = 107
      Width = 74
      Height = 13
      Caption = #38144#21806#20215#26684'(PVP)'
    end
    object Label8: TLabel
      Left = 552
      Top = 107
      Width = 75
      Height = 13
      Caption = #20221#25968'(Cantidad)'
    end
    object Button1: TButton
      Left = 904
      Top = 80
      Width = 75
      Height = 73
      Caption = #36864#20986
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 290
      Top = 35
      Width = 144
      Height = 21
      MaxLength = 24
      TabOrder = 1
      OnExit = Edit1Exit
      OnKeyDown = Edit1KeyDown
    end
    object Edit2: TEdit
      Left = 504
      Top = 37
      Width = 321
      Height = 21
      MaxLength = 120
      TabOrder = 2
      OnKeyDown = Edit2KeyDown
    end
    object Edit3: TEdit
      Left = 290
      Top = 80
      Width = 144
      Height = 21
      MaxLength = 40
      TabOrder = 3
      OnKeyDown = Edit3KeyDown
    end
    object Edit4: TEdit
      Left = 455
      Top = 80
      Width = 121
      Height = 21
      MaxLength = 20
      TabOrder = 4
      OnKeyDown = Edit4KeyDown
    end
    object Edit5: TEdit
      Left = 603
      Top = 80
      Width = 54
      Height = 21
      MaxLength = 5
      TabOrder = 5
      OnKeyDown = Edit5KeyDown
    end
    object Edit6: TEdit
      Left = 290
      Top = 126
      Width = 121
      Height = 21
      MaxLength = 24
      TabOrder = 6
      OnKeyDown = Edit6KeyDown
    end
    object PvP: TCurrencyEdit
      Left = 448
      Top = 126
      Width = 81
      Height = 21
      Margins.Left = 4
      Margins.Top = 1
      Color = clInfoBk
      DecimalPlaces = 4
      DisplayFormat = '0.0000;-0.0000'
      TabOrder = 7
      OnKeyDown = PvPKeyDown
    end
    object CurrencyEdit2: TCurrencyEdit
      Left = 555
      Top = 126
      Width = 75
      Height = 21
      Margins.Left = 4
      Margins.Top = 1
      DecimalPlaces = 0
      DisplayFormat = '0;-0'
      MaxLength = 3
      TabOrder = 8
      Value = 1.000000000000000000
      OnKeyDown = CurrencyEdit2KeyDown
    end
    object Button2: TButton
      Left = 750
      Top = 80
      Width = 75
      Height = 73
      Caption = #22686#21152
      TabOrder = 9
      OnClick = Button2Click
    end
    object DBImage1: TDBImage
      Left = 1
      Top = 1
      Width = 273
      Height = 190
      Align = alLeft
      ReadOnly = True
      Stretch = True
      TabOrder = 10
    end
    object CheckBox1: TCheckBox
      Left = 882
      Top = 16
      Width = 97
      Height = 17
      Caption = #24555#36895#36755#20837
      TabOrder = 11
    end
  end
  object UniDataSource1: TUniDataSource
    Left = 904
    Top = 305
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSource = DataSourceStudies
    BCDToCurrency = False
    Left = 280
    Top = 392
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 208
    Top = 392
  end
  object frxReport1: TfrxReport
    Version = '6.3.7'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #39044#35774
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 41399.958604166700000000
    ReportOptions.LastChange = 41399.958604166700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 144
    Top = 392
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Columns = 4
      ColumnWidth = 47.500000000000000000
      ColumnPositions.Strings = (
        '0'
        '47.50'
        '95'
        '142.50')
      Frame.Typ = []
      MirrorMode = []
      object BarCode1: TfrxBarCodeView
        AllowVectorExport = True
        Left = 41.574830000000000000
        Top = 37.795300000000000000
        Width = 103.000000000000000000
        Height = 45.354360000000000000
        BarType = bcCodeEAN13
        Frame.Typ = []
        Rotation = 0
        TestLine = False
        Text = '12345678'
        WideBarRatio = 2.000000000000000000
        Zoom = 1.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
    end
  end
  object DataSourceStudies: TDataSource
    Left = 488
    Top = 272
  end
end
