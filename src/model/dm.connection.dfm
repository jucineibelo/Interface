object Connection: TConnection
  Height = 273
  Width = 446
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\User-J\Desktop\Projetos Delphi\Interface Pesso' +
        'a\db\Dados.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 192
    Top = 40
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 336
    Top = 40
  end
  object qryPessoa: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        'select id, nome, datacadastro, telefone, endereco  from pessoa w' +
        'here id = :id')
    Left = 40
    Top = 120
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryPessoaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryPessoanome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 100
    end
    object qryPessoadataCadastro: TDateTimeField
      FieldName = 'dataCadastro'
      Origin = 'dataCadastro'
    end
    object qryPessoatelefone: TWideStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 50
    end
    object qryPessoaendereco: TWideStringField
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 100
    end
  end
end
