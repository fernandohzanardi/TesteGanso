object frmLogEnvioEmail: TfrmLogEnvioEmail
  Left = 0
  Top = 0
  Caption = 'Log de envio de e-mail'
  ClientHeight = 500
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
    Height = 96
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
    object lSituacao: TLabel
      Left = 380
      Top = 12
      Width = 48
      Height = 15
      Caption = 'Situa'#231#227'o:'
    end
    object lOrigem: TLabel
      Left = 540
      Top = 12
      Width = 43
      Height = 15
      Caption = 'Origem:'
    end
    object lCliente: TLabel
      Left = 720
      Top = 12
      Width = 80
      Height = 15
      Caption = 'C'#243'digo cliente:'
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
    object cbSituacao: TComboBox
      Left = 380
      Top = 32
      Width = 150
      Height = 23
      Style = csDropDownList
      TabOrder = 2
    end
    object cbOrigem: TComboBox
      Left = 540
      Top = 32
      Width = 170
      Height = 23
      TabOrder = 3
    end
    object eCodigoCliente: TEdit
      Left = 720
      Top = 32
      Width = 120
      Height = 23
      NumbersOnly = True
      TabOrder = 4
    end
    object btnConsultar: TButton
      Left = 12
      Top = 58
      Width = 130
      Height = 28
      Caption = 'Consultar (F5)'
      Default = True
      TabOrder = 5
      OnClick = btnConsultarClick
    end
    object btnLimpar: TButton
      Left = 150
      Top = 58
      Width = 90
      Height = 28
      Caption = 'Limpar'
      TabOrder = 6
      OnClick = btnLimparClick
    end
  end
  object dbgLog: TDBGrid
    Left = 0
    Top = 96
    Width = 900
    Height = 340
    Align = alClient
    DataSource = dsLog
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = dbgLogDrawColumnCell
    OnDblClick = dbgLogDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA_HORA_ENVIO'
        Title.Caption = 'Data / Hora'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESTINATARIO'
        Title.Caption = 'Destinat'#225'rio'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ASSUNTO'
        Title.Caption = 'Assunto'
        Width = 200
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SITUACAO'
        Title.Alignment = taCenter
        Title.Caption = 'Sit.'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORIGEM'
        Title.Caption = 'Origem'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CLIENTE'
        Title.Caption = 'Cliente'
        Width = 160
        Visible = True
      end>
  end
  object pRodape: TPanel
    Left = 0
    Top = 436
    Width = 900
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btnVerDetalhes: TButton
      Left = 12
      Top = 9
      Width = 120
      Height = 28
      Caption = 'Ver detalhes'
      TabOrder = 0
      OnClick = btnVerDetalhesClick
    end
    object btnExportarCSV: TButton
      Left = 138
      Top = 9
      Width = 120
      Height = 28
      Caption = 'Exportar CSV'
      TabOrder = 1
      OnClick = btnExportarCSVClick
    end
    object btnFechar: TButton
      Left = 770
      Top = 9
      Width = 120
      Height = 28
      Caption = 'Fechar'
      TabOrder = 2
      OnClick = btnFecharClick
    end
  end
  object stbStatus: TStatusBar
    Left = 0
    Top = 481
    Width = 900
    Height = 19
    Panels = <
      item
        Width = 140
      end
      item
        Width = 140
      end
      item
        Width = 140
      end>
  end
  object dsLog: TDataSource
    DataSet = ibqLog
    Left = 640
    Top = 168
  end
  object IBTransactionLog: TIBTransaction
    Active = True
    DefaultDatabase = dmConexao.IBDConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 560
    Top = 168
  end
  object ibqLog: TIBQuery
    Database = dmConexao.IBDConexao
    Transaction = IBTransactionLog
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    PrecommittedReads = False
    Left = 720
    Top = 168
    object ibqLogCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object ibqLogDESTINATARIO: TIBStringField
      FieldName = 'DESTINATARIO'
      Size = 100
    end
    object ibqLogREMETENTE: TIBStringField
      FieldName = 'REMETENTE'
      Size = 100
    end
    object ibqLogASSUNTO: TIBStringField
      FieldName = 'ASSUNTO'
      Size = 120
    end
    object ibqLogCORPO: TMemoField
      FieldName = 'CORPO'
      BlobType = ftMemo
    end
    object ibqLogSITUACAO: TIBStringField
      FieldName = 'SITUACAO'
      FixedChar = True
      Size = 1
    end
    object ibqLogMENSAGEM_ERRO: TIBStringField
      FieldName = 'MENSAGEM_ERRO'
      Size = 500
    end
    object ibqLogUSUARIO_SO: TIBStringField
      FieldName = 'USUARIO_SO'
      Size = 50
    end
    object ibqLogMAQUINA: TIBStringField
      FieldName = 'MAQUINA'
      Size = 50
    end
    object ibqLogORIGEM: TIBStringField
      FieldName = 'ORIGEM'
      Size = 30
    end
    object ibqLogCODIGO_CLIENTE: TIntegerField
      FieldName = 'CODIGO_CLIENTE'
    end
    object ibqLogNOME_CLIENTE: TIBStringField
      FieldName = 'NOME_CLIENTE'
      Size = 60
    end
    object ibqLogDATA_HORA_ENVIO: TSQLTimeStampField
      FieldName = 'DATA_HORA_ENVIO'
    end
  end
end
