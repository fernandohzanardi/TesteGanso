object frmConciliacaoBancaria: TfrmConciliacaoBancaria
  Left = 0
  Top = 0
  Caption = 'Concilia'#231#227'o Banc'#225'ria'
  ClientHeight = 520
  ClientWidth = 960
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
    Width = 960
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lConta: TLabel
      Left = 12
      Top = 12
      Width = 90
      Height = 15
      Caption = 'C'#243'd. Conta Banc.:'
    end
    object lPeriodo: TLabel
      Left = 220
      Top = 12
      Width = 44
      Height = 15
      Caption = 'Per'#237'odo:'
    end
    object lAte: TLabel
      Left = 420
      Top = 12
      Width = 16
      Height = 15
      Caption = 'at'#233
    end
    object eCodigoConta: TEdit
      Left = 110
      Top = 8
      Width = 80
      Height = 23
      NumbersOnly = True
      TabOrder = 0
    end
    object dtpDataInicial: TDateTimePicker
      Left = 270
      Top = 8
      Width = 140
      Height = 23
      Date = 45444.000000000000000000
      Time = 45444.000000000000000000
      TabOrder = 1
    end
    object dtpDataFinal: TDateTimePicker
      Left = 444
      Top = 8
      Width = 140
      Height = 23
      Date = 45444.000000000000000000
      Time = 45444.000000000000000000
      TabOrder = 2
    end
    object btnConsultar: TButton
      Left = 620
      Top = 6
      Width = 120
      Height = 28
      Caption = 'Consultar (F5)'
      Default = True
      TabOrder = 3
      OnClick = btnConsultarClick
    end
  end
  object pSplit: TPanel
    Left = 0
    Top = 70
    Width = 960
    Height = 360
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lExtrato: TLabel
      Left = 12
      Top = 4
      Width = 200
      Height = 15
      Caption = 'Extrato banc'#225'rio (n'#227'o conciliado)'
    end
    object lMovimentos: TLabel
      Left = 490
      Top = 4
      Width = 220
      Height = 15
      Caption = 'Movimentos de caixa (n'#227'o conciliados)'
    end
    object dbgExtrato: TDBGrid
      Left = 8
      Top = 24
      Width = 460
      Height = 320
      DataSource = dsExtrato
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'd.'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Title.Caption = 'Data'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Title.Caption = 'Valor'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HISTORICO'
          Title.Caption = 'Hist'#243'rico'
          Width = 200
          Visible = True
        end>
    end
    object dbgMovimento: TDBGrid
      Left = 484
      Top = 24
      Width = 460
      Height = 320
      DataSource = dsMovimento
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
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'd.'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Title.Caption = 'Data'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TIPO'
          Title.Caption = 'T'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Title.Caption = 'Valor'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HISTORICO'
          Title.Caption = 'Hist'#243'rico'
          Width = 170
          Visible = True
        end>
    end
  end
  object pRodape: TPanel
    Left = 0
    Top = 430
    Width = 960
    Height = 90
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnImportarCSV: TButton
      Left = 12
      Top = 16
      Width = 120
      Height = 28
      Caption = 'Importar CSV'
      TabOrder = 0
      OnClick = btnImportarCSVClick
    end
    object btnConciliarManual: TButton
      Left = 144
      Top = 16
      Width = 130
      Height = 28
      Caption = 'Conciliar Manual'
      TabOrder = 1
      OnClick = btnConciliarManualClick
    end
    object btnConciliarAuto: TButton
      Left = 286
      Top = 16
      Width = 150
      Height = 28
      Caption = 'Conciliar Automatico'
      TabOrder = 2
      OnClick = btnConciliarAutoClick
    end
    object btnFechar: TButton
      Left = 830
      Top = 16
      Width = 120
      Height = 28
      Caption = 'Fechar'
      TabOrder = 3
      OnClick = btnFecharClick
    end
  end
  object OpenDialogCSV: TOpenDialog
    Left = 400
    Top = 200
  end
  object dsExtrato: TDataSource
    DataSet = ibqExtrato
    Left = 200
    Top = 200
  end
  object dsMovimento: TDataSource
    DataSet = ibqMovimento
    Left = 680
    Top = 200
  end
  object IBTransactionConc: TIBTransaction
    Active = True
    DefaultDatabase = dmConexao.IBDConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 120
    Top = 200
  end
  object ibqExtrato: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionConc
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 280
    Top = 200
    object ibqExtratoCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object ibqExtratoDATA: TDateField
      FieldName = 'DATA'
    end
    object ibqExtratoVALOR: TIBBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object ibqExtratoHISTORICO: TIBStringField
      FieldName = 'HISTORICO'
      Size = 200
    end
  end
  object ibqMovimento: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionConc
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 760
    Top = 200
    object ibqMovimentoCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object ibqMovimentoDATA: TDateField
      FieldName = 'DATA'
    end
    object ibqMovimentoTIPO: TIBStringField
      FieldName = 'TIPO'
      FixedChar = True
      Size = 1
    end
    object ibqMovimentoVALOR: TIBBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object ibqMovimentoHISTORICO: TIBStringField
      FieldName = 'HISTORICO'
      Size = 200
    end
  end
end
