inherited frmCadastroCentroCusto: TfrmCadastroCentroCusto
  Caption = 'Cadastro de Centro de Custo'
  ClientHeight = 200
  ClientWidth = 520
  StyleElements = [seFont, seClient, seBorder]
  OnActivate = FormActivate
  ExplicitWidth = 536
  ExplicitHeight = 239
  TextHeight = 15
  inherited pCampos: TPanel
    Width = 520
    Height = 154
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 520
    ExplicitHeight = 154
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
    object dbcAtivo: TDBCheckBox
      Left = 118
      Top = 80
      Width = 100
      Height = 17
      Caption = 'Ativo'
      DataField = 'ATIVO'
      DataSource = dsCadastro
      TabOrder = 2
      ValueChecked = 'A'
      ValueUnchecked = 'I'
    end
  end
  inherited pBotoes: TPanel
    Top = 154
    Width = 520
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 154
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
      'SELECT * FROM CENTRO_CUSTO WHERE CODIGO > 0 ORDER BY CODIGO')
    UpdateObject = IBUpdateSQLCadastro
    GeneratorField.Field = 'CODIGO'
    GeneratorField.Generator = 'GEN_CENTRO_CUSTO_ID'
    GeneratorField.ApplyEvent = gamOnServer
    Left = 400
    Top = 80
    object ibqCadastroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      KeyFields = 'CODIGO'
      Origin = 'CENTRO_CUSTO.CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ibqCadastroDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'CENTRO_CUSTO.DESCRICAO'
      Required = True
      Size = 60
    end
    object ibqCadastroATIVO: TIBStringField
      FieldName = 'ATIVO'
      Origin = 'CENTRO_CUSTO.ATIVO'
      FixedChar = True
      Size = 1
    end
  end
  inherited IBUpdateSQLCadastro: TIBUpdateSQL
    RefreshSQL.Strings = (
      'Select '
      '  CODIGO,'
      '  DESCRICAO,'
      '  ATIVO'
      'from CENTRO_CUSTO '
      'where'
      '  CODIGO = :CODIGO')
    ModifySQL.Strings = (
      'update CENTRO_CUSTO'
      'set'
      '  DESCRICAO = :DESCRICAO,'
      '  ATIVO = :ATIVO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    InsertSQL.Strings = (
      'insert into CENTRO_CUSTO'
      '  (DESCRICAO, ATIVO)'
      'values'
      '  (:DESCRICAO, :ATIVO)')
    DeleteSQL.Strings = (
      'delete from CENTRO_CUSTO'
      'where'
      '  CODIGO = :OLD_CODIGO')
    Top = 88
  end
end
