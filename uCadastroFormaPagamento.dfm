inherited frmCadastroFormaPagamento: TfrmCadastroFormaPagamento
  Caption = 'Cadastro de Forma de Pagamento'
  ClientHeight = 250
  ClientWidth = 520
  StyleElements = [seFont, seClient, seBorder]
  OnActivate = FormActivate
  ExplicitWidth = 536
  ExplicitHeight = 289
  TextHeight = 15
  inherited pCampos: TPanel
    Width = 520
    Height = 204
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 520
    ExplicitHeight = 204
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
    object lDiasCompensacao: TLabel
      Left = 16
      Top = 120
      Width = 96
      Height = 15
      Alignment = taRightJustify
      Caption = 'Dias Compensa'#231#227'o :'
      FocusControl = dbeDiasCompensacao
    end
    object dbeCodigo: TDBEdit
      Left = 118
      Top = 13
      Width = 100
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
      Width = 370
      Height = 23
      DataField = 'DESCRICAO'
      DataSource = dsCadastro
      TabOrder = 1
    end
    object dbcEntraCaixaImediato: TDBCheckBox
      Left = 118
      Top = 72
      Width = 160
      Height = 17
      Caption = 'Entra no caixa imediato'
      DataField = 'ENTRA_CAIXA_IMEDIATO'
      DataSource = dsCadastro
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbcGeraTitulo: TDBCheckBox
      Left = 300
      Top = 72
      Width = 100
      Height = 17
      Caption = 'Gera t'#237'tulo'
      DataField = 'GERA_TITULO'
      DataSource = dsCadastro
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeDiasCompensacao: TDBEdit
      Left = 118
      Top = 117
      Width = 100
      Height = 23
      DataField = 'DIAS_COMPENSACAO'
      DataSource = dsCadastro
      TabOrder = 4
    end
    object dbcAtivo: TDBCheckBox
      Left = 118
      Top = 156
      Width = 100
      Height = 17
      Caption = 'Ativo'
      DataField = 'ATIVO'
      DataSource = dsCadastro
      TabOrder = 5
      ValueChecked = 'A'
      ValueUnchecked = 'I'
    end
  end
  inherited pBotoes: TPanel
    Top = 204
    Width = 520
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 204
    ExplicitWidth = 520
    inherited btnInserir: TButton
      Left = 158
      ExplicitLeft = 158
    end
    inherited btnEditar: TButton
      Left = 230
      ExplicitLeft = 230
    end
    inherited btnGravar: TButton
      Left = 301
      ExplicitLeft = 301
    end
    inherited btnCancelar: TButton
      Left = 372
      ExplicitLeft = 372
    end
    inherited btnExcluir: TButton
      Left = 443
      ExplicitLeft = 443
    end
    inherited btnImprimir: TButton
      Visible = False
    end
  end
  inherited IBTransaction: TIBTransaction
    DefaultDatabase = dmConexao.IBDConexao
  end
  inherited ibqCadastro: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransaction
    SQL.Strings = (
      'SELECT * FROM FORMA_PAGAMENTO WHERE CODIGO > 0 ORDER BY CODIGO')
    UpdateObject = IBUpdateSQLCadastro
    GeneratorField.Field = 'CODIGO'
    GeneratorField.Generator = 'GEN_FORMA_PAGAMENTO_ID'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 400
    Top = 104
    object ibqCadastroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      KeyFields = 'CODIGO'
      Origin = 'FORMA_PAGAMENTO.CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ibqCadastroDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'FORMA_PAGAMENTO.DESCRICAO'
      Required = True
      Size = 60
    end
    object ibqCadastroENTRA_CAIXA_IMEDIATO: TIBStringField
      FieldName = 'ENTRA_CAIXA_IMEDIATO'
      Origin = 'FORMA_PAGAMENTO.ENTRA_CAIXA_IMEDIATO'
      FixedChar = True
      Size = 1
    end
    object ibqCadastroGERA_TITULO: TIBStringField
      FieldName = 'GERA_TITULO'
      Origin = 'FORMA_PAGAMENTO.GERA_TITULO'
      FixedChar = True
      Size = 1
    end
    object ibqCadastroDIAS_COMPENSACAO: TIntegerField
      FieldName = 'DIAS_COMPENSACAO'
      Origin = 'FORMA_PAGAMENTO.DIAS_COMPENSACAO'
    end
    object ibqCadastroATIVO: TIBStringField
      FieldName = 'ATIVO'
      Origin = 'FORMA_PAGAMENTO.ATIVO'
      FixedChar = True
      Size = 1
    end
  end
  inherited IBUpdateSQLCadastro: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  CODIGO,'
      '  DESCRICAO,'
      '  ENTRA_CAIXA_IMEDIATO,'
      '  GERA_TITULO,'
      '  DIAS_COMPENSACAO,'
      '  ATIVO'
      'from FORMA_PAGAMENTO '
      'where'
      '  CODIGO = :CODIGO')
    ModifySQL.Strings = (
      'update FORMA_PAGAMENTO'
      'set'
      '  DESCRICAO = :DESCRICAO,'
      '  ENTRA_CAIXA_IMEDIATO = :ENTRA_CAIXA_IMEDIATO,'
      '  GERA_TITULO = :GERA_TITULO,'
      '  DIAS_COMPENSACAO = :DIAS_COMPENSACAO,'
      '  ATIVO = :ATIVO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'insert into FORMA_PAGAMENTO'
      
        '  (DESCRICAO, ENTRA_CAIXA_IMEDIATO, GERA_TITULO, DIAS_COMPENSACA' +
        'O, ATIVO)'
      'values'
      
        '  (:DESCRICAO, :ENTRA_CAIXA_IMEDIATO, :GERA_TITULO, :DIAS_COMPENS' +
        'ACAO, :ATIVO)')
    DeleteSQL.Strings = (
      'delete from FORMA_PAGAMENTO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    Top = 112
  end
end
