object frmVendas: TfrmVendas
  Left = 0
  Top = 0
  Caption = 'Vendas'
  ClientHeight = 588
  ClientWidth = 795
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
  OnShow = FormShow
  TextHeight = 15
  object pCampos: TPanel
    Left = 0
    Top = 0
    Width = 795
    Height = 539
    Align = alClient
    TabOrder = 0
    DesignSize = (
      795
      539)
    object gbPagamentos: TGroupBox
      Left = 16
      Top = 361
      Width = 420
      Height = 172
      Caption = ' Pagamentos '
      TabOrder = 4
      object dbgPagamentos: TDBGrid
        Left = 8
        Top = 20
        Width = 404
        Height = 141
        DataSource = dsVendaPagamento
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
            FieldName = 'CODIGO_FORMA_PAGAMENTO'
            Title.Caption = 'Forma'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'Descri'#231#227'o'
            Width = 120
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
            FieldName = 'PARCELAS'
            Title.Caption = 'Parcelas'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VENCIMENTO'
            Title.Caption = 'Vencimento'
            Width = 80
            Visible = True
          end>
      end
    end
    object gbFechamentoVenda: TGroupBox
      Left = 444
      Top = 361
      Width = 334
      Height = 172
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Fechamento da Venda '
      TabOrder = 3
      object lTotalBruto: TLabel
        Left = 74
        Top = 39
        Width = 64
        Height = 15
        Caption = 'Total Bruto :'
        FocusControl = dbeTotalBruto
      end
      object lDesconto: TLabel
        Left = 61
        Top = 67
        Width = 77
        Height = 15
        Caption = 'Desconto (%) :'
        FocusControl = dbeDesconto
      end
      object lAcrescimo: TLabel
        Left = 55
        Top = 97
        Width = 83
        Height = 15
        Caption = 'Acr'#233'scimo (%) :'
        FocusControl = dbeAcrescimo
      end
      object lTotalLiquido: TLabel
        Left = 63
        Top = 123
        Width = 75
        Height = 15
        Caption = 'Total L'#237'quido :'
      end
      object dbeTotalBruto: TDBEdit
        Left = 144
        Top = 36
        Width = 145
        Height = 23
        Color = clBtnFace
        DataField = 'TOTAL_BRUTO'
        DataSource = dsVenda
        Enabled = False
        TabOrder = 0
      end
      object dbeDesconto: TDBEdit
        Left = 144
        Top = 65
        Width = 145
        Height = 23
        DataField = 'DESCONTO_PERC'
        DataSource = dsVenda
        TabOrder = 1
        OnChange = dbeDescontoChange
        OnExit = dbeDescontoExit
      end
      object dbeAcrescimo: TDBEdit
        Left = 144
        Top = 94
        Width = 145
        Height = 23
        DataField = 'ACRESCIMO_PREC'
        DataSource = dsVenda
        TabOrder = 2
        OnChange = dbeAcrescimoChange
        OnExit = dbeAcrescimoExit
      end
      object dbeTotalLiquido: TDBEdit
        Left = 144
        Top = 123
        Width = 145
        Height = 23
        Color = clBtnFace
        DataField = 'TOTAL_LIQUIDO'
        DataSource = dsVenda
        Enabled = False
        TabOrder = 3
      end
    end
    object pVenda: TPanel
      Left = 32
      Top = 24
      Width = 738
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
      DesignSize = (
        738
        49)
      object lCodigoVenda: TLabel
        Left = 16
        Top = 16
        Width = 45
        Height = 15
        Caption = 'C'#243'digo :'
        FocusControl = dbeCodigo
      end
      object lDataHoraVenda: TLabel
        Left = 177
        Top = 16
        Width = 112
        Height = 15
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Data/Hora da Venda :'
        FocusControl = dbeDataHoraVenda
      end
      object lSituacao: TLabel
        Left = 514
        Top = 16
        Width = 51
        Height = 15
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Situa'#231#227'o :'
      end
      object dbeCodigo: TDBEdit
        Left = 67
        Top = 13
        Width = 86
        Height = 23
        Color = clBtnFace
        DataField = 'CODIGO'
        DataSource = dsVenda
        Enabled = False
        TabOrder = 0
      end
      object dbeDataHoraVenda: TDBEdit
        Left = 295
        Top = 13
        Width = 194
        Height = 23
        DataField = 'DATA_HORA_VENDA'
        DataSource = dsVenda
        Enabled = False
        TabOrder = 1
      end
      object eSituacao: TEdit
        Left = 571
        Top = 13
        Width = 151
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        Enabled = False
        TabOrder = 2
      end
    end
    object pCliente: TPanel
      Left = 31
      Top = 79
      Width = 738
      Height = 50
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      DesignSize = (
        738
        50)
      object lCodigoCliente: TLabel
        Left = 18
        Top = 19
        Width = 43
        Height = 15
        Caption = 'Cliente :'
      end
      object dbeCodigoCliente: TDBEdit
        Left = 67
        Top = 16
        Width = 62
        Height = 23
        DataField = 'CODIGO_CLIENTE'
        DataSource = dsVenda
        TabOrder = 0
        OnChange = dbeCodigoClienteChange
      end
      object dbeNomeCliente: TDBEdit
        Left = 135
        Top = 16
        Width = 579
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        DataField = 'NOME'
        DataSource = dsCliente
        Enabled = False
        TabOrder = 1
      end
    end
    object gbVendaItem: TGroupBox
      Left = 16
      Top = 135
      Width = 762
      Height = 220
      Anchors = [akLeft, akTop, akRight]
      Caption = ' Itens da Venda '
      TabOrder = 2
      DesignSize = (
        762
        220)
      object dbgItens: TDBGrid
        Left = 2
        Top = 15
        Width = 759
        Height = 161
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dsVendaItem
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO_PRODUTO'
            Width = 94
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Width = 180
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QUANTIDADE'
            Width = 68
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO_UNITARIO'
            Width = 109
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCONTO'
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ACRESCIMO'
            Width = 61
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTAL_LIQUIDO'
            Visible = True
          end>
      end
      object btnInserirItens: TButton
        Left = 3
        Top = 183
        Width = 113
        Height = 25
        Caption = 'Inserir/Alterar Itens'
        TabOrder = 1
        OnClick = btnInserirItensClick
      end
    end
  end
  object pBotoes: TPanel
    Left = 0
    Top = 539
    Width = 795
    Height = 49
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      795
      49)
    object btnExcluir: TButton
      AlignWithMargins = True
      Left = 717
      Top = 11
      Width = 70
      Height = 25
      Anchors = [akRight]
      Caption = 'Excluir'
      TabOrder = 11
      OnClick = btnExcluirClick
    end
    object btnCancelar: TButton
      AlignWithMargins = True
      Left = 646
      Top = 11
      Width = 70
      Height = 25
      Anchors = [akRight]
      Caption = 'Cancelar'
      TabOrder = 10
      OnClick = btnCancelarClick
    end
    object btnGravar: TButton
      AlignWithMargins = True
      Left = 578
      Top = 11
      Width = 67
      Height = 25
      Anchors = [akRight]
      Caption = 'Gravar'
      TabOrder = 9
      OnClick = btnGravarClick
    end
    object btnEditar: TButton
      AlignWithMargins = True
      Left = 511
      Top = 11
      Width = 66
      Height = 25
      Anchors = [akRight]
      Caption = 'Editar'
      TabOrder = 8
      OnClick = btnEditarClick
    end
    object btnInserir: TButton
      AlignWithMargins = True
      Left = 444
      Top = 11
      Width = 66
      Height = 25
      Anchors = [akRight]
      Caption = 'Inserir'
      TabOrder = 7
      OnClick = btnInserirClick
    end
    object btnUltimo: TButton
      AlignWithMargins = True
      Left = 95
      Top = 11
      Width = 30
      Height = 25
      Anchors = [akLeft]
      Caption = '>>'
      TabOrder = 3
      OnClick = btnUltimoClick
    end
    object btnProximo: TButton
      AlignWithMargins = True
      Left = 66
      Top = 11
      Width = 30
      Height = 25
      Anchors = [akLeft]
      Caption = '>'
      TabOrder = 2
      OnClick = btnProximoClick
    end
    object btnAnterior: TButton
      AlignWithMargins = True
      Left = 37
      Top = 11
      Width = 30
      Height = 25
      Anchors = [akLeft]
      Caption = '<'
      TabOrder = 1
      OnClick = btnAnteriorClick
    end
    object btnPrimeiro: TButton
      AlignWithMargins = True
      Left = 8
      Top = 11
      Width = 30
      Height = 25
      Anchors = [akLeft]
      Caption = '<<'
      TabOrder = 0
      OnClick = btnPrimeiroClick
    end
    object btnFecharVenda: TButton
      Left = 332
      Top = 11
      Width = 102
      Height = 25
      Caption = 'Fechar Venda'
      TabOrder = 6
      OnClick = btnFecharVendaClick
    end
    object btnImprimir: TButton
      Left = 132
      Top = 11
      Width = 70
      Height = 25
      Caption = 'Imprimir'
      TabOrder = 4
      OnClick = btnImprimirClick
    end
    object btnImprimirPromissoria: TButton
      Left = 203
      Top = 11
      Width = 121
      Height = 25
      Caption = 'Imprimir Promiss'#243'ria'
      TabOrder = 5
      OnClick = btnImprimirPromissoriaClick
    end
  end
  object dsVenda: TDataSource
    DataSet = ibqVenda
    OnDataChange = dsVendaDataChange
    Left = 360
  end
  object ibqVenda: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionVenda
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT V.*'
      'FROM VENDA V'
      'WHERE V.CODIGO > 0')
    UpdateObject = IBUpdateSQLVenda
    GeneratorField.ApplyEvent = gamOnServer
    PrecommittedReads = False
    Left = 208
    object ibqVendaCODIGO: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'CODIGO'
      Origin = 'VENDA.CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object ibqVendaCODIGO_CLIENTE: TIntegerField
      FieldName = 'CODIGO_CLIENTE'
      Origin = 'VENDA.CODIGO_CLIENTE'
      Required = True
    end
    object ibqVendaSITUACAO: TIBStringField
      FieldName = 'SITUACAO'
      Origin = 'VENDA.SITUACAO'
      Required = True
      Size = 1
    end
    object ibqVendaDATA_HORA_VENDA: TDateTimeField
      FieldName = 'DATA_HORA_VENDA'
      Origin = 'VENDA.DATA_HORA_VENDA'
    end
    object ibqVendaTOTAL_BRUTO: TIBBCDField
      FieldName = 'TOTAL_BRUTO'
      Origin = 'VENDA.TOTAL_BRUTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object ibqVendaDESCONTO_PERC: TIBBCDField
      FieldName = 'DESCONTO_PERC'
      Origin = 'VENDA.DESCONTO_PERC'
      Precision = 18
      Size = 4
    end
    object ibqVendaACRESCIMO_PREC: TIBBCDField
      FieldName = 'ACRESCIMO_PREC'
      Origin = 'VENDA.ACRESCIMO_PREC'
      Precision = 18
      Size = 4
    end
    object ibqVendaTOTAL_LIQUIDO: TIBBCDField
      FieldName = 'TOTAL_LIQUIDO'
      Origin = 'VENDA.TOTAL_LIQUIDO'
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object IBTransactionVenda: TIBTransaction
    DefaultDatabase = dmConexao.IBDConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 304
  end
  object ibqCliente: TIBQuery
    Database = dmConexao.IBDConexao
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = dsVenda
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT C.CODIGO, C.NOME, C.TELEFONE, C.LIMITE_CREDITO, C.SITUACA' +
        'O'
      'FROM CLIENTE C'
      'WHERE C.CODIGO = :CODIGO_CLIENTE')
    GeneratorField.Field = 'CODIGO'
    GeneratorField.Generator = 'GEN_VENDA_ID'
    GeneratorField.ApplyEvent = gamOnPost
    PrecommittedReads = False
    Left = 632
    Top = 88
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CODIGO_CLIENTE'
        ParamType = ptUnknown
        Size = 4
      end>
    object ibqClienteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'CLIENTE.CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ibqClienteNOME: TIBStringField
      FieldName = 'NOME'
      Origin = 'CLIENTE.NOME'
      Required = True
      Size = 60
    end
    object ibqClienteTELEFONE: TIBStringField
      FieldName = 'TELEFONE'
      Origin = 'CLIENTE.TELEFONE'
      Size = 16
    end
    object ibqClienteLIMITE_CREDITO: TIBBCDField
      FieldName = 'LIMITE_CREDITO'
      Origin = 'CLIENTE.LIMITE_CREDITO'
      Precision = 18
      Size = 2
    end
    object ibqClienteSITUACAO: TIBStringField
      FieldName = 'SITUACAO'
      Origin = 'CLIENTE.SITUACAO'
      FixedChar = True
      Size = 1
    end
  end
  object dsCliente: TDataSource
    DataSet = ibqCliente
    Left = 552
    Top = 96
  end
  object IBUpdateSQLVenda: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  CODIGO,'
      '  CODIGO_CLIENTE,'
      '  SITUACAO,'
      '  DATA_HORA_VENDA,'
      '  TOTAL_BRUTO,'
      '  DESCONTO_PERC,'
      '  ACRESCIMO_PREC,'
      '  TOTAL_LIQUIDO'
      'from VENDA '
      'where'
      '  CODIGO = :CODIGO')
    ModifySQL.Strings = (
      'update VENDA'
      'set'
      '  CODIGO_CLIENTE = :CODIGO_CLIENTE,'
      '  SITUACAO = :SITUACAO,'
      '  DATA_HORA_VENDA = :DATA_HORA_VENDA,'
      '  TOTAL_BRUTO = :TOTAL_BRUTO,'
      '  DESCONTO_PERC = :DESCONTO_PERC,'
      '  ACRESCIMO_PREC = :ACRESCIMO_PREC,'
      '  TOTAL_LIQUIDO = :TOTAL_LIQUIDO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'insert into VENDA'
      
        '  (CODIGO_CLIENTE, SITUACAO, DATA_HORA_VENDA, TOTAL_BRUTO, DESCO' +
        'NTO_PERC, '
      '   ACRESCIMO_PREC, TOTAL_LIQUIDO)'
      'values'
      
        '  (:CODIGO_CLIENTE, :SITUACAO, :DATA_HORA_VENDA, :TOTAL_BRUTO, :' +
        'DESCONTO_PERC, '
      '   :ACRESCIMO_PREC, :TOTAL_LIQUIDO)')
    DeleteSQL.Strings = (
      'delete from VENDA'
      'where'
      '  CODIGO = :OLD_CODIGO')
    Left = 424
  end
  object dsVendaItem: TDataSource
    DataSet = ibqVendaItem
    Left = 496
    Top = 176
  end
  object ibqVendaItem: TIBQuery
    Database = dmConexao.IBDConexao
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = dsVenda
    ParamCheck = True
    SQL.Strings = (
      
        '  SELECT VI.CODIGO, VI.CODIGO_PRODUTO, P.DESCRICAO, VI.QUANTIDAD' +
        'E, VI.PRECO_UNITARIO, VI.DESCONTO, VI.ACRESCIMO, VI.TOTAL_LIQUID' +
        'O'
      '  FROM VENDA_ITEM VI'
      '    JOIN PRODUTO P ON (P.CODIGO = VI.CODIGO_PRODUTO)'
      '  WHERE VI.CODIGO_VENDA = :CODIGO'
      '')
    PrecommittedReads = False
    Left = 656
    Top = 175
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object ibqVendaItemCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Origin = 'VENDA_ITEM.CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ibqVendaItemCODIGO_PRODUTO: TIntegerField
      DisplayLabel = 'C'#243'd. do Produto'
      FieldName = 'CODIGO_PRODUTO'
      Origin = 'VENDA_ITEM.CODIGO_PRODUTO'
      Required = True
    end
    object ibqVendaItemDESCRICAO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o do Produto'
      FieldName = 'DESCRICAO'
      Origin = 'PRODUTO.DESCRICAO'
      Required = True
      Size = 60
    end
    object ibqVendaItemQUANTIDADE: TIBBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      Origin = 'VENDA_ITEM.QUANTIDADE'
      Required = True
      Precision = 18
      Size = 3
    end
    object ibqVendaItemPRECO_UNITARIO: TIBBCDField
      DisplayLabel = 'Pre'#231'o Unit.'
      FieldName = 'PRECO_UNITARIO'
      Origin = 'VENDA_ITEM.PRECO_UNITARIO'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object ibqVendaItemDESCONTO: TIBBCDField
      DisplayLabel = 'Desconto'
      FieldName = 'DESCONTO'
      Origin = 'VENDA_ITEM.DESCONTO'
      Precision = 18
      Size = 4
    end
    object ibqVendaItemACRESCIMO: TIBBCDField
      DisplayLabel = 'Acr'#233'scimo'
      FieldName = 'ACRESCIMO'
      Origin = 'VENDA_ITEM.ACRESCIMO'
      Precision = 18
      Size = 4
    end
    object ibqVendaItemTOTAL_LIQUIDO: TIBBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'TOTAL_LIQUIDO'
      ProviderFlags = []
      ReadOnly = True
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object frxRelatorio: TfrxReport
    Version = '2026.2.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 46211.639787789400000000
    ReportOptions.LastChange = 46213.560000000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 672
    Top = 247
    Datasets = <
      item
        DataSet = frxVenda
        DataSetName = 'frxVenda'
      end
      item
        DataSet = frxItensVenda
        DataSetName = 'ibqVendaItem'
      end
      item
        DataSet = frxCliente
        DataSetName = 'frxCliente'
      end>
    Variables = <>
    Style = <>
    Watermarks = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 80.000000000000000000
      PaperHeight = 200.000000000000000000
      PaperSize = 256
      LeftMargin = 2.000000000000000000
      RightMargin = 2.000000000000000000
      TopMargin = 2.000000000000000000
      BottomMargin = 2.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 18.897650000000000000
        Width = 287.244280000000000000
        object MemoTitulo: TfrxMemoView
          AllowVectorExport = True
          Top = 3.779530000000000000
          Width = 287.244090000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'RECIBO DE VENDA')
          ParentFont = False
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 132.283550000000000000
        Top = 71.811070000000000000
        Width = 287.244280000000000000
        object MemoClienteTitulo: TfrxMemoView
          AllowVectorExport = True
          Width = 287.244090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'CLIENTE')
          ParentFont = False
        end
        object MemoClienteCodigo: TfrxMemoView
          AllowVectorExport = True
          Top = 15.118120000000000000
          Width = 287.244090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#243'digo: [frxCliente."CODIGO"]')
          ParentFont = False
        end
        object MemoClienteNome: TfrxMemoView
          AllowVectorExport = True
          Top = 30.236240000000000000
          Width = 287.244090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Nome: [frxCliente."NOME"]')
          ParentFont = False
        end
        object MemoClienteTelefone: TfrxMemoView
          AllowVectorExport = True
          Top = 45.354360000000000000
          Width = 287.244090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Telefone: [frxCliente."TELEFONE"]')
          ParentFont = False
        end
        object MemoVendaTitulo: TfrxMemoView
          AllowVectorExport = True
          Top = 64.252010000000000000
          Width = 287.244090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'VENDA')
          ParentFont = False
        end
        object MemoVendaCodigo: TfrxMemoView
          AllowVectorExport = True
          Top = 79.370130000000000000
          Width = 287.244090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#243'digo: [frxVenda."CODIGO"]')
          ParentFont = False
        end
        object MemoVendaData: TfrxMemoView
          AllowVectorExport = True
          Top = 94.488250000000000000
          Width = 287.244090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Data: [frxVenda."DATA_HORA_VENDA"]')
          ParentFont = False
        end
        object MemoItensTitulo: TfrxMemoView
          AllowVectorExport = True
          Top = 113.385900000000000000
          Width = 287.244090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Memo.UTF8W = (
            'ITENS')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 49.133890000000000000
        Top = 264.567100000000000000
        Width = 287.244280000000000000
        DataSet = frxItensVenda
        DataSetName = 'ibqVendaItem'
        RowCount = 0
        object MemoItemCodigo: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DataField = 'CODIGO_PRODUTO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[ibqVendaItem."CODIGO_PRODUTO"]')
          ParentFont = False
        end
        object MemoItemDescricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 49.133890000000000000
          Width = 234.330710000000000000
          Height = 15.118120000000000000
          DataField = 'DESCRICAO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[ibqVendaItem."DESCRICAO"]')
          ParentFont = False
        end
        object MemoItemQtde: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Top = 15.118120000000000000
          Width = 49.133890000000000000
          Height = 15.118120000000000000
          DataField = 'QUANTIDADE'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[ibqVendaItem."QUANTIDADE"]')
          ParentFont = False
        end
        object MemoItemUnit: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 52.913420000000000000
          Top = 15.118120000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          DataField = 'PRECO_UNITARIO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[ibqVendaItem."PRECO_UNITARIO"]')
          ParentFont = False
        end
        object MemoItemDesc: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 120.944960000000000000
          Top = 15.118120000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'DESCONTO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[ibqVendaItem."DESCONTO"]')
          ParentFont = False
        end
        object MemoItemAcr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 181.417440000000000000
          Top = 15.118120000000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          DataField = 'ACRESCIMO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[ibqVendaItem."ACRESCIMO"]')
          ParentFont = False
        end
        object MemoItemTotal: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 241.889920000000000000
          Top = 15.118120000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          DataField = 'TOTAL_LIQUIDO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[ibqVendaItem."TOTAL_LIQUIDO"]')
          ParentFont = False
        end
        object MemoItemSeparador: TfrxMemoView
          AllowVectorExport = True
          Top = 34.015770000000000000
          Width = 287.244090000000000000
          Height = 11.338590000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 41.574803470000000000
        Top = 374.173470000000000000
        Width = 287.244280000000000000
        object MemoTotalVenda: TfrxMemoView
          AllowVectorExport = True
          Width = 287.244090000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL: [frxVenda."TOTAL_LIQUIDO"]')
          ParentFont = False
        end
        object MemoImpresso: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Top = 22.677180000000000000
          Width = 287.244090000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Impresso em: [Date] [Time]')
          ParentFont = False
        end
      end
    end
  end
  object frxVenda: TfrxDBDataset
    UserName = 'frxVenda'
    CloseDataSource = False
    DataSet = ibqVenda
    BCDToCurrency = True
    DataSetOptions = []
    Left = 616
    Top = 263
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    PDFColorSpace = csDeviceRGB
    Left = 456
    Top = 263
  end
  object frxItensVenda: TfrxDBDataset
    UserName = 'ibqVendaItem'
    CloseDataSource = False
    DataSet = ibqVendaItem
    BCDToCurrency = True
    DataSetOptions = []
    Left = 544
    Top = 247
  end
  object frxCliente: TfrxDBDataset
    UserName = 'frxCliente'
    CloseDataSource = False
    DataSet = ibqCliente
    BCDToCurrency = False
    DataSetOptions = []
    Left = 584
    Top = 191
  end
  object frxVendaLog: TfrxDBDataset
    UserName = 'frxVendaLog'
    CloseDataSource = False
    DataSet = ibqVendaLog
    BCDToCurrency = False
    DataSetOptions = []
    Left = 560
    Top = 311
  end
  object frxRelatorioPromissoria: TfrxReport
    Version = '2026.2.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 46281.600000000000000000
    ReportOptions.LastChange = 46281.600000000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 672
    Top = 311
    Datasets = <
      item
        DataSet = frxVenda
        DataSetName = 'frxVenda'
      end
      item
        DataSet = frxItensVenda
        DataSetName = 'ibqVendaItem'
      end
      item
        DataSet = frxCliente
        DataSetName = 'frxCliente'
      end>
    Variables = <>
    Style = <>
    Watermarks = <>
    object PromData: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object PromPage1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 20.000000000000000000
      RightMargin = 20.000000000000000000
      TopMargin = 15.000000000000000000
      BottomMargin = 15.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PromReportTitle1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 52.913390000000000000
        Top = 18.897650000000000000
        Width = 642.520100000000000000
        object PromMemoTitulo: TfrxMemoView
          AllowVectorExport = True
          Width = 642.519636220000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clGray
          HAlign = haCenter
          Memo.UTF8W = (
            'NOTA PROMISSORIA')
          ParentFont = False
          VAlign = vaCenter
        end
        object PromMemoNumero: TfrxMemoView
          AllowVectorExport = True
          Top = 34.015770000000000000
          Width = 343.937000000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'N. [frxVenda."CODIGO"]')
          ParentFont = False
        end
        object PromMemoValorDestaque: TfrxMemoView
          AllowVectorExport = True
          Left = 347.716530000000000000
          Top = 34.015770000000000000
          Width = 291.023580000000000000
          Height = 18.897650000000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Valor: [frxVenda."TOTAL_LIQUIDO"]')
          ParentFont = False
        end
      end
      object PromPageHeader1: TfrxPageHeader
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 226.771650000000000000
        Top = 94.488250000000000000
        Width = 642.520100000000000000
        object PromMemoTexto: TfrxMemoView
          AllowVectorExport = True
          Width = 642.519636220000000000
          Height = 56.692910000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            
              'Ao portador pagarei por esta unica via de NOTA PROMISSORIA a qua' +
              'ntia de [frxVenda."TOTAL_LIQUIDO"] referente a venda n. [frxVend' +
              'a."CODIGO"], em moeda corrente deste pais.')
          ParentFont = False
        end
        object PromMemoSecaoCliente: TfrxMemoView
          AllowVectorExport = True
          Top = 64.252010000000000000
          Width = 642.519636220000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clGray
          Memo.UTF8W = (
            ' DADOS DO CLIENTE')
          ParentFont = False
        end
        object PromMemoCliCodigo: TfrxMemoView
          AllowVectorExport = True
          Top = 86.929130000000000000
          Width = 718.110236220000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Codigo: [frxCliente."CODIGO"]   Nome: [frxCliente."NOME"]')
          ParentFont = False
        end
        object PromMemoCliTelefone: TfrxMemoView
          AllowVectorExport = True
          Top = 105.826770000000000000
          Width = 718.110236220000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Telefone: [frxCliente."TELEFONE"]')
          ParentFont = False
        end
        object PromMemoSecaoVenda: TfrxMemoView
          AllowVectorExport = True
          Top = 128.504020000000000000
          Width = 642.519636220000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clGray
          Memo.UTF8W = (
            ' DADOS DA VENDA')
          ParentFont = False
        end
        object PromMemoVenCodigo: TfrxMemoView
          AllowVectorExport = True
          Top = 147.401650000000000000
          Width = 132.283460000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Codigo: [frxVenda."CODIGO"]')
          ParentFont = False
        end
        object PromMemoVenData: TfrxMemoView
          AllowVectorExport = True
          Left = 136.063080000000000000
          Top = 147.401650000000000000
          Width = 260.787370000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Data: [frxVenda."DATA_HORA_VENDA"]')
          ParentFont = False
        end
        object PromMemoVenTotal: TfrxMemoView
          AllowVectorExport = True
          Left = 404.409430000000000000
          Top = 147.401650000000000000
          Width = 234.330680000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Total: [frxVenda."TOTAL_LIQUIDO"]')
          ParentFont = False
        end
        object PromMemoSecaoItens: TfrxMemoView
          AllowVectorExport = True
          Top = 170.078850000000000000
          Width = 642.519636220000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Fill.BackColor = clGray
          Memo.UTF8W = (
            ' ITENS DA VENDA')
          ParentFont = False
        end
        object PromMemoCabCod: TfrxMemoView
          AllowVectorExport = True
          Top = 207.874020000000000000
          Width = 56.692910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Codigo')
          ParentFont = False
          VAlign = vaCenter
        end
        object PromMemoCabDesc: TfrxMemoView
          AllowVectorExport = True
          Left = 56.692910000000000000
          Top = 207.874020000000000000
          Width = 226.771650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Descricao')
          ParentFont = False
          VAlign = vaCenter
        end
        object PromMemoCabUnit: TfrxMemoView
          AllowVectorExport = True
          Left = 283.464570000000000000
          Top = 207.874020000000000000
          Width = 75.590550000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'V. Unit.')
          ParentFont = False
          VAlign = vaCenter
        end
        object PromMemoCabQtd: TfrxMemoView
          AllowVectorExport = True
          Left = 359.055120000000000000
          Top = 207.874020000000000000
          Width = 56.692910000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Qtd')
          ParentFont = False
          VAlign = vaCenter
        end
        object PromMemoCabAcr: TfrxMemoView
          AllowVectorExport = True
          Left = 415.748030000000000000
          Top = 207.874020000000000000
          Width = 60.472430000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Acresc.')
          ParentFont = False
          VAlign = vaCenter
        end
        object PromMemoCabDes: TfrxMemoView
          AllowVectorExport = True
          Left = 475.999990000000000000
          Top = 207.874020000000000000
          Width = 56.692900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Desc.')
          ParentFont = False
          VAlign = vaCenter
        end
        object PromMemoCabTot: TfrxMemoView
          AllowVectorExport = True
          Left = 532.929130000000000000
          Top = 207.874020000000000000
          Width = 109.606270000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Total')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PromMasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 381.732530000000000000
        Width = 642.520100000000000000
        DataSet = frxItensVenda
        DataSetName = 'ibqVendaItem'
        RowCount = 0
        object PromMemoItemCod: TfrxMemoView
          AllowVectorExport = True
          Width = 56.692910000000000000
          Height = 18.897650000000000000
          DataField = 'CODIGO_PRODUTO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ibqVendaItem."CODIGO_PRODUTO"]')
          ParentFont = False
        end
        object PromMemoItemDesc: TfrxMemoView
          AllowVectorExport = True
          Left = 56.692910000000000000
          Width = 226.771650000000000000
          Height = 18.897650000000000000
          DataField = 'DESCRICAO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Memo.UTF8W = (
            '[ibqVendaItem."DESCRICAO"]')
          ParentFont = False
        end
        object PromMemoItemUnit: TfrxMemoView
          AllowVectorExport = True
          Left = 283.464570000000000000
          Width = 75.590550000000000000
          Height = 18.897650000000000000
          DataField = 'PRECO_UNITARIO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ibqVendaItem."PRECO_UNITARIO"]')
          ParentFont = False
        end
        object PromMemoItemQtd: TfrxMemoView
          AllowVectorExport = True
          Left = 359.055120000000000000
          Width = 56.692910000000000000
          Height = 18.897650000000000000
          DataField = 'QUANTIDADE'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ibqVendaItem."QUANTIDADE"]')
          ParentFont = False
        end
        object PromMemoItemAcr: TfrxMemoView
          AllowVectorExport = True
          Left = 415.748030000000000000
          Width = 60.472430000000000000
          Height = 18.897650000000000000
          DataField = 'ACRESCIMO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ibqVendaItem."ACRESCIMO"]')
          ParentFont = False
        end
        object PromMemoItemDes: TfrxMemoView
          AllowVectorExport = True
          Left = 477.338580000000000000
          Width = 52.913370000000000000
          Height = 18.897650000000000000
          DataField = 'DESCONTO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ibqVendaItem."DESCONTO"]')
          ParentFont = False
        end
        object PromMemoItemTot: TfrxMemoView
          AllowVectorExport = True
          Left = 530.929130000000000000
          Width = 109.606270000000000000
          Height = 18.897650000000000000
          DataField = 'TOTAL_LIQUIDO'
          DataSet = frxItensVenda
          DataSetName = 'ibqVendaItem'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[ibqVendaItem."TOTAL_LIQUIDO"]')
          ParentFont = False
        end
      end
      object PromPageFooter1: TfrxPageFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 151.181100000000000000
        Top = 461.102660000000000000
        Width = 642.520100000000000000
        object PromMemoTotalGeral: TfrxMemoView
          AllowVectorExport = True
          Top = 7.559060000000000000
          Width = 642.519636220000000000
          Height = 22.677180000000000000
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL DA VENDA: [frxVenda."TOTAL_LIQUIDO"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object PromMemoLocalData: TfrxMemoView
          AllowVectorExport = True
          Top = 41.574800000000000000
          Width = 718.110236220000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            
              'Local e data: _________________________________, _____/_____/___' +
              '_______')
          ParentFont = False
        end
        object PromMemoLinhaAssinatura: TfrxMemoView
          AllowVectorExport = True
          Left = 121.000000000000000000
          Top = 79.370080000000000000
          Width = 418.110240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object PromMemoAssinatura: TfrxMemoView
          AllowVectorExport = True
          Left = 121.000000000000000000
          Top = 98.267720000000000000
          Width = 418.110240000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Assinatura do Cliente - [frxCliente."NOME"]')
          ParentFont = False
        end
        object PromMemoPagina: TfrxMemoView
          AllowVectorExport = True
          Top = 128.504020000000000000
          Width = 638.740106220000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -8
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina [Page] de [TotalPages] | Impresso em [Date] [Time]')
          ParentFont = False
        end
      end
    end
  end
  object ibqVendaLog: TIBQuery
    Database = dmConexao.IBDConexao
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = dsVenda
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT V.CODIGO COD_VENDA, LE.CODIGO_VENDA_ITEM, LE.CODIGO_PRODU' +
        'TO, LE.DATA_HORA, LE.ESTOQUE_ENTRADA, LE.ESTOQUE_SAIDA'
      'FROM VENDA V'
      '  JOIN VENDA_ITEM VI ON VI.CODIGO_VENDA = V.CODIGO'
      '  JOIN PRODUTO P ON P.CODIGO = VI.CODIGO_PRODUTO'
      
        '  LEFT JOIN LOG_ESTOQUE LE ON LE.CODIGO_VENDA_ITEM = VI.CODIGO A' +
        'ND LE.CODIGO_PRODUTO = P.CODIGO'
      'WHERE V.CODIGO = :CODIGO')
    PrecommittedReads = False
    Left = 408
    Top = 311
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object ibqVendaLogCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
      Origin = 'VENDA.CODIGO'
      Required = True
    end
    object ibqVendaLogCODIGO_VENDA_ITEM: TIntegerField
      FieldName = 'CODIGO_VENDA_ITEM'
      Origin = 'LOG_ESTOQUE.CODIGO_VENDA_ITEM'
    end
    object ibqVendaLogCODIGO_PRODUTO: TIntegerField
      FieldName = 'CODIGO_PRODUTO'
      Origin = 'LOG_ESTOQUE.CODIGO_PRODUTO'
    end
    object ibqVendaLogDATA_HORA: TDateTimeField
      FieldName = 'DATA_HORA'
      Origin = 'LOG_ESTOQUE.DATA_HORA'
    end
    object ibqVendaLogESTOQUE_ENTRADA: TIBBCDField
      FieldName = 'ESTOQUE_ENTRADA'
      Origin = 'LOG_ESTOQUE.ESTOQUE_ENTRADA'
      Precision = 18
      Size = 3
    end
    object ibqVendaLogESTOQUE_SAIDA: TIBBCDField
      FieldName = 'ESTOQUE_SAIDA'
      Origin = 'LOG_ESTOQUE.ESTOQUE_SAIDA'
      Precision = 18
      Size = 3
    end
  end
  object dsVendaPagamento: TDataSource
    DataSet = ibqVendaPagamento
    Left = 592
    Top = 368
  end
  object ibqVendaPagamento: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionVenda
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = dsVenda
    ParamCheck = True
    SQL.Strings = (
      'SELECT VP.CODIGO, VP.CODIGO_FORMA_PAGAMENTO, FP.DESCRICAO,'
      '  VP.VALOR, VP.PARCELAS, VP.VENCIMENTO'
      'FROM VENDA_PAGAMENTO VP'
      
        '  JOIN FORMA_PAGAMENTO FP ON FP.CODIGO = VP.CODIGO_FORMA_PAGAMEN' +
        'TO'
      'WHERE VP.CODIGO_VENDA = :CODIGO'
      'ORDER BY VP.CODIGO')
    PrecommittedReads = False
    Left = 704
    Top = 360
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CODIGO'
        ParamType = ptUnknown
        Size = 4
      end>
    object ibqVendaPagamentoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'VENDA_PAGAMENTO.CODIGO'
    end
    object ibqVendaPagamentoCODIGO_FORMA_PAGAMENTO: TIntegerField
      FieldName = 'CODIGO_FORMA_PAGAMENTO'
      Origin = 'VENDA_PAGAMENTO.CODIGO_FORMA_PAGAMENTO'
    end
    object ibqVendaPagamentoDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'FORMA_PAGAMENTO.DESCRICAO'
      Size = 60
    end
    object ibqVendaPagamentoVALOR: TIBBCDField
      FieldName = 'VALOR'
      Origin = 'VENDA_PAGAMENTO.VALOR'
      currency = True
      Precision = 18
      Size = 2
    end
    object ibqVendaPagamentoPARCELAS: TIntegerField
      FieldName = 'PARCELAS'
      Origin = 'VENDA_PAGAMENTO.PARCELAS'
    end
    object ibqVendaPagamentoVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
      Origin = 'VENDA_PAGAMENTO.VENCIMENTO'
    end
  end
end
