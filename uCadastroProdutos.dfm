inherited frmCadastroProdutos: TfrmCadastroProdutos
  Caption = 'Cadastro de Produtos'
  ClientHeight = 448
  ClientWidth = 774
  OnActivate = FormActivate
  ExplicitWidth = 790
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 15
  inherited pCampos: TPanel
    Width = 774
    Height = 402
    ExplicitWidth = 774
    ExplicitHeight = 402
    object lCodigo: TLabel
      Left = 67
      Top = 16
      Width = 45
      Height = 15
      Alignment = taRightJustify
      Caption = 'C'#243'digo :'
      FocusControl = dbeCodigo
    end
    object lDescricao: TLabel
      Left = 55
      Top = 42
      Width = 57
      Height = 15
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o :'
      FocusControl = dbeDescricao
    end
    object lReferencia: TLabel
      Left = 51
      Top = 68
      Width = 61
      Height = 15
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia :'
      FocusControl = dbeReferencia
    end
    object lCodigoBarras: TLabel
      Left = 16
      Top = 94
      Width = 96
      Height = 15
      Alignment = taRightJustify
      Caption = 'C'#243'digo de Barras :'
      FocusControl = dbeCodigoBarras
    end
    object lMarca: TLabel
      Left = 73
      Top = 121
      Width = 39
      Height = 15
      Alignment = taRightJustify
      Caption = 'Marca :'
      FocusControl = dbeMarca
    end
    object lGrupo: TLabel
      Left = 73
      Top = 148
      Width = 39
      Height = 15
      Alignment = taRightJustify
      Caption = 'Grupo :'
      FocusControl = dbeGrupo
    end
    object lValorCusto: TLabel
      Left = 30
      Top = 175
      Width = 82
      Height = 15
      Alignment = taRightJustify
      Caption = 'Valor de Custo :'
      FocusControl = dbeValorCusto
    end
    object lPercLucro: TLabel
      Left = 234
      Top = 175
      Width = 65
      Height = 15
      Alignment = taRightJustify
      Caption = '% de Lucro :'
    end
    object lPrecoVenda: TLabel
      Left = 395
      Top = 175
      Width = 71
      Height = 15
      Alignment = taRightJustify
      Caption = 'Pre'#231'o Venda :'
      FocusControl = dbePrecoVenda
    end
    object lEstoqueAtual: TLabel
      Left = 33
      Top = 204
      Width = 79
      Height = 15
      Alignment = taRightJustify
      Caption = 'Estoque Atual :'
      FocusControl = dbeEstoqueAtual
    end
    object LVendido: TLabel
      Left = 389
      Top = 213
      Width = 78
      Height = 15
      Alignment = taRightJustify
      Caption = 'Qtde Vendido :'
      FocusControl = dbePrecoVenda
    end
    object dbeCodigo: TDBEdit
      Left = 118
      Top = 13
      Width = 154
      Height = 23
      Color = clBtnFace
      DataField = 'CODIGO'
      DataSource = dsCadastro
      Enabled = False
      TabOrder = 0
    end
    object dbeDescricao: TDBEdit
      Left = 118
      Top = 39
      Width = 454
      Height = 23
      DataField = 'DESCRICAO'
      DataSource = dsCadastro
      TabOrder = 1
    end
    object dbeReferencia: TDBEdit
      Left = 118
      Top = 65
      Width = 154
      Height = 23
      DataField = 'REFERENCIA'
      DataSource = dsCadastro
      MaxLength = 30
      TabOrder = 2
    end
    object dbeCodigoBarras: TDBEdit
      Left = 118
      Top = 91
      Width = 229
      Height = 23
      DataField = 'CODIGO_BARRAS'
      DataSource = dsCadastro
      MaxLength = 30
      TabOrder = 3
    end
    object dbeMarca: TDBEdit
      Left = 118
      Top = 118
      Width = 454
      Height = 23
      DataField = 'MARCA'
      DataSource = dsCadastro
      TabOrder = 4
    end
    object dbeGrupo: TDBEdit
      Left = 118
      Top = 145
      Width = 454
      Height = 23
      DataField = 'GRUPO'
      DataSource = dsCadastro
      TabOrder = 5
    end
    object dbeValorCusto: TDBEdit
      Left = 118
      Top = 172
      Width = 100
      Height = 23
      DataField = 'VALOR_CUSTO'
      DataSource = dsCadastro
      TabOrder = 6
      OnChange = dbeValorCustoChange
    end
    object ePercLucro: TEdit
      Left = 305
      Top = 172
      Width = 80
      Height = 23
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
    end
    object dbePrecoVenda: TDBEdit
      Left = 472
      Top = 172
      Width = 100
      Height = 23
      DataField = 'PRECO_VENDA'
      DataSource = dsCadastro
      TabOrder = 7
      OnChange = dbePrecoVendaChange
    end
    object dbeEstoqueAtual: TDBEdit
      Left = 118
      Top = 201
      Width = 100
      Height = 23
      DataField = 'ESTOQUE_ATUAL'
      DataSource = dsCadastro
      TabOrder = 8
    end
    object EqtdeVenda: TEdit
      Left = 472
      Top = 210
      Width = 100
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 14
    end
    object Edit1: TEdit
      Left = 296
      Top = 10
      Width = 121
      Height = 23
      TabOrder = 11
      Text = 'Edit1'
    end
    object btnTeste: TButton
      Left = 497
      Top = 239
      Width = 75
      Height = 25
      Caption = 'Show Teste'
      TabOrder = 12
      OnClick = btnTesteClick
    end
    object DBGrid1: TDBGrid
      Left = 43
      Top = 280
      Width = 529
      Height = 97
      DataSource = DataSource1
      TabOrder = 13
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
    object Button1: TButton
      Left = 143
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 10
    end
  end
  inherited pBotoes: TPanel
    Top = 402
    Width = 774
    ExplicitTop = 402
    ExplicitWidth = 774
    inherited btnInserir: TButton
      Left = 412
      ExplicitLeft = 412
    end
    inherited btnEditar: TButton
      Left = 484
      ExplicitLeft = 484
    end
    inherited btnGravar: TButton
      Left = 555
      ExplicitLeft = 555
    end
    inherited btnCancelar: TButton
      Left = 626
      ExplicitLeft = 626
    end
    inherited btnExcluir: TButton
      Left = 697
      ExplicitLeft = 697
    end
    inherited btnImprimir: TButton
      Left = 875
      Visible = False
      ExplicitLeft = 875
    end
    object btnQtdeVendido: TButton
      Left = 229
      Top = 12
      Width = 94
      Height = 25
      Caption = 'Atualizar Qtde'
      TabOrder = 10
      OnClick = btnQtdeVendidoClick
    end
    object btnExibeMensagem: TButton
      Left = 329
      Top = 11
      Width = 75
      Height = 25
      Caption = 'Mensagem'
      TabOrder = 11
      OnClick = btnExibeMensagemClick
    end
  end
  inherited ibqCadastro: TIBQuery
    SQL.Strings = (
      'SELECT P.*'
      'FROM PRODUTO P'
      'WHERE P.CODIGO > 0')
    GeneratorField.Field = 'CODIGO'
    GeneratorField.Generator = 'GEN_PRODUTO_ID'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 400
    Top = 104
    object ibqCadastroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      KeyFields = 'CODIGO'
      Origin = 'PRODUTO.CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ibqCadastroDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'PRODUTO.DESCRICAO'
      Required = True
      Size = 60
    end
    object ibqCadastroREFERENCIA: TIBStringField
      FieldName = 'REFERENCIA'
      Origin = 'PRODUTO.REFERENCIA'
      Size = 10
    end
    object ibqCadastroCODIGO_BARRAS: TLargeintField
      FieldName = 'CODIGO_BARRAS'
      Origin = 'PRODUTO.CODIGO_BARRAS'
    end
    object ibqCadastroMARCA: TIBStringField
      FieldName = 'MARCA'
      Origin = 'PRODUTO.MARCA'
      Size = 30
    end
    object ibqCadastroGRUPO: TIBStringField
      FieldName = 'GRUPO'
      Origin = 'PRODUTO.GRUPO'
      Size = 30
    end
    object ibqCadastroPRECO_VENDA: TIBBCDField
      FieldName = 'PRECO_VENDA'
      Origin = 'PRODUTO.PRECO_VENDA'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object ibqCadastroESTOQUE_ATUAL: TIBBCDField
      FieldName = 'ESTOQUE_ATUAL'
      Origin = 'PRODUTO.ESTOQUE_ATUAL'
      Precision = 18
      Size = 3
    end
    object ibqCadastroVALOR_CUSTO: TIBBCDField
      FieldName = 'VALOR_CUSTO'
      Origin = 'PRODUTO.VALOR_CUSTO'
      currency = True
      Precision = 15
      Size = 2
    end
  end
  inherited IBUpdateSQLCadastro: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  CODIGO,'
      '  DESCRICAO,'
      '  REFERENCIA,'
      '  CODIGO_BARRAS,'
      '  MARCA,'
      '  GRUPO,'
      '  PRECO_VENDA,'
      '  ESTOQUE_ATUAL,'
      '  VALOR_CUSTO'
      'from PRODUTO '
      'where'
      '  CODIGO = :CODIGO')
    ModifySQL.Strings = (
      'update PRODUTO'
      'set'
      '  DESCRICAO = :DESCRICAO,'
      '  REFERENCIA = :REFERENCIA,'
      '  CODIGO_BARRAS = :CODIGO_BARRAS,'
      '  MARCA = :MARCA,'
      '  GRUPO = :GRUPO,'
      '  PRECO_VENDA = :PRECO_VENDA,'
      '  ESTOQUE_ATUAL = :ESTOQUE_ATUAL,'
      '  VALOR_CUSTO = :VALOR_CUSTO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'insert into PRODUTO'
      
        '  (DESCRICAO, REFERENCIA, CODIGO_BARRAS, MARCA, GRUPO, PRECO_VEN' +
        'DA, ESTOQUE_ATUAL, VALOR_CUSTO)'
      'values'
      
        '  (:DESCRICAO, :REFERENCIA, :CODIGO_BARRAS, :MARCA, :GRUPO, :PRE' +
        'CO_VENDA, '
      '   :ESTOQUE_ATUAL, :VALOR_CUSTO)')
    DeleteSQL.Strings = (
      'delete from PRODUTO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    Top = 112
  end
  object ibConsultaQtdeVendas: TIBQuery
    Database = dmConexao.IBDConexao
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select count(*) qtde_venda'
      'from venda v'
      '  join venda_item vi on vi.codigo_venda = v.codigo'
      '  join produto p on p.codigo = vi.codigo_produto'
      'where p.codigo = :codigo')
    PrecommittedReads = False
    Left = 224
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
    object ibConsultaQtdeVendasQTDE_VENDA: TIntegerField
      FieldName = 'QTDE_VENDA'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object IBQuery1: TIBQuery
    Database = dmConexao.IBDConexao
    BufferChunks = 1000
    CachedUpdates = False
    DataSource = dsCadastro
    ParamCheck = True
    SQL.Strings = (
      
        'SELECT C.CODIGO, C.NOME, C.TELEFONE, V.CODIGO, V.DATA_HORA_VENDA' +
        ', V.TOTAL_LIQUIDO'
      'FROM VENDA V'
      '  LEFT JOIN VENDA_ITEM VI ON VI.CODIGO_VENDA = V.CODIGO'
      '  LEFT JOIN PRODUTO P ON P.CODIGO = VI.CODIGO_PRODUTO'
      '  LEFT JOIN CLIENTE C ON C.CODIGO = V.CODIGO_CLIENTE'
      'WHERE V.DATA_HORA_VENDA BETWEEN :DINI AND :DFIM')
    PrecommittedReads = False
    Left = 264
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DIni'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DFim'
        ParamType = ptUnknown
      end>
    object IBQuery1CODIGO: TIntegerField
      FieldName = 'CODIGO'
      Origin = 'VENDA.CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IBQuery1DATA_HORA_VENDA: TDateTimeField
      FieldName = 'DATA_HORA_VENDA'
      Origin = 'VENDA.DATA_HORA_VENDA'
    end
    object IBQuery1TOTAL_LIQUIDO: TIBBCDField
      FieldName = 'TOTAL_LIQUIDO'
      Origin = 'VENDA.TOTAL_LIQUIDO'
      Precision = 18
      Size = 2
    end
    object IBQuery1NOME: TIBStringField
      FieldName = 'NOME'
      Origin = 'CLIENTE.NOME'
      Size = 60
    end
    object IBQuery1TELEFONE: TIBStringField
      FieldName = 'TELEFONE'
      Origin = 'CLIENTE.TELEFONE'
      Size = 16
    end
    object IBQuery1CODIGO1: TIntegerField
      FieldName = 'CODIGO1'
      Origin = 'VENDA.CODIGO'
      Required = True
    end
  end
  object DataSource1: TDataSource
    DataSet = IBQuery1
    Left = 608
    Top = 208
  end
end
