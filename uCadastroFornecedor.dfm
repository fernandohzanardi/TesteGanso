inherited frmCadastroFornecedor: TfrmCadastroFornecedor
  Caption = 'Cadastro de Fornecedor'
  ClientHeight = 230
  ClientWidth = 520
  StyleElements = [seFont, seClient, seBorder]
  OnActivate = FormActivate
  ExplicitWidth = 536
  ExplicitHeight = 269
  TextHeight = 15
  inherited pCampos: TPanel
    Width = 520
    Height = 184
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 520
    ExplicitHeight = 184
    object lCodigo: TLabel
      Left = 67
      Top = 16
      Width = 45
      Height = 15
      Alignment = taRightJustify
      Caption = 'C'#243'digo :'
      FocusControl = dbeCodigo
    end
    object lNome: TLabel
      Left = 73
      Top = 42
      Width = 39
      Height = 15
      Alignment = taRightJustify
      Caption = 'Nome :'
      FocusControl = dbeNome
    end
    object lTelefone: TLabel
      Left = 61
      Top = 68
      Width = 51
      Height = 15
      Alignment = taRightJustify
      Caption = 'Telefone :'
      FocusControl = dbeTelefone
    end
    object lEmail: TLabel
      Left = 72
      Top = 94
      Width = 40
      Height = 15
      Alignment = taRightJustify
      Caption = 'E-mail :'
      FocusControl = dbeEmail
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
    object dbeNome: TDBEdit
      Left = 118
      Top = 39
      Width = 370
      Height = 23
      DataField = 'NOME'
      DataSource = dsCadastro
      TabOrder = 1
    end
    object dbeTelefone: TDBEdit
      Left = 118
      Top = 65
      Width = 180
      Height = 23
      DataField = 'TELEFONE'
      DataSource = dsCadastro
      TabOrder = 2
    end
    object dbeEmail: TDBEdit
      Left = 118
      Top = 91
      Width = 370
      Height = 23
      DataField = 'EMAIL'
      DataSource = dsCadastro
      TabOrder = 3
    end
    object dbcAtivo: TDBCheckBox
      Left = 118
      Top = 130
      Width = 100
      Height = 17
      Caption = 'Ativo'
      DataField = 'ATIVO'
      DataSource = dsCadastro
      TabOrder = 4
      ValueChecked = 'A'
      ValueUnchecked = 'I'
    end
  end
  inherited pBotoes: TPanel
    Top = 184
    Width = 520
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 184
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
      'SELECT * FROM FORNECEDOR WHERE CODIGO > 0 ORDER BY CODIGO')
    UpdateObject = IBUpdateSQLCadastro
    GeneratorField.Field = 'CODIGO'
    GeneratorField.Generator = 'GEN_FORNECEDOR_ID'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 400
    Top = 80
    object ibqCadastroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      KeyFields = 'CODIGO'
      Origin = 'FORNECEDOR.CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ibqCadastroNOME: TIBStringField
      FieldName = 'NOME'
      Origin = 'FORNECEDOR.NOME'
      Required = True
      Size = 100
    end
    object ibqCadastroTELEFONE: TIBStringField
      FieldName = 'TELEFONE'
      Origin = 'FORNECEDOR.TELEFONE'
      Size = 20
    end
    object ibqCadastroEMAIL: TIBStringField
      FieldName = 'EMAIL'
      Origin = 'FORNECEDOR.EMAIL'
      Size = 100
    end
    object ibqCadastroATIVO: TIBStringField
      FieldName = 'ATIVO'
      Origin = 'FORNECEDOR.ATIVO'
      FixedChar = True
      Size = 1
    end
  end
  inherited IBUpdateSQLCadastro: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  CODIGO,'
      '  NOME,'
      '  TELEFONE,'
      '  EMAIL,'
      '  ATIVO'
      'from FORNECEDOR '
      'where'
      '  CODIGO = :CODIGO')
    ModifySQL.Strings = (
      'update FORNECEDOR'
      'set'
      '  NOME = :NOME,'
      '  TELEFONE = :TELEFONE,'
      '  EMAIL = :EMAIL,'
      '  ATIVO = :ATIVO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'insert into FORNECEDOR'
      '  (NOME, TELEFONE, EMAIL, ATIVO)'
      'values'
      '  (:NOME, :TELEFONE, :EMAIL, :ATIVO)')
    DeleteSQL.Strings = (
      'delete from FORNECEDOR'
      'where'
      '  CODIGO = :OLD_CODIGO')
    Top = 88
  end
end
