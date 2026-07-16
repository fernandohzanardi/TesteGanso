object frmMovimentoCaixa: TfrmMovimentoCaixa
  Left = 0
  Top = 0
  Caption = 'Movimento de Caixa'
  ClientHeight = 520
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
      Width = 44
      Height = 15
      Caption = 'Per'#237'odo:'
    end
    object lAte: TLabel
      Left = 220
      Top = 12
      Width = 16
      Height = 15
      Caption = 'at'#233
    end
    object lTipoFiltro: TLabel
      Left = 400
      Top = 12
      Width = 24
      Height = 15
      Caption = 'Tipo:'
    end
    object dtpDataInicial: TDateTimePicker
      Left = 62
      Top = 8
      Width = 150
      Height = 23
      Date = 45444.000000000000000000
      Time = 45444.000000000000000000
      TabOrder = 0
    end
    object dtpDataFinal: TDateTimePicker
      Left = 244
      Top = 8
      Width = 130
      Height = 23
      Date = 45444.000000000000000000
      Time = 45444.000000000000000000
      TabOrder = 1
    end
    object cbTipoFiltro: TComboBox
      Left = 400
      Top = 32
      Width = 150
      Height = 23
      Style = csDropDownList
      TabOrder = 2
    end
    object btnConsultar: TButton
      Left = 570
      Top = 28
      Width = 120
      Height = 28
      Caption = 'Consultar (F5)'
      Default = True
      TabOrder = 3
      OnClick = btnConsultarClick
    end
  end
  object dbgMovimento: TDBGrid
    Left = 0
    Top = 70
    Width = 900
    Height = 220
    Align = alClient
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
        Title.Caption = 'C'#243'digo'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA'
        Title.Caption = 'Data'
        Width = 90
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'TIPO'
        Title.Caption = 'Tipo'
        Width = 40
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
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_FORMA_PAGAMENTO'
        Title.Caption = 'Forma'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_CONTA'
        Title.Caption = 'Conta'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_CENTRO_CUSTO'
        Title.Caption = 'C.Custo'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORIGEM'
        Title.Caption = 'Origem'
        Width = 80
        Visible = True
      end>
  end
  object pEdicao: TPanel
    Left = 0
    Top = 290
    Width = 900
    Height = 140
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object lData: TLabel
      Left = 12
      Top = 12
      Width = 28
      Height = 15
      Caption = 'Data:'
    end
    object lTipo: TLabel
      Left = 180
      Top = 12
      Width = 24
      Height = 15
      Caption = 'Tipo:'
    end
    object lValor: TLabel
      Left = 300
      Top = 12
      Width = 30
      Height = 15
      Caption = 'Valor:'
    end
    object lHistorico: TLabel
      Left = 12
      Top = 56
      Width = 51
      Height = 15
      Caption = 'Hist'#243'rico:'
    end
    object lForma: TLabel
      Left = 12
      Top = 100
      Width = 90
      Height = 15
      Caption = 'C'#243'd. Forma Pag.:'
    end
    object lConta: TLabel
      Left = 220
      Top = 100
      Width = 55
      Height = 15
      Caption = 'C'#243'd. Conta:'
    end
    object lCentroCusto: TLabel
      Left = 420
      Top = 100
      Width = 90
      Height = 15
      Caption = 'C'#243'd. Centro Custo:'
    end
    object dbeData: TDBEdit
      Left = 12
      Top = 28
      Width = 150
      Height = 23
      DataField = 'DATA'
      DataSource = dsMovimento
      TabOrder = 0
    end
    object dbcTipo: TDBComboBox
      Left = 180
      Top = 28
      Width = 100
      Height = 23
      DataField = 'TIPO'
      DataSource = dsMovimento
      Items.Strings = (
        'E'
        'S')
      TabOrder = 1
    end
    object dbeValor: TDBEdit
      Left = 300
      Top = 28
      Width = 120
      Height = 23
      DataField = 'VALOR'
      DataSource = dsMovimento
      TabOrder = 2
    end
    object dbeHistorico: TDBEdit
      Left = 70
      Top = 52
      Width = 700
      Height = 23
      DataField = 'HISTORICO'
      DataSource = dsMovimento
      TabOrder = 3
    end
    object dbeCodigoForma: TDBEdit
      Left = 110
      Top = 96
      Width = 80
      Height = 23
      DataField = 'CODIGO_FORMA_PAGAMENTO'
      DataSource = dsMovimento
      TabOrder = 4
    end
    object dbeCodigoConta: TDBEdit
      Left = 280
      Top = 96
      Width = 80
      Height = 23
      DataField = 'CODIGO_CONTA'
      DataSource = dsMovimento
      TabOrder = 5
    end
    object dbeCodigoCentroCusto: TDBEdit
      Left = 520
      Top = 96
      Width = 80
      Height = 23
      DataField = 'CODIGO_CENTRO_CUSTO'
      DataSource = dsMovimento
      TabOrder = 6
    end
  end
  object pBotoes: TPanel
    Left = 0
    Top = 430
    Width = 900
    Height = 90
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
    object btnFechar: TButton
      Left = 770
      Top = 12
      Width = 120
      Height = 28
      Caption = 'Fechar'
      TabOrder = 5
      OnClick = btnFecharClick
    end
  end
  object dsMovimento: TDataSource
    DataSet = ibqMovimento
    OnDataChange = dsMovimentoDataChange
    Left = 640
    Top = 160
  end
  object IBTransactionMov: TIBTransaction
    Active = True
    DefaultDatabase = dmConexao.IBDConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 560
    Top = 160
  end
  object ibqMovimento: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionMov
    UpdateObject = IBUpdateSQLMov
    BufferChunks = 1000
    CachedUpdates = False
    GeneratorField.Field = 'CODIGO'
    GeneratorField.Generator = 'GEN_MOVIMENTO_CAIXA_ID'
    GeneratorField.ApplyEvent = gamOnServer
    ParamCheck = True
    PrecommittedReads = False
    Left = 720
    Top = 160
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
    object ibqMovimentoCODIGO_FORMA_PAGAMENTO: TIntegerField
      FieldName = 'CODIGO_FORMA_PAGAMENTO'
    end
    object ibqMovimentoCODIGO_CONTA: TIntegerField
      FieldName = 'CODIGO_CONTA'
    end
    object ibqMovimentoCODIGO_CENTRO_CUSTO: TIntegerField
      FieldName = 'CODIGO_CENTRO_CUSTO'
    end
    object ibqMovimentoORIGEM: TIBStringField
      FieldName = 'ORIGEM'
      Size = 30
    end
    object ibqMovimentoCODIGO_ORIGEM: TIntegerField
      FieldName = 'CODIGO_ORIGEM'
    end
    object ibqMovimentoCONCILIADO: TIBStringField
      FieldName = 'CONCILIADO'
      FixedChar = True
      Size = 1
    end
  end
  object IBUpdateSQLMov: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  CODIGO,'
      '  DATA,'
      '  TIPO,'
      '  VALOR,'
      '  HISTORICO,'
      '  CODIGO_FORMA_PAGAMENTO,'
      '  CODIGO_CONTA,'
      '  CODIGO_CENTRO_CUSTO,'
      '  ORIGEM,'
      '  CODIGO_ORIGEM,'
      '  CONCILIADO,'
      '  CODIGO_EXTRATO'
      'from MOVIMENTO_CAIXA '
      'where'
      '  CODIGO = :CODIGO')
    ModifySQL.Strings = (
      'update MOVIMENTO_CAIXA'
      'set'
      '  DATA = :DATA,'
      '  TIPO = :TIPO,'
      '  VALOR = :VALOR,'
      '  HISTORICO = :HISTORICO,'
      '  CODIGO_FORMA_PAGAMENTO = :CODIGO_FORMA_PAGAMENTO,'
      '  CODIGO_CONTA = :CODIGO_CONTA,'
      '  CODIGO_CENTRO_CUSTO = :CODIGO_CENTRO_CUSTO,'
      '  ORIGEM = :ORIGEM,'
      '  CODIGO_ORIGEM = :CODIGO_ORIGEM,'
      '  CONCILIADO = :CONCILIADO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'insert into MOVIMENTO_CAIXA'
      
        '  (DATA, TIPO, VALOR, HISTORICO, CODIGO_FORMA_PAGAMENTO, CODIGO_' +
        'CONTA, CODIGO_CENTRO_CUSTO, ORIGEM, CODIGO_ORIGEM, CONCILIADO)'
      'values'
      
        '  (:DATA, :TIPO, :VALOR, :HISTORICO, :CODIGO_FORMA_PAGAMENTO, :C' +
        'ODIGO_CONTA, :CODIGO_CENTRO_CUSTO, :ORIGEM, :CODIGO_ORIGEM, :CON' +
        'CILIADO)')
    DeleteSQL.Strings = (
      'delete from MOVIMENTO_CAIXA'
      'where'
      '  CODIGO = :OLD_CODIGO')
    Left = 800
    Top = 160
  end
end
