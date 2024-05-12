object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object fd: TFDConnection
    Params.Strings = (
      'Database=pdv'
      'User_Name=root'
      'Password=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\concretize-uedney\Documents\Embarcadero\Studio\Projects' +
      '\curso_pdv_delphi\libs\libmySQL.dll'
    Left = 160
    Top = 16
  end
  object tb_users: TFDTable
    Active = True
    IndexFieldNames = 'coduser'
    Connection = fd
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'pdv.users'
    Left = 32
    Top = 104
  end
  object query_users: TFDQuery
    Active = True
    Connection = fd
    SQL.Strings = (
      'SELECT * FROM users u;')
    Left = 32
    Top = 168
  end
end
