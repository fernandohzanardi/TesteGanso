object frmContasReceber: TfrmContasReceber
  Left = 0
  Top = 0
  Caption = 'Contas a Receber'
  ClientHeight = 480
  ClientWidth = 900
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
    Width = 900
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lPeriodo: TLabel
      Left = 12
      Top = 12
      Width = 100
      Height = 15
      Caption = 'Vencimento de:'
    end
    object lAte: TLabel
      Left = 250
      Top = 12
      Width = 16
      Height = 15
      Caption = 'at'#233
    end
    object lSituacao: TLabel
      Left = 430
      Top = 12
      Width = 48
      Height = 15
      Caption = 'Situa'#231#227'o:'
    end
    object lCliente: TLabel
      Left = 620
      Top = 12
      Width = 80
      Height = 15
      Caption = 'C'#243'digo cliente:'
    end
    object dtpDataInicial: TDateTimePicker
      Left = 100
      Top = 8
      Width = 140
      Height = 23
      Date = 45444.000000000000000000
      Time = 45444.000000000000000000
      TabOrder = 0
    end
    object dtpDataFinal: TDateTimePicker
      Left = 274
      Top = 8
      Width = 140
      Height = 23
      Date = 45444.000000000000000000
      Time = 45444.000000000000000000
      TabOrder = 1
    end
    object cbSituacao: TComboBox
      Left = 430
      Top = 32
      Width = 160
      Height = 23
      Style = csDropDownList
      TabOrder = 2
    end
    object eCodigoCliente: TEdit
      Left = 620
      Top = 32
      Width = 100
      Height = 23
      NumbersOnly = True
      TabOrder = 3
    end
    object btnConsultar: TButton
      Left = 12
      Top = 44
      Width = 120
      Height = 28
      Caption = 'Consultar (F5)'
      Default = True
      TabOrder = 4
      OnClick = btnConsultarClick
    end
  end
  object dbgTitulos: TDBGrid
    Left = 0
    Top = 80
    Width = 900
    Height = 340
    Align = alClient
    DataSource = dsTitulos
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
        Title.Caption = 'C'#243'digo'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CLIENTE'
        Title.Caption = 'Cliente'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_VENDA'
        Title.Caption = 'Venda'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PARCELA'
        Title.Caption = 'Parc.'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VENCIMENTO'
        Title.Caption = 'Vencimento'
        Width = 90
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
        FieldName = 'VALOR_SALDO'
        Title.Caption = 'Saldo'
        Width = 90
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SITUACAO'
        Title.Caption = 'Sit.'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORMA'
        Title.Caption = 'Forma'
        Width = 120
        Visible = True
      end>
  end
  object pRodape: TPanel
    Left = 0
    Top = 420
    Width = 900
    Height = 60
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnBaixar: TButton
      Left = 12
      Top = 16
      Width = 120
      Height = 28
      Caption = 'Baixar'
      TabOrder = 0
      OnClick = btnBaixarClick
    end
    object btnFechar: TButton
      Left = 770
      Top = 16
      Width = 120
      Height = 28
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = btnFecharClick
    end
  end
  object dsTitulos: TDataSource
    DataSet = ibqTitulos
    Left = 640
    Top = 200
  end
  object IBTransactionRec: TIBTransaction
    Active = True
    DefaultDatabase = dmConexao.IBDConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 560
    Top = 200
  end
  object ibqTitulos: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionRec
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 720
    Top = 200
    object ibqTitulosCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object ibqTitulosNOME_CLIENTE: TIBStringField
      FieldName = 'NOME_CLIENTE'
      Size = 100
    end
    object ibqTitulosCODIGO_VENDA: TIntegerField
      FieldName = 'CODIGO_VENDA'
    end
    object ibqTitulosPARCELA: TIntegerField
      FieldName = 'PARCELA'
    end
    object ibqTitulosVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
    end
    object ibqTitulosVALOR: TIBBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object ibqTitulosVALOR_SALDO: TIBBCDField
      FieldName = 'VALOR_SALDO'
      Precision = 15
      Size = 2
    end
    object ibqTitulosSITUACAO: TIBStringField
      FieldName = 'SITUACAO'
      FixedChar = True
      Size = 1
    end
    object ibqTitulosFORMA: TIBStringField
      FieldName = 'FORMA'
      Size = 60
    end
    object ibqTitulosCODIGO_CLIENTE: TIntegerField
      FieldName = 'CODIGO_CLIENTE'
    end
  end
end
