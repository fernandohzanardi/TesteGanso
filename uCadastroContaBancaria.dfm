inherited frmCadastroContaBancaria: TfrmCadastroContaBancaria
  Caption = 'Cadastro de Conta Banc'#225'ria'
  ClientHeight = 280
  ClientWidth = 520
  StyleElements = [seFont, seClient, seBorder]
  OnActivate = FormActivate
  ExplicitWidth = 536
  ExplicitHeight = 319
  TextHeight = 15
  inherited pCampos: TPanel
    Width = 520
    Height = 234
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 520
    ExplicitHeight = 234
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
    object lBanco: TLabel
      Left = 73
      Top = 68
      Width = 39
      Height = 15
      Alignment = taRightJustify
      Caption = 'Banco :'
      FocusControl = dbeBanco
    end
    object lAgencia: TLabel
      Left = 64
      Top = 94
      Width = 48
      Height = 15
      Alignment = taRightJustify
      Caption = 'Ag'#234'ncia :'
      FocusControl = dbeAgencia
    end
    object lNumeroConta: TLabel
      Left = 30
      Top = 120
      Width = 82
      Height = 15
      Alignment = taRightJustify
      Caption = 'N'#250'mero Conta :'
      FocusControl = dbeNumeroConta
    end
    object lSaldoInicial: TLabel
      Left = 40
      Top = 146
      Width = 72
      Height = 15
      Alignment = taRightJustify
      Caption = 'Saldo Inicial :'
      FocusControl = dbeSaldoInicial
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
    object dbeBanco: TDBEdit
      Left = 118
      Top = 65
      Width = 250
      Height = 23
      DataField = 'BANCO'
      DataSource = dsCadastro
      TabOrder = 2
    end
    object dbeAgencia: TDBEdit
      Left = 118
      Top = 91
      Width = 120
      Height = 23
      DataField = 'AGENCIA'
      DataSource = dsCadastro
      TabOrder = 3
    end
    object dbeNumeroConta: TDBEdit
      Left = 118
      Top = 117
      Width = 180
      Height = 23
      DataField = 'NUMERO_CONTA'
      DataSource = dsCadastro
      TabOrder = 4
    end
    object dbeSaldoInicial: TDBEdit
      Left = 118
      Top = 143
      Width = 120
      Height = 23
      DataField = 'SALDO_INICIAL'
      DataSource = dsCadastro
      TabOrder = 5
    end
    object dbcAtivo: TDBCheckBox
      Left = 118
      Top = 180
      Width = 100
      Height = 17
      Caption = 'Ativo'
      DataField = 'ATIVO'
      DataSource = dsCadastro
      TabOrder = 6
      ValueChecked = 'A'
      ValueUnchecked = 'I'
    end
  end
  inherited pBotoes: TPanel
    Top = 234
    Width = 520
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 234
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
      'SELECT * FROM CONTA_BANCARIA WHERE CODIGO > 0 ORDER BY CODIGO')
    UpdateObject = IBUpdateSQLCadastro
    GeneratorField.Field = 'CODIGO'
    GeneratorField.Generator = 'GEN_CONTA_BANCARIA_ID'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 400
    Top = 104
    object ibqCadastroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      KeyFields = 'CODIGO'
      Origin = 'CONTA_BANCARIA.CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ibqCadastroDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'CONTA_BANCARIA.DESCRICAO'
      Required = True
      Size = 60
    end
    object ibqCadastroBANCO: TIBStringField
      FieldName = 'BANCO'
      Origin = 'CONTA_BANCARIA.BANCO'
      Size = 40
    end
    object ibqCadastroAGENCIA: TIBStringField
      FieldName = 'AGENCIA'
      Origin = 'CONTA_BANCARIA.AGENCIA'
      Size = 20
    end
    object ibqCadastroNUMERO_CONTA: TIBStringField
      FieldName = 'NUMERO_CONTA'
      Origin = 'CONTA_BANCARIA.NUMERO_CONTA'
      Size = 30
    end
    object ibqCadastroSALDO_INICIAL: TIBBCDField
      FieldName = 'SALDO_INICIAL'
      Origin = 'CONTA_BANCARIA.SALDO_INICIAL'
      currency = True
      Precision = 15
      Size = 2
    end
    object ibqCadastroATIVO: TIBStringField
      FieldName = 'ATIVO'
      Origin = 'CONTA_BANCARIA.ATIVO'
      FixedChar = True
      Size = 1
    end
  end
  inherited IBUpdateSQLCadastro: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  CODIGO,'
      '  DESCRICAO,'
      '  BANCO,'
      '  AGENCIA,'
      '  NUMERO_CONTA,'
      '  SALDO_INICIAL,'
      '  ATIVO'
      'from CONTA_BANCARIA '
      'where'
      '  CODIGO = :CODIGO')
    ModifySQL.Strings = (
      'update CONTA_BANCARIA'
      'set'
      '  DESCRICAO = :DESCRICAO,'
      '  BANCO = :BANCO,'
      '  AGENCIA = :AGENCIA,'
      '  NUMERO_CONTA = :NUMERO_CONTA,'
      '  SALDO_INICIAL = :SALDO_INICIAL,'
      '  ATIVO = :ATIVO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'insert into CONTA_BANCARIA'
      
        '  (DESCRICAO, BANCO, AGENCIA, NUMERO_CONTA, SALDO_INICIAL, ATIVO' +
        ')'
      'values'
      
        '  (:DESCRICAO, :BANCO, :AGENCIA, :NUMERO_CONTA, :SALDO_INICIAL, :' +
        'ATIVO)')
    DeleteSQL.Strings = (
      'delete from CONTA_BANCARIA'
      'where'
      '  CODIGO = :OLD_CODIGO')
    Top = 112
  end
end
