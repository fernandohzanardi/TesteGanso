object frmFluxoCaixa: TfrmFluxoCaixa
  Left = 0
  Top = 0
  Caption = 'Fluxo de Caixa'
  ClientHeight = 480
  ClientWidth = 860
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Position = poDesktopCenter
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object pFiltros: TPanel
    Left = 0
    Top = 0
    Width = 860
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lPreset: TLabel
      Left = 12
      Top = 12
      Width = 40
      Height = 15
      Caption = 'Per'#237'odo:'
    end
    object lPeriodo: TLabel
      Left = 200
      Top = 12
      Width = 14
      Height = 15
      Caption = 'De:'
    end
    object lAte: TLabel
      Left = 400
      Top = 12
      Width = 16
      Height = 15
      Caption = 'at'#233
    end
    object cbPreset: TComboBox
      Left = 60
      Top = 8
      Width = 120
      Height = 23
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbPresetChange
    end
    object dtpDataInicial: TDateTimePicker
      Left = 230
      Top = 8
      Width = 150
      Height = 23
      Date = 45444.000000000000000000
      Time = 45444.000000000000000000
      TabOrder = 1
    end
    object dtpDataFinal: TDateTimePicker
      Left = 430
      Top = 8
      Width = 150
      Height = 23
      Date = 45444.000000000000000000
      Time = 45444.000000000000000000
      TabOrder = 2
    end
    object btnConsultar: TButton
      Left = 600
      Top = 6
      Width = 120
      Height = 28
      Caption = 'Consultar (F5)'
      Default = True
      TabOrder = 3
      OnClick = btnConsultarClick
    end
  end
  object dbgFluxo: TDBGrid
    Left = 0
    Top = 80
    Width = 860
    Height = 300
    Align = alClient
    DataSource = dsFluxo
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA_REF'
        Title.Caption = 'Data'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENTRADAS'
        Title.Caption = 'Entradas'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SAIDAS'
        Title.Caption = 'Sa'#237'das'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDO_DIA'
        Title.Caption = 'Saldo dia'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALDO_ACUM'
        Title.Caption = 'Saldo acum.'
        Width = 120
        Visible = True
      end>
  end
  object pRodape: TPanel
    Left = 0
    Top = 380
    Width = 860
    Height = 100
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object lTotEntradas: TLabel
      Left = 12
      Top = 12
      Width = 55
      Height = 15
      Caption = 'Entradas:'
    end
    object lTotSaidas: TLabel
      Left = 200
      Top = 12
      Width = 40
      Height = 15
      Caption = 'Sa'#237'das:'
    end
    object lTotSaldo: TLabel
      Left = 380
      Top = 12
      Width = 70
      Height = 15
      Caption = 'Saldo per'#237'odo:'
    end
    object lSaldoAcum: TLabel
      Left = 580
      Top = 12
      Width = 80
      Height = 15
      Caption = 'Saldo acum.:'
    end
    object eTotEntradas: TEdit
      Left = 70
      Top = 8
      Width = 110
      Height = 23
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
    object eTotSaidas: TEdit
      Left = 250
      Top = 8
      Width = 110
      Height = 23
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
    end
    object eTotSaldo: TEdit
      Left = 460
      Top = 8
      Width = 100
      Height = 23
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object eSaldoAcum: TEdit
      Left = 670
      Top = 8
      Width = 100
      Height = 23
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
    end
    object btnImprimir: TButton
      Left = 12
      Top = 48
      Width = 120
      Height = 28
      Caption = 'Imprimir'
      TabOrder = 4
      OnClick = btnImprimirClick
    end
    object btnFechar: TButton
      Left = 730
      Top = 48
      Width = 120
      Height = 28
      Caption = 'Fechar'
      TabOrder = 5
      OnClick = btnFecharClick
    end
  end
  object dsFluxo: TDataSource
    DataSet = cdsFluxo
    Left = 520
    Top = 200
  end
  object cdsFluxo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 600
    Top = 200
    object cdsFluxoDATA_REF: TDateField
      FieldName = 'DATA_REF'
    end
    object cdsFluxoENTRADAS: TCurrencyField
      FieldName = 'ENTRADAS'
    end
    object cdsFluxoSAIDAS: TCurrencyField
      FieldName = 'SAIDAS'
    end
    object cdsFluxoSALDO_DIA: TCurrencyField
      FieldName = 'SALDO_DIA'
    end
    object cdsFluxoSALDO_ACUM: TCurrencyField
      FieldName = 'SALDO_ACUM'
    end
  end
  object IBTransactionFluxo: TIBTransaction
    Active = True
    DefaultDatabase = dmConexao.IBDConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 440
    Top = 200
  end
  object ibqFluxo: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionFluxo
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 680
    Top = 200
  end
end
