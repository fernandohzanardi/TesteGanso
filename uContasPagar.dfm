object frmContasPagar: TfrmContasPagar
  Left = 0
  Top = 0
  Caption = 'Contas a Pagar'
  ClientHeight = 540
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
    Height = 70
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
    object btnConsultar: TButton
      Left = 620
      Top = 28
      Width = 120
      Height = 28
      Caption = 'Consultar (F5)'
      Default = True
      TabOrder = 3
      OnClick = btnConsultarClick
    end
  end
  object dbgTitulos: TDBGrid
    Left = 0
    Top = 70
    Width = 900
    Height = 220
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
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_FORNECEDOR'
        Title.Caption = 'Fornecedor'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CENTRO_CUSTO'
        Title.Caption = 'Centro Custo'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 180
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
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_SALDO'
        Title.Caption = 'Saldo'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SITUACAO'
        Title.Caption = 'Sit.'
        Width = 35
        Visible = True
      end>
  end
  object pEdicao: TPanel
    Left = 0
    Top = 290
    Width = 900
    Height = 150
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object lFornecedor: TLabel
      Left = 12
      Top = 12
      Width = 90
      Height = 15
      Caption = 'C'#243'd. Fornecedor:'
    end
    object lNomeFornecedor: TLabel
      Left = 200
      Top = 28
      Width = 200
      Height = 15
      Caption = ''
    end
    object lCentroCusto: TLabel
      Left = 420
      Top = 12
      Width = 90
      Height = 15
      Caption = 'C'#243'd. Centro Custo:'
    end
    object lNomeCentroCusto: TLabel
      Left = 620
      Top = 28
      Width = 200
      Height = 15
      Caption = ''
    end
    object lDescricao: TLabel
      Left = 12
      Top = 56
      Width = 53
      Height = 15
      Caption = 'Descri'#231#227'o:'
    end
    object lVencimento: TLabel
      Left = 12
      Top = 100
      Width = 66
      Height = 15
      Caption = 'Vencimento:'
    end
    object lValor: TLabel
      Left = 200
      Top = 100
      Width = 30
      Height = 15
      Caption = 'Valor:'
    end
    object lSaldo: TLabel
      Left = 360
      Top = 100
      Width = 32
      Height = 15
      Caption = 'Saldo:'
    end
    object lSit: TLabel
      Left = 520
      Top = 100
      Width = 48
      Height = 15
      Caption = 'Situa'#231#227'o:'
    end
    object dbeCodigoFornecedor: TDBEdit
      Left = 110
      Top = 8
      Width = 80
      Height = 23
      DataField = 'CODIGO_FORNECEDOR'
      DataSource = dsTitulos
      TabOrder = 0
      OnExit = dbeCodigoFornecedorExit
    end
    object dbeCodigoCentroCusto: TDBEdit
      Left = 520
      Top = 8
      Width = 80
      Height = 23
      DataField = 'CODIGO_CENTRO_CUSTO'
      DataSource = dsTitulos
      TabOrder = 1
      OnExit = dbeCodigoCentroCustoExit
    end
    object dbeDescricao: TDBEdit
      Left = 70
      Top = 52
      Width = 700
      Height = 23
      DataField = 'DESCRICAO'
      DataSource = dsTitulos
      TabOrder = 2
    end
    object dbeVencimento: TDBEdit
      Left = 90
      Top = 96
      Width = 90
      Height = 23
      DataField = 'VENCIMENTO'
      DataSource = dsTitulos
      TabOrder = 3
    end
    object dbeValor: TDBEdit
      Left = 240
      Top = 96
      Width = 100
      Height = 23
      DataField = 'VALOR'
      DataSource = dsTitulos
      TabOrder = 4
    end
    object dbeSaldo: TDBEdit
      Left = 400
      Top = 96
      Width = 100
      Height = 23
      Color = clBtnFace
      DataField = 'VALOR_SALDO'
      DataSource = dsTitulos
      ReadOnly = True
      TabOrder = 5
    end
    object dbeSituacao: TDBEdit
      Left = 580
      Top = 96
      Width = 40
      Height = 23
      Color = clBtnFace
      DataField = 'SITUACAO'
      DataSource = dsTitulos
      ReadOnly = True
      TabOrder = 6
    end
  end
  object pBotoes: TPanel
    Left = 0
    Top = 440
    Width = 900
    Height = 100
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object btnInserir: TButton
      Left = 12
      Top = 12
      Width = 90
      Height = 28
      Caption = 'Inserir'
      TabOrder = 0
      OnClick = btnInserirClick
    end
    object btnEditar: TButton
      Left = 108
      Top = 12
      Width = 90
      Height = 28
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnGravar: TButton
      Left = 204
      Top = 12
      Width = 90
      Height = 28
      Caption = 'Gravar'
      TabOrder = 2
      OnClick = btnGravarClick
    end
    object btnCancelar: TButton
      Left = 300
      Top = 12
      Width = 90
      Height = 28
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
    object btnExcluir: TButton
      Left = 396
      Top = 12
      Width = 90
      Height = 28
      Caption = 'Excluir'
      TabOrder = 4
      OnClick = btnExcluirClick
    end
    object btnBaixar: TButton
      Left = 492
      Top = 12
      Width = 90
      Height = 28
      Caption = 'Baixar'
      TabOrder = 5
      OnClick = btnBaixarClick
    end
    object btnFechar: TButton
      Left = 770
      Top = 12
      Width = 120
      Height = 28
      Caption = 'Fechar'
      TabOrder = 6
      OnClick = btnFecharClick
    end
  end
  object dsTitulos: TDataSource
    DataSet = ibqTitulos
    OnDataChange = dsTitulosDataChange
    Left = 640
    Top = 160
  end
  object IBTransactionPag: TIBTransaction
    Active = True
    DefaultDatabase = dmConexao.IBDConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 560
    Top = 160
  end
  object ibqTitulos: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionPag
    UpdateObject = IBUpdateSQLPag
    BufferChunks = 1000
    CachedUpdates = False
    GeneratorField.Field = 'CODIGO'
    GeneratorField.Generator = 'GEN_TITULO_PAGAR_ID'
    GeneratorField.ApplyEvent = gamOnServer
    ParamCheck = True
    PrecommittedReads = False
    Left = 720
    Top = 160
    object ibqTitulosCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object ibqTitulosCODIGO_FORNECEDOR: TIntegerField
      FieldName = 'CODIGO_FORNECEDOR'
    end
    object ibqTitulosNOME_FORNECEDOR: TIBStringField
      FieldName = 'NOME_FORNECEDOR'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object ibqTitulosCODIGO_CENTRO_CUSTO: TIntegerField
      FieldName = 'CODIGO_CENTRO_CUSTO'
    end
    object ibqTitulosNOME_CENTRO_CUSTO: TIBStringField
      FieldName = 'NOME_CENTRO_CUSTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
    object ibqTitulosDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Size = 120
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
  end
  object IBUpdateSQLPag: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  T.CODIGO,'
      '  T.CODIGO_FORNECEDOR,'
      '  F.NOME AS NOME_FORNECEDOR,'
      '  T.CODIGO_CENTRO_CUSTO,'
      '  CC.DESCRICAO AS NOME_CENTRO_CUSTO,'
      '  T.DESCRICAO,'
      '  T.VENCIMENTO,'
      '  T.VALOR,'
      '  T.VALOR_SALDO,'
      '  T.SITUACAO'
      'from TITULO_PAGAR T'
      'JOIN FORNECEDOR F ON F.CODIGO = T.CODIGO_FORNECEDOR'
      'JOIN CENTRO_CUSTO CC ON CC.CODIGO = T.CODIGO_CENTRO_CUSTO'
      'where'
      '  T.CODIGO = :CODIGO')
    ModifySQL.Strings = (
      'update TITULO_PAGAR'
      'set'
      '  CODIGO_FORNECEDOR = :CODIGO_FORNECEDOR,'
      '  CODIGO_CENTRO_CUSTO = :CODIGO_CENTRO_CUSTO,'
      '  DESCRICAO = :DESCRICAO,'
      '  VENCIMENTO = :VENCIMENTO,'
      '  VALOR = :VALOR,'
      '  VALOR_SALDO = :VALOR_SALDO,'
      '  SITUACAO = :SITUACAO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'insert into TITULO_PAGAR'
      
        '  (CODIGO_FORNECEDOR, CODIGO_CENTRO_CUSTO, DESCRICAO, VENCIMENTO' +
        ', VALOR, VALOR_SALDO, SITUACAO)'
      'values'
      
        '  (:CODIGO_FORNECEDOR, :CODIGO_CENTRO_CUSTO, :DESCRICAO, :VENCIM' +
        'ENTO, :VALOR, :VALOR_SALDO, :SITUACAO)')
    DeleteSQL.Strings = (
      'delete from TITULO_PAGAR'
      'where'
      '  CODIGO = :OLD_CODIGO')
    Left = 800
    Top = 160
  end
end
