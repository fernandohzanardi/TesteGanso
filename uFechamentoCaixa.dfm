object frmFechamentoCaixa: TfrmFechamentoCaixa
  Left = 0
  Top = 0
  Caption = 'Fechamento de Caixa'
  ClientHeight = 480
  ClientWidth = 780
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
  object pTopo: TPanel
    Left = 0
    Top = 0
    Width = 780
    Height = 100
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lData: TLabel
      Left = 12
      Top = 16
      Width = 28
      Height = 15
      Caption = 'Data:'
    end
    object lSaldoDia: TLabel
      Left = 320
      Top = 16
      Width = 80
      Height = 15
      Caption = 'Saldo do dia:'
    end
    object lObservacao: TLabel
      Left = 12
      Top = 56
      Width = 70
      Height = 15
      Caption = 'Observa'#231#227'o:'
    end
    object dtpData: TDateTimePicker
      Left = 50
      Top = 12
      Width = 150
      Height = 23
      Date = 45444.000000000000000000
      Time = 45444.000000000000000000
      TabOrder = 0
    end
    object btnCalcular: TButton
      Left = 220
      Top = 10
      Width = 90
      Height = 28
      Caption = 'Calcular'
      TabOrder = 1
      OnClick = btnCalcularClick
    end
    object eSaldoDia: TEdit
      Left = 410
      Top = 12
      Width = 120
      Height = 23
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 2
    end
    object eObservacao: TEdit
      Left = 90
      Top = 52
      Width = 560
      Height = 23
      MaxLength = 200
      TabOrder = 3
    end
  end
  object dbgItens: TDBGrid
    Left = 0
    Top = 100
    Width = 780
    Height = 300
    Align = alClient
    DataSource = dsItens
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO_FORMA'
        ReadOnly = True
        Title.Caption = 'C'#243'd.'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        ReadOnly = True
        Title.Caption = 'Forma'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_SISTEMA'
        ReadOnly = True
        Title.Caption = 'Valor sistema'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_INFORMADO'
        Title.Caption = 'Valor informado'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DIFERENCA'
        ReadOnly = True
        Title.Caption = 'Diferen'#231'a'
        Width = 120
        Visible = True
      end>
  end
  object pRodape: TPanel
    Left = 0
    Top = 400
    Width = 780
    Height = 80
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnFecharCaixa: TButton
      Left = 12
      Top = 16
      Width = 140
      Height = 28
      Caption = 'Fechar Caixa'
      TabOrder = 0
      OnClick = btnFecharCaixaClick
    end
    object btnFechar: TButton
      Left = 650
      Top = 16
      Width = 120
      Height = 28
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 520
    Top = 200
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 600
    Top = 200
    object cdsItensCODIGO_FORMA: TIntegerField
      FieldName = 'CODIGO_FORMA'
      ReadOnly = True
    end
    object cdsItensDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      ReadOnly = True
      Size = 60
    end
    object cdsItensVALOR_SISTEMA: TCurrencyField
      FieldName = 'VALOR_SISTEMA'
      ReadOnly = True
    end
    object cdsItensVALOR_INFORMADO: TCurrencyField
      FieldName = 'VALOR_INFORMADO'
      OnChange = cdsItensVALOR_INFORMADOChange
    end
    object cdsItensDIFERENCA: TCurrencyField
      FieldName = 'DIFERENCA'
      ReadOnly = True
    end
  end
  object IBTransactionFec: TIBTransaction
    Active = True
    DefaultDatabase = dmConexao.IBDConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 440
    Top = 200
  end
  object ibqAux: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionFec
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 680
    Top = 200
  end
end
