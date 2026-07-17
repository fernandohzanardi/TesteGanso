inherited frmCadastroProdutos: TfrmCadastroProdutos
  Caption = 'Cadastro de Produtos'
  ClientHeight = 285
  ClientWidth = 586
  OnActivate = FormActivate
  ExplicitWidth = 602
  ExplicitHeight = 324
  PixelsPerInch = 96
  TextHeight = 15
  inherited pCampos: TPanel
    Width = 586
    Height = 239
    ExplicitWidth = 586
    ExplicitHeight = 239
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
    object ImCliente: TImage
      Left = 401
      Top = 11
      Width = 65
      Height = 46
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
      TabOrder = 10
    end
    object Edit1: TEdit
      Left = 296
      Top = 10
      Width = 121
      Height = 23
      TabOrder = 11
      Text = 'Edit1'
    end
  end
  inherited pBotoes: TPanel
    Top = 239
    Width = 586
    ExplicitTop = 239
    ExplicitWidth = 586
    inherited btnInserir: TButton
      Left = 224
      ExplicitLeft = 224
    end
    inherited btnEditar: TButton
      Left = 296
      ExplicitLeft = 296
    end
    inherited btnGravar: TButton
      Left = 367
      ExplicitLeft = 367
    end
    inherited btnCancelar: TButton
      Left = 438
      ExplicitLeft = 438
    end
    inherited btnExcluir: TButton
      Left = 509
      ExplicitLeft = 509
    end
    inherited btnImprimir: TButton
      Left = 687
      Visible = False
      ExplicitLeft = 687
    end
    object Button1: TButton
      Left = 143
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 10
    end
    object Button1: TButton
      Left = 131
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 10
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
    Left = 344
    Top = 200
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
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 376
    Top = 72
  end
end
